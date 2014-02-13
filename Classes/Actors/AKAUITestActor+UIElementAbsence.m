//
//  AKATestActor+UIElementAbsence.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKAUITestActor.h"


@implementation AKAUITestActor (UIElementAbsence)

- (void)waitForAbsenceOfWindowMatching:(id<AKAWindowMatcher>)matcher
{
	[self
	 waitUntil:^BOOL(AKATestActor *actor)
	 {
		 NSWindow *window = [self windowMatching:matcher];
		 BOOL isAbsent = (window == nil);
		 return isAbsent;
	 }
	 onTimeout:^(AKATestActor *actor, NSTimeInterval timeout)
	 {
		 [self recordFailureWithFormat:@"Timed out trying to detect absence of window matching %@.",
		  [matcher debugDescription]];
	 }];
}

- (void)waitForAbsenceOfViewMatching:(id<AKAViewMatcher>)matcher
{
	[self
	 waitUntil:^BOOL(AKATestActor *actor)
	 {
		 NSView *view = [self viewMatching:matcher];
		 BOOL isAbsent = (view == nil);
		 return isAbsent;
	 }
	 onTimeout:^(AKATestActor *actor, NSTimeInterval timeout)
	 {
		 [self recordFailureWithFormat:@"Timed out trying to detect absence of view in any window matching %@.",
		  [matcher debugDescription]];
	 }];
}

- (void)waitForAbsenceOfViewMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window
{
	NSParameterAssert(window);
	
	[self
	 waitUntil:^BOOL(AKATestActor *actor)
	 {
		 NSView *view = [self viewMatching:matcher inWindow:window];
		 BOOL isAbsent = (view == nil);
		 return isAbsent;
	 }
	 onTimeout:^(AKATestActor *actor, NSTimeInterval timeout)
	 {
		 [self recordFailureWithFormat:@"Timed out trying to detect absence of view in window %@ matching %@.",
		  window, [matcher debugDescription]];
	 }];
}

- (void)waitForAbsenceOfViewMatching:(id<AKAViewMatcher>)viewMatcher inWindowMatching:(id<AKAWindowMatcher>)windowMatcher
{
	NSParameterAssert(windowMatcher);
	
	[self
	 waitUntil:^BOOL(AKATestActor *actor)
	 {
		 NSView *view = [self viewMatching:viewMatcher inWindowMatching:windowMatcher];
		 BOOL isAbsent = (view == nil);
		 return isAbsent;
	 }
	 onTimeout:^(AKATestActor *actor, NSTimeInterval timeout)
	 {
		 [self recordFailureWithFormat:
		  @"Timed out trying to detect absence of view marching %@ in window matching %@.",
		  [viewMatcher debugDescription], [windowMatcher debugDescription]];
	 }];
}

- (void)waitForAbsenceOfViewMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview
{
	NSParameterAssert(superview);
	
	[self
	 waitUntil:^BOOL(AKATestActor *actor)
	 {
		 NSView *view = [self viewMatching:matcher inView:superview];
		 BOOL isAbsent = (view == nil);
		 return isAbsent;
		 
	 }
	 onTimeout:^(AKATestActor *actor, NSTimeInterval timeout)
	 {
		 [self recordFailureWithFormat:@"Timed out trying to detect absence of view in superview %@ matching %@.",
		  superview, [matcher debugDescription]];
	 }];
}


@end
