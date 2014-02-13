//
//  AKAAnyNSViewMatcher.h
//  AppKitActor
//
//  Created by Miguel Lara on 20/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKAViewMatcher.h"


@interface AKAAnyNSViewMatcher : NSObject <AKAViewMatcher>

+ (instancetype)matcher;

@end
