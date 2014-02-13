//
//  AKAIsHiddenMatcher.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKANSViewIsHiddenMatcher.h"


@interface AKANSViewIsHiddenMatcher ()

@property(nonatomic) BOOL shouldBeHidden;

@end


@implementation AKANSViewIsHiddenMatcher

+ (instancetype)matcherWithHidden:(BOOL)hidden
{
	return [[self alloc] initWithHidden:hidden];
}

- (instancetype)initWithHidden:(BOOL)hidden
{
    self = [super init];
    if (self)
	{
        _shouldBeHidden = hidden;
    }
    return self;
}


#pragma mark AKAViewMatcher methods

- (BOOL)matchesView:(NSView *)view
{
	return (view.isHiddenOrHasHiddenAncestor == self.shouldBeHidden);
}

- (NSString *)debugDescription
{
	return self.shouldBeHidden ? @"is Hidden" : @"is Not Hidden";
}

@end