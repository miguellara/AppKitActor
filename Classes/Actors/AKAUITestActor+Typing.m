//
//  AKATestActor+Typing.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKAUITestActor.h"


@implementation AKAUITestActor (Typing)

- (NSControl *)typeText:(NSString *)text onControlMatching:(id<AKAViewMatcher>)matcher
{
	NSControl *control = [self waitForViewMatching:matcher];
	[self typeText:text onControl:control];
	return control;
}

- (NSControl *)typeText:(NSString *)text onControlMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window
{
	NSControl *control = [self waitForViewMatching:matcher inWindow:window];
	[self typeText:text onControl:control];
	return control;
}

- (NSControl *)typeText:(NSString *)text
	  onControlMatching:(id<AKAViewMatcher>)viewMatcher
	   inWindowMatching:(id<AKAWindowMatcher>)windowMatcher
{
	NSControl *control = [self waitForViewMatching:viewMatcher inWindowMatching:windowMatcher];
	[self typeText:text onControl:control];
	return control;
}

- (NSControl *)typeText:(NSString *)text onControlMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview
{
	NSControl *control = [self waitForViewMatching:matcher inView:superview];
	[self typeText:text onControl:control];
	return control;
}

- (void)typeText:(NSString *)text onControl:(NSControl *)control
{
	[control becomeFirstResponder];
	[self setAccessibilityValue:text forAttribute:NSAccessibilityValueAttribute onControl:control];
	[self
	 waitUntil:^BOOL(AKATestActor *actor)
	 {
		 return [control.stringValue isEqualToString:text];
	 }
	 onTimeout:^(AKATestActor *actor, NSTimeInterval timeout)
	 {
		 [self recordFailureWithFormat:@"Typing '%@' into %@ did not change the control's string value", text, control];
	 }];
}

@end
