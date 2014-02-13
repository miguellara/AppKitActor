//
//  AKAUITestActor+Internal.m
//  AppKitActor
//
//  Created by Miguel Lara on 23/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKAUITestActor.h"

static NSTimeInterval const kReactionDelay = 0.1;


@implementation AKAUITestActor (Internal)


#pragma mark Finding elements

- (NSWindow *)windowMatching:(id<AKAWindowMatcher>)viewMatcher
{
	NSWindow *matchingWindow = nil;
	
	for (NSWindow *window in [self allVisibleWindows])
	{
		BOOL matches = window.isVisible && [viewMatcher matchesWindow:window];
		if (matches)
		{
			matchingWindow = window;
			break; // shortcut out
		}
	}
	
	return matchingWindow;
}

- (id)viewMatching:(id<AKAViewMatcher>)viewMatcher
{
	NSView *matchingView = nil;
	
	for (NSWindow *window in [self allVisibleWindows])
		 {
			 matchingView = [self drillWindow:window forViewMatching:viewMatcher];
			 if (matchingView != nil) break; // shortcut out
		 }
	
	return matchingView;
}

- (id)viewMatching:(id<AKAViewMatcher>)viewMatcher inWindowMatching:(id<AKAWindowMatcher>)windowMatcher
{
	NSView *matchingView = nil;
	
	for (NSWindow *window in [self allVisibleWindows])
		 {
			 if ([windowMatcher matchesWindow:window])
			 {
				 matchingView = [self drillWindow:window forViewMatching:viewMatcher];
				 if (matchingView != nil) break; // shortcut out
			 }
		 }

	return matchingView;
}

- (id)viewMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window
{
	return [self drillWindow:window forViewMatching:matcher];
}

- (id)viewMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview
{
	return [self drillView:superview forViewMatching:matcher];
}



#pragma mark Drilling

- (NSView *)drillWindow:(NSWindow *)window forViewMatching:(id<AKAViewMatcher>)matcher
{
	NSView *contentView = [window contentView];
	return [self drillView:contentView forViewMatching:matcher];
}

- (NSView *)drillView:(NSView *)view forViewMatching:(id<AKAViewMatcher>)matcher
{
	NSView *matchingView = nil;
	
	BOOL matches = [matcher matchesView:view];
	if (matches)
	{
		matchingView = view;
	}
	else
	{
		for (NSView *subview in view.subviews)
		{
			matchingView = [self drillView:subview forViewMatching:matcher];
			
			if (matchingView)
			{
				break; // shortcut out
			}
		}
	}
	
	return matchingView;
}

- (NSArray *)allVisibleWindows
{
	static dispatch_once_t onceToken;
	static NSPredicate *sVisiblePredicate;
	dispatch_once(&onceToken, ^{
		sVisiblePredicate = [NSPredicate predicateWithBlock:^BOOL(NSWindow *window, NSDictionary *bindings) {
			return window.isVisible;
		}];
	});
	return [[NSApplication sharedApplication].windows filteredArrayUsingPredicate:sVisiblePredicate];
}


#pragma mark Actions

- (BOOL)performAccessibilityAction:(NSString *)action onView:(NSView *)view
{
	NSParameterAssert(view);
	BOOL wasAbleToPerformAction = NO;
	
	NSObject *accessibilityElement = [self accessibilityElementInView:view thatCanPerformAction:action];
	if (accessibilityElement)
	{
		[accessibilityElement accessibilityPerformAction:action];
		wasAbleToPerformAction = YES;
	}
	
	return wasAbleToPerformAction;
}


#pragma mark Values

- (void)setAccessibilityValue:(id)value forAttribute:(NSString *)attribute onControl:(NSControl *)control
{
	NSParameterAssert(control);
	
	NSObject *accessibilityElement = [self accessibilityElementInView:control thatCanSetAttribute:attribute];
	if (accessibilityElement)
	{
		[accessibilityElement accessibilitySetValue:value forAttribute:attribute];
		
		[control setNeedsDisplay];
	}
	else
	{
		[self recordFailureWithFormat:@"Unable to set value for attribute %@ on view %@", attribute, control];
	}
}


#pragma mark Accessibility Elements

- (NSObject *)accessibilityElementInView:(NSView *)view thatHasAttribute:(NSString *)accessibilityAttribute
{
	NSObject *accessibilityElement = nil;
	
	if ([view.accessibilityAttributeNames containsObject:accessibilityAttribute])
	{
		accessibilityElement = view;
	}
	else if ([view isKindOfClass:[NSControl class]])
	{
		NSCell *cell = [(NSControl *)view cell];
		if ([cell.accessibilityAttributeNames containsObject:accessibilityAttribute])
		{
			accessibilityElement = cell;
		}
	}
	
	return accessibilityElement;
}

- (NSObject *)accessibilityElementInView:(NSView *)view thatCanSetAttribute:(NSString *)attribute
{
	NSObject *accessibilityElement = nil;
	
	if ([view.accessibilityAttributeNames containsObject:attribute]
		&& [view accessibilityIsAttributeSettable:attribute])
	{
		accessibilityElement = view;
	}
	else if ([view isKindOfClass:[NSControl class]])
	{
		NSCell *cell = [(NSControl *)view cell];
		if ([cell.accessibilityAttributeNames containsObject:attribute]
			&& [cell accessibilityIsAttributeSettable:attribute])
		{
			accessibilityElement = cell;
		}
	}
	
	return accessibilityElement;
}

- (NSObject *)accessibilityElementInView:(NSView *)view thatCanPerformAction:(NSString *)action
{
	NSObject *accessibilityElement = nil;
	
	if ([view.accessibilityActionNames containsObject:action])
	{
		accessibilityElement = view;
	}
	else if ([view isKindOfClass:[NSControl class]])
	{
		NSCell *cell = [(NSControl *)view cell];
		if ([cell.accessibilityActionNames containsObject:action])
		{
			accessibilityElement = cell;
		}
	}
	
	return accessibilityElement;
}

@end
