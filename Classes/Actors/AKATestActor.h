//
//  AKATestActor.h
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@class AKATestActor;


typedef BOOL(^AKATestActorConditionBlock)(AKATestActor *actor);
typedef void(^AKATestActorTimeoutBlock)(AKATestActor *actor, NSTimeInterval timeout);


#define AKA_TEST_ACTOR_WITH_CLASS(aClass) [[aClass alloc] initWithTestCase:self file:[NSString stringWithUTF8String: __FILE__ ] line: __LINE__ ]


@interface AKATestActor : NSObject

@property (nonatomic, weak, readonly) XCTestCase *testCase;
@property (nonatomic, strong, readonly) NSString *file;
@property (nonatomic, readonly) NSUInteger line;


- (instancetype)initWithTestCase:(XCTestCase *)testCase file:(NSString *)file line:(NSUInteger)line;

- (void)waitUntil:(AKATestActorConditionBlock)untilBlock
		onTimeout:(AKATestActorTimeoutBlock)timeoutBlock;

- (void)waitWithTimeout:(NSTimeInterval)timeout
				  until:(AKATestActorConditionBlock)untilBlock
			  onTimeout:(AKATestActorTimeoutBlock)timeoutBlock;

- (void)standardWaitForReaction;

- (void)waitForTimeInterval:(NSTimeInterval)timeInterval;


- (void)recordFailureWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

- (void)recordFailureWithDescription:(NSString *)description;

@end
