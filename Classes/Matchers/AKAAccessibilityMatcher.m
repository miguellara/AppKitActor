//
//  AKAAccessibilityDescriptionMatcher.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKAAccessibilityMatcher.h"


@interface AKAAccessibilityMatcher ()

@property(nonatomic, copy) NSString *attribute;
@property(nonatomic, copy) id value;

@end


@implementation AKAAccessibilityMatcher

+ (instancetype)matcherWithDescription:(NSString *)description
{
	return [self matcherWithAccessibilityAttribute:NSAccessibilityDescriptionAttribute value:[description copy]];
}

+ (instancetype)matcherWithHelp:(NSString *)help
{
	return [self matcherWithAccessibilityAttribute:NSAccessibilityHelpAttribute value:[help copy]];
}

+ (instancetype)matcherWithTitle:(NSString *)title
{
	return [self matcherWithAccessibilityAttribute:NSAccessibilityTitleAttribute value:[title copy]];
}

+ (instancetype)matcherWithValue:(NSString *)value
{
	return [self matcherWithAccessibilityAttribute:NSAccessibilityValueAttribute value:[value copy]];
}

+ (instancetype)matcherWithAccessibilityAttribute:(NSString *)attribute value:(id)value
{
	return [[self alloc] initWithAccessibilityAttribute:attribute value:value];
}

- (instancetype)initWithAccessibilityAttribute:(NSString *)attribute value:(NSString *)value
{
    self = [super init];
    if (self)
	{
		_attribute = [attribute copy];
        _value = value;
    }
    return self;
}


#pragma mark AKAViewMatcher methods

- (BOOL)matchesView:(NSView *)view
{
	return [self accessibilityElementMatches:view];
}


#pragma mark AKAViewMatcher methods

- (BOOL)matchesWindow:(NSWindow *)window
{
	return [self accessibilityElementMatches:window];
}


#pragma mark Shared implementation

- (BOOL)accessibilityElementMatches:(NSObject *)accessibilityElement
{
	BOOL matches = NO;
	if ([accessibilityElement.accessibilityAttributeNames containsObject:self.attribute])
	{
		id existingValue = [accessibilityElement accessibilityAttributeValue:self.attribute];
		if ([existingValue isKindOfClass:[NSString class]])
		{
			matches = [existingValue isEqualToString:self.value];
		}
		else
		{
			matches = [existingValue isEqual:self.value];
		}
	}
	return matches;
}

- (NSString *)debugDescription
{
	return [NSString stringWithFormat:@"has accessibility attribute '%@' with value '%@'", self.attribute, self.value];
}

@end
