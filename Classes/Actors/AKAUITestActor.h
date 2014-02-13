//
//  AKATestActor.h
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKATestActor.h"

#import "AKAViewMatcher.h"
#import "AKAWindowMatcher.h"

#define tester AKA_TEST_ACTOR_WITH_CLASS(AKAUITestActor)


@interface AKAUITestActor : AKATestActor
@end



@interface AKAUITestActor (UIElement)

- (NSWindow *)waitForWindowMatching:(id<AKAWindowMatcher>)matcher;

- (id)waitForViewMatching:(id<AKAViewMatcher>)matcher;

- (id)waitForViewMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window;

- (id)waitForViewMatching:(id<AKAViewMatcher>)viewMatcher inWindowMatching:(id<AKAWindowMatcher>)windowMatcher;

- (id)waitForViewMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview;

@end



@interface AKAUITestActor (UIElementAbsence)

- (void)waitForAbsenceOfWindowMatching:(id<AKAWindowMatcher>)matcher;

- (void)waitForAbsenceOfViewMatching:(id<AKAViewMatcher>)matcher;

- (void)waitForAbsenceOfViewMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window;

- (void)waitForAbsenceOfViewMatching:(id<AKAViewMatcher>)viewMatcher
					inWindowMatching:(id<AKAWindowMatcher>)windowMatcher;

- (void)waitForAbsenceOfViewMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview;

@end



@interface AKAUITestActor (Clicking)

- (NSView *)clickOnViewMatching:(id<AKAViewMatcher>)matcher;

- (NSView *)clickOnViewMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window;

- (NSView *)clickOnViewMatching:(id<AKAViewMatcher>)viewMatcher inWindowMatching:(id<AKAWindowMatcher>)windowMatcher;

- (NSView *)clickOnViewMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview;

- (void)clickOnView:(NSView *)view;

@end



@interface AKAUITestActor (Typing)

- (NSControl *)typeText:(NSString *)text onControlMatching:(id<AKAViewMatcher>)matcher;

- (NSControl *)typeText:(NSString *)text onControlMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window;

- (NSControl *)typeText:(NSString *)text
	  onControlMatching:(id<AKAViewMatcher>)viewMatcher
	   inWindowMatching:(id<AKAWindowMatcher>)windowMatcher;

- (NSControl *)typeText:(NSString *)text onControlMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview;

- (void)typeText:(NSString *)text onControl:(NSControl *)control;

@end



@interface AKAUITestActor (Incrementing)

- (NSControl *)incrementControlMatching:(id<AKAViewMatcher>)matcher;

- (NSControl *)incrementControlMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window;

- (NSControl *)incrementControlMatching:(id<AKAViewMatcher>)viewMatcher
	   inWindowMatching:(id<AKAWindowMatcher>)windowMatcher;

- (NSControl *)incrementControlMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview;

- (void)incrementControl:(NSControl *)control;

@end



@interface AKAUITestActor (Decrementing)

- (NSControl *)decrementControlMatching:(id<AKAViewMatcher>)matcher;

- (NSControl *)decrementControlMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window;

- (NSControl *)decrementControlMatching:(id<AKAViewMatcher>)viewMatcher
					   inWindowMatching:(id<AKAWindowMatcher>)windowMatcher;

- (NSControl *)decrementControlMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview;

- (void)decrementControl:(NSControl *)control;

@end



@interface AKAUITestActor (Internal)

// UIElements
- (NSWindow *)windowMatching:(id<AKAWindowMatcher>)viewMatcher;

- (id)viewMatching:(id<AKAViewMatcher>)viewMatcher;

- (id)viewMatching:(id<AKAViewMatcher>)viewMatcher inWindowMatching:(id<AKAWindowMatcher>)windowMatcher;

- (id)viewMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window;

- (id)viewMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview;


// Accessibility Element Actions
- (BOOL)performAccessibilityAction:(NSString *)action onView:(NSView *)view;


// Accessibility Element Values
- (void)setAccessibilityValue:(id)value forAttribute:(NSString *)attribute onControl:(NSControl *)control;


// Accessibility Elements
- (NSObject *)accessibilityElementInView:(NSView *)view thatHasAttribute:(NSString *)attribute;

- (NSObject *)accessibilityElementInView:(NSView *)view thatCanSetAttribute:(NSString *)attribute;

- (NSObject *)accessibilityElementInView:(NSView *)view thatCanPerformAction:(NSString *)action;

@end
