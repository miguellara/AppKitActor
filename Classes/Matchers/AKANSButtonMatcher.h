//
//  AKAUIButtonMatcher.h
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKAViewMatcher.h"


@interface AKANSButtonMatcher : NSObject <AKAViewMatcher>

+ (instancetype)matcher;

+ (instancetype)matcherWithTitle:(NSString *)title;

@end
