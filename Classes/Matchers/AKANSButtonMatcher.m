//
//  AKAUIButtonMatcher.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKANSButtonMatcher.h"


@interface AKANSButtonMatcher ()

@property(nonatomic) BOOL filterByTitle;
@property(nonatomic, copy) NSString *title;

@end


@implementation AKANSButtonMatcher

+ (instancetype)matcher
{
	return [[self alloc] init];
}

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
		_filterByTitle = YES;
    }
    return self;
}


#pragma mark AKAViewMatcher methods

- (BOOL)matchesView:(NSButton *)button
{
	BOOL matches = NO;
	if ( [button isKindOfClass:[NSButton class]] )
	{
		matches = !self.filterByTitle || [button.title isEqualToString:self.title];
	}
	return matches;
}

- (NSString *)debugDescription
{
	return self.filterByTitle ? [NSString stringWithFormat:@"is NSButton with title '%@'", self.title] : @"is NSButton";
}

@end
