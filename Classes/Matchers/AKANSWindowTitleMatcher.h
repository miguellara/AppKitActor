//
//  AKANSWindowTitleMatcher.h
//  AppKitActor
//
//  Created by Miguel Lara on 14/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKAWindowMatcher.h"


@interface AKANSWindowTitleMatcher : NSObject <AKAWindowMatcher>

+ (instancetype)matcherWithTitle:(NSString *)title;

@end
