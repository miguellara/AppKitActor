//
//  AKATestActor+Clicking.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKAUITestActor.h"

#import "AKAANDMatcher.h"
#import "AKANSControlIsEnabledMatcher.h"


@implementation AKAUITestActor (Clicking)

- (NSView *)clickOnViewMatching:(id<AKAViewMatcher>)matcher
{
	NSView *view = [self waitForViewMatching:matcher];
	[self clickOnView:view];
	return view;
}

- (NSView *)clickOnViewMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window
{
	NSView *view = [self waitForViewMatching:matcher inWindow:window];
	[self clickOnView:view];
	return view;
}

- (NSView *)clickOnViewMatching:(id<AKAViewMatcher>)viewMatcher inWindowMatching:(id<AKAWindowMatcher>)windowMatcher
{
	NSView *view = [self waitForViewMatching:viewMatcher inWindowMatching:windowMatcher];
	[self clickOnView:view];
	return view;
}

- (NSView *)clickOnViewMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview
{
	AKANSControlIsEnabledMatcher *isEnabledMatcher = [AKANSControlIsEnabledMatcher matcherWithEnabled:YES];
	id<AKAViewMatcher> clickableViewMatcher = [AKAANDMatcher matcherWithSubmatchers:@[isEnabledMatcher, matcher]];
	
	NSView *view = [self waitForViewMatching:clickableViewMatcher inView:superview];
	[self clickOnView:view];
	return view;
}

- (void)clickOnView:(NSView *)view
{
	if ([view isKindOfClass:[NSControl class]])
	{
		NSControl *control = (NSControl *) view;
		[control performClick:nil];
	}
	else
	{
		BOOL performedAsAccessibilityAction = [self performAccessibilityAction:NSAccessibilityPressAction onView:view];
		if (!performedAsAccessibilityAction)
		{
			CGPoint locationInView = CGPointMake(view.frame.size.width / 2.f, view.frame.size.height / 2.f);
			CGPoint locationInWindow = [view convertPoint:locationInView toView:view.window.contentView];
			CGPoint locationInScreen = [view.window convertBaseToScreen:locationInWindow];
			
			NSEvent *fakeMouseDownEvent = [NSEvent eventWithCGEvent:CGEventCreateMouseEvent(NULL,
																							kCGEventLeftMouseDown,
																							locationInScreen,
																							kCGMouseButtonLeft)];
			[view mouseDown:fakeMouseDownEvent];
			[self standardWaitForReaction];
			
			
			NSEvent *fakeMouseUpEvent = [NSEvent eventWithCGEvent:CGEventCreateMouseEvent(NULL,
																						  kCGEventLeftMouseDown,
																						  locationInScreen,
																						  kCGMouseButtonLeft)];
			[view mouseUp:fakeMouseUpEvent];
		}
	}
	[self standardWaitForReaction];
}

@end
