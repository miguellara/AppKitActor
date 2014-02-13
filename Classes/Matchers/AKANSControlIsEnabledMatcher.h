//
//  AKANSControlIsEnabledMatcher.h
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKAViewMatcher.h"


@interface AKANSControlIsEnabledMatcher : NSObject <AKAViewMatcher>

+ (instancetype)matcherWithEnabled:(BOOL)enabled;

@end
