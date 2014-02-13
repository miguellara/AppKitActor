//
//  AKATestActor+Decrementing.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKAUITestActor.h"


@implementation AKAUITestActor (Decrementing)

- (NSControl *)decrementControlMatching:(id<AKAViewMatcher>)matcher
{
	NSControl *control = [self waitForViewMatching:matcher];
	[self decrementControl:control];
	return control;
}

- (NSControl *)decrementControlMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window
{
	NSControl *control = [self waitForViewMatching:matcher inWindow:window];
	[self decrementControl:control];
	return control;
}

- (NSControl *)decrementControlMatching:(id<AKAViewMatcher>)viewMatcher
					   inWindowMatching:(id<AKAWindowMatcher>)windowMatcher
{
	NSControl *control = [self waitForViewMatching:viewMatcher inWindowMatching:windowMatcher];
	[self decrementControl:control];
	return control;
}

- (NSControl *)decrementControlMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview
{
	NSControl *control = [self waitForViewMatching:matcher inView:superview];
	[self decrementControl:control];
	return control;
}

- (void)decrementControl:(NSControl *)control
{
	id accessibilityElement = [self accessibilityElementInView:control
											  thatHasAttribute:NSAccessibilityDecrementButtonAttribute];
	id decrementButton = [accessibilityElement accessibilityAttributeValue:NSAccessibilityDecrementButtonAttribute];
	if (decrementButton)
	{
		[self clickOnView:decrementButton];
	}
	else
	{
		[self recordFailureWithFormat:@"Unable to decrement value of control %@", [control debugDescription]];
	}
}

@end
