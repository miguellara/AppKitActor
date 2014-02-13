//
//  AKAUITextFieldMatcher.h
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKAViewMatcher.h"


@interface AKANSTextFieldMatcher : NSObject <AKAViewMatcher>

+ (instancetype)matcherWithPlaceholder:(NSString *)placeholder;

+ (instancetype)matcherWithStringValue:(NSString *)stringValue;

+ (instancetype)matcherWithStaticStringValue:(NSString *)stringValue;

@end
