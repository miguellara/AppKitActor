//
//  AKANSAlertWindowMatcher.m
//  AppKitActor
//
//  Created by Miguel Lara on 20/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKANSAlertWindowMatcher.h"


@interface AKANSAlertWindowMatcher ()

@end


@implementation AKANSAlertWindowMatcher

+ (instancetype)matcher
{
	return [[self alloc] init];
}


#pragma mark AKAViewMatcher methods

- (BOOL)matchesWindow:(NSWindow *)window
{
	return [window isKindOfClass:[NSPanel class]];
}

- (NSString *)debugDescription
{
	return @"is alert";
}

@end
