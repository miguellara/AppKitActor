//
//  AKASystemTestActor.h
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKATestActor.h"

#define system AKA_TEST_ACTOR_WITH_CLASS(AKASystemTestActor)


@interface AKASystemTestActor : AKATestActor

- (void)waitForApplicationToLaunch;

@end
