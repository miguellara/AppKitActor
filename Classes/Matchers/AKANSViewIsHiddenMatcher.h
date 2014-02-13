//
//  AKAIsHiddenMatcher.h
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKAViewMatcher.h"


@interface AKANSViewIsHiddenMatcher : NSObject <AKAViewMatcher>

+ (instancetype)matcherWithHidden:(BOOL)hidden;

@end
