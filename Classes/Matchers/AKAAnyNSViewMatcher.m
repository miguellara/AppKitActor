//
//  AKAAnyNSViewMatcher.m
//  AppKitActor
//
//  Created by Miguel Lara on 20/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKAAnyNSViewMatcher.h"


@implementation AKAAnyNSViewMatcher

+ (instancetype)matcher
{
	return [[self alloc] init];
}


#pragma mark AKAViewMatcher

- (BOOL)matchesView:(NSView *)view
{
	return [view isKindOfClass:[NSView class]];
}

- (NSString *)debugDescription
{
	return @"is any view";
}

@end
