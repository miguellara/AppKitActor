//
//  AKATestActor+Incrementing.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKAUITestActor.h"


@implementation AKAUITestActor (Incrementing)

- (NSControl *)incrementControlMatching:(id<AKAViewMatcher>)matcher
{
	NSControl *control = [self waitForViewMatching:matcher];
	[self incrementControl:control];
	return control;
}

- (NSControl *)incrementControlMatching:(id<AKAViewMatcher>)matcher inWindow:(NSWindow *)window
{
	NSControl *control = [self waitForViewMatching:matcher inWindow:window];
	[self incrementControl:control];
	return control;
}

- (NSControl *)incrementControlMatching:(id<AKAViewMatcher>)viewMatcher
					   inWindowMatching:(id<AKAWindowMatcher>)windowMatcher
{
	NSControl *control = [self waitForViewMatching:viewMatcher inWindowMatching:windowMatcher];
	[self incrementControl:control];
	return control;
}

- (NSControl *)incrementControlMatching:(id<AKAViewMatcher>)matcher inView:(NSView *)superview
{
	NSControl *control = [self waitForViewMatching:matcher inView:superview];
	[self incrementControl:control];
	return control;
}

- (void)incrementControl:(NSControl *)control
{
	id accessibilityElement = [self accessibilityElementInView:control
											  thatHasAttribute:NSAccessibilityIncrementButtonAttribute];
	id incrementButton = [accessibilityElement accessibilityAttributeValue:NSAccessibilityIncrementButtonAttribute];
	if (incrementButton)
	{
		[self clickOnView:incrementButton];
	}
	else
	{
		[self recordFailureWithFormat:@"Unable to increment value of control %@", [control debugDescription]];
	}
}

@end
