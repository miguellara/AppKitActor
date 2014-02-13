//
//  AKANSImageViewMatcher.m
//  AppKitActor
//
//  Created by Miguel Lara on 05/02/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKANSImageViewMatcher.h"


@interface AKANSImageViewMatcher ()
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic) BOOL filterByImageName;

@end


@implementation AKANSImageViewMatcher

+ (instancetype)matcher
{
	return [[self alloc] init];
}

+ (instancetype)matcherWithImageName:(NSString *)imageName
{
	return [[self alloc] initWithImageName:imageName];
}

- (instancetype)init
{
    self = [super init];
    if (self)
	{
        _filterByImageName = NO;
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName
{
    self = [self init];
    if (self)
	{
		_imageName = [imageName copy];
		_filterByImageName = YES;
    }
    return self;
}


#pragma mark AKAViewMatcher methods

- (BOOL)matchesView:(NSImageView *)view
{
	BOOL matches = NO;
	if ([view isKindOfClass:[NSImageView class]])
	{
		matches = !self.filterByImageName || [view.image.name isEqualToString:self.imageName];
	}
	return matches;
}

- (NSString *)debugDescription
{
	return (self.filterByImageName
			? [NSString stringWithFormat:@"is NSImageView with image named '%@'", self.imageName]
			: @"is NSImageView");
}

@end
