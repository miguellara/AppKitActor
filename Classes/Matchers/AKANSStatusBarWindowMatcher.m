//
//  AKAStatusItemWindowMatcher.m
//  AppKitActor
//
//  Created by Miguel Lara on 20/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKANSStatusBarWindowMatcher.h"

@implementation AKANSStatusBarWindowMatcher

+ (instancetype)matcher
{
	return [[self alloc] init];
}


#pragma mark AKAWindowMatcher methods

- (BOOL)matchesWindow:(NSWindow *)window
{
	Class klass = NSClassFromString(@"NSStatusBarWindow");
	return [window isKindOfClass:klass];
}

- (NSString *)debugDescription
{
	return @"is Status Bar Window";
}

@end
