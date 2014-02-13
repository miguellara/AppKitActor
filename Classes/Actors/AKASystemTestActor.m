//
//  AKASystemTestActor.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKASystemTestActor.h"


@implementation AKASystemTestActor

- (void)waitForApplicationToLaunch
{
	NSApplication *app = [NSApplication sharedApplication];
	[self waitUntil:^BOOL(AKATestActor *actor) {
		return [app isRunning];
		
	} onTimeout:^void(AKATestActor *actor, NSTimeInterval timeout) {
		[self recordFailureWithFormat:@"Application did not become active in %lf.", timeout];
	}];
}

@end
