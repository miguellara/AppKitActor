//
//  AKANSControlIsEnabledMatcher.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKANSControlIsEnabledMatcher.h"


@interface AKANSControlIsEnabledMatcher ()

@property(nonatomic) BOOL shouldBeEnabled;

@end


@implementation AKANSControlIsEnabledMatcher

+ (instancetype)matcherWithEnabled:(BOOL)enabled
{
	return [[self alloc] initWithEnabled:enabled];
}

- (instancetype)initWithEnabled:(BOOL)enabled
{
    self = [super init];
    if (self)
	{
        _shouldBeEnabled = enabled;
    }
    return self;
}


#pragma mark AKAViewMatcher methods

- (BOOL)matchesView:(NSControl *)control
{
	BOOL matches = NO;
	if ( [control isKindOfClass:[NSControl class]] )
	{
		if (self.shouldBeEnabled)
		{
			matches = [control isEnabled] && ![control isHiddenOrHasHiddenAncestor];
		}
		else
		{
			matches = ![control isEnabled] || [control isHiddenOrHasHiddenAncestor];
		}
	}
	return matches;
}

- (NSString *)debugDescription
{
	return self.shouldBeEnabled ? @"is Enabled" : @"is Not Enabled";
}

@end
