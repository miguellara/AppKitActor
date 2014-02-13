//
//  AKAUITextFieldMatcher.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKANSTextFieldMatcher.h"

/*!
 Class Cluster
 @see https://developer.apple.com/library/mac/documentation/general/conceptual/devpedia-cocoacore/ClassCluster.html
 */

#pragma mark -

@interface _AKANSTextFieldPlaceholderMatcher : AKANSTextFieldMatcher
@property (nonatomic, copy) NSString *placeholder;

@end


@implementation _AKANSTextFieldPlaceholderMatcher

- (instancetype)initWithPlaceholder:(NSString *)placeholder
{
    self = [super init];
    if (self)
	{
        _placeholder = [placeholder copy];
    }
    return self;
}

- (BOOL)matchesView:(NSTextField *)textField
{
	BOOL matches = NO;
	if ([super matchesView:textField])
	{
		NSString *actual = ((NSTextFieldCell *)textField.cell).placeholderString;
		matches = [actual isEqualToString:self.placeholder];
	}
	return matches;
}

- (NSString *)debugDescription
{
	return [NSString stringWithFormat:@"is NSTextField with placeholder '%@'", self.placeholder];
}

@end



#pragma mark -

@interface _AKANSTextFieldStringValueMatcher : AKANSTextFieldMatcher
@property (nonatomic, copy) NSString *stringValue;
@property(nonatomic) BOOL checkThatItIsStatic;

@end


@implementation _AKANSTextFieldStringValueMatcher

- (instancetype)initWithStringValue:(NSString *)stringValue
{
    self = [super init];
    if (self)
	{
        _stringValue = [stringValue copy];
		_checkThatItIsStatic = NO;
    }
    return self;
}

- (BOOL)matchesView:(NSTextField *)textField
{
	BOOL matches = NO;
	if ([super matchesView:textField])
	{
		BOOL matchesOptionalStaticCheck = !(self.checkThatItIsStatic && textField.isEditable);
		matches = matchesOptionalStaticCheck && [textField.stringValue isEqualToString:self.stringValue];
	}
	return matches;
}

- (NSString *)debugDescription
{
	NSString *staticInfix = self.checkThatItIsStatic ? @"static " : @"";
	return [NSString stringWithFormat:@"is %@NSTextField with value '%@'", staticInfix, self.stringValue];
}

@end



#pragma mark - Base class in the cluster

@implementation AKANSTextFieldMatcher

+ (instancetype)matcherWithPlaceholder:(NSString *)placeholder
{
	return [[_AKANSTextFieldPlaceholderMatcher alloc] initWithPlaceholder:placeholder];
}

+ (instancetype)matcherWithStringValue:(NSString *)stringValue
{
	return [[_AKANSTextFieldStringValueMatcher alloc] initWithStringValue:stringValue];
}

+ (instancetype)matcherWithStaticStringValue:(NSString *)stringValue
{
	_AKANSTextFieldStringValueMatcher *matcher = [[_AKANSTextFieldStringValueMatcher alloc]
												  initWithStringValue:stringValue];
	matcher.checkThatItIsStatic = YES;
	return matcher;
}

- (BOOL)matchesView:(NSTextField *)textField
{
	return [textField isKindOfClass:[NSTextField class]];
}

- (NSString *)debugDescription
{
	return @"is NSTextField";
}

@end
