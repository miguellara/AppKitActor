//
//  AKANSWindowTitleMatcher.m
//  AppKitActor
//
//  Created by Miguel Lara on 14/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKANSWindowTitleMatcher.h"


@interface AKANSWindowTitleMatcher ()

@property(nonatomic, copy) NSString *title;

@end



@implementation AKANSWindowTitleMatcher

+ (instancetype)matcherWithTitle:(NSString *)title
{
	return [[self alloc] initWithTitle:title];
}

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self)
	{
        _title = [title copy];
    }
    return self;
}


#pragma mark AKAViewMatcher methods

- (BOOL)matchesWindow:(NSWindow *)window
{
	return [window.title isEqualToString:self.title];
}

- (NSString *)debugDescription
{
	return [NSString stringWithFormat:@"with title '%@'", self.title];
}


@end
