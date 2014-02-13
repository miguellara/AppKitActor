//
//  AKANSImageViewMatcher.h
//  AppKitActor
//
//  Created by Miguel Lara on 05/02/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKAViewMatcher.h"

@interface AKANSImageViewMatcher : NSObject <AKAViewMatcher>

+ (instancetype)matcher;

+ (instancetype)matcherWithImageName:(NSString *)imageName;

@end
