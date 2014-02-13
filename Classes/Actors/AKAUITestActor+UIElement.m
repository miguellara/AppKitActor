//
//  AKATestActor+UIElement.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKAUITestActor.h"


@implementation AKAUITestActor (UIElement)

- (NSWindow *)waitForWindowMatching:(id<AKAWindowMatcher>)matcher
{
	__block NSWindow *matchingWindow = nil;
	
	[self
	 waitUntil:^BOOL(AKATestActor *actor)
	 {
		 matchingWindow = [self windowMatching:matcher];
		 BOOL found = (matchingWindow != nil);
		 return found;
	 }
	 onTimeout:^(AKATestActor *actor, NSTimeInterval timeout)
	 {
		 [self recordFailureWithFormat:@"Timed out trying to find window matching %@.", [matcher debugDescription]];
	 }];
	
	return matchingWindow;
}

- (id)waitForViewMatching:(id<AKAViewMatcher>)matcher
{
	__block NSView *matchingView = nil;
	
	[self
	 waitUntil:^BOOL(AKATestActor *actor)
	 {
		 matchingView = [self viewMatching:matcher];
		 BOOL found = (matchingView != nil);
		 return found;
	 }
	 onTimeout:^(AKATestActor *actor, NSTimeInterval timeout)
	 {
		 [self recordFailureWithFormat:@"Timed out trying to find view in any window matching %@.",
		  [matcher debugDescription]];
	 }];
	
	return matchingView;
}

- (id)waitForViewMatching:(id<AKAViewMatcher>)viewMatcher inWindowMatching:(id<AKAWindowMatcher>)windowMatcher
{
	NSParameterAssert(windowMatcher);
	__block NSView *matchingView = nil;
	
	[self
	 waitUntil:^BOOL(AKATestActor *actor)
	 {
		 matchingView = [self viewMatching:viewMatcher inWindowMatching:windowMatcher];
		 BOOL found = (matchingView != nil);
		 return found;
	 }
	 onTimeout:^(AKATestActor *actor, NSTimeInterval timeout) {
		 [self recordFailureWithFormat:@"Timed out trying to find view matching %@, in window matching %@.",
		  [viewMatcher debugDescription], [windowMatcher debugDescription]];
	 }];
	
	return matchingView;
}

- (id)waitForViewMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window
{
	NSParameterAssert(window);
	__block NSView *matchingView = nil;
	
	[self
	 waitUntil:^BOOL(AKATestActor *actor)
	 {
		 matchingView = [self viewMatching:matcher inWindow:window];
		 BOOL found = (matchingView != nil);
		 return found;
	 }
	 onTimeout:^(AKATestActor *actor, NSTimeInterval timeout)
	 {
		 [self recordFailureWithFormat:@"Timed out trying to find view in window %@ matching %@.",
		  window, [matcher debugDescription]];
	 }];
	
	return matchingView;
}

- (id)waitForViewMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview
{
	NSParameterAssert(superview);
	__block NSView *matchingView = nil;
	
	[self
	 waitUntil:^BOOL(AKATestActor *actor) {
		 matchingView = [self viewMatching:matcher inView:superview];
		 BOOL found = (matchingView != nil);
		 return found;
	 }
	 onTimeout:^(AKATestActor *actor, NSTimeInterval timeout)
	 {
		 [self recordFailureWithFormat:@"Timed out trying to find view in view %@ matching %@.",
		  superview, [matcher debugDescription]];
	 }];
	
	return matchingView;
}


@end
