//
//  AKATestActor.m
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "AKATestActor.h"

static NSTimeInterval const kDefaultMaximumCheckWaitTimeInterval = 10.0;
static NSTimeInterval const kCheckRetryTimeInterval = 0.1;
static NSTimeInterval const kDefaultReactionTimeInterval = 0.1;


@interface AKATestActor ()

@property (nonatomic, weak) XCTestCase *testCase;
@property (nonatomic, strong) NSString *file;
@property (nonatomic) NSUInteger line;

@end


@implementation AKATestActor

- (instancetype)initWithTestCase:(XCTestCase *)testCase file:(NSString *)file line:(NSUInteger)line
{
    self = [super init];
    if (self)
	{
		_testCase = testCase;
        _file = file;
		_line = line;
    }
    return self;
}


#pragma mark Waiting

- (void)waitUntil:(AKATestActorConditionBlock)untilBlock onTimeout:(AKATestActorTimeoutBlock)timeoutBlock
{
	[self waitWithTimeout:kDefaultMaximumCheckWaitTimeInterval until:untilBlock onTimeout:timeoutBlock];
}

- (void)waitWithTimeout:(NSTimeInterval)timeout
				  until:(AKATestActorConditionBlock)untilBlock
			  onTimeout:(AKATestActorTimeoutBlock)timeoutBlock
{
	NSTimeInterval timeoutTimestamp = [NSDate timeIntervalSinceReferenceDate] + timeout;
	
	BOOL success = untilBlock(self);
	while (!success && [NSDate timeIntervalSinceReferenceDate] < timeoutTimestamp)
	{
		[self waitForTimeInterval:kCheckRetryTimeInterval];
		success = untilBlock(self);
	}
	
	if (!success)
	{
		timeoutBlock(self, timeout);
	}
}

- (void)standardWaitForReaction
{
	[self waitForTimeInterval:kDefaultReactionTimeInterval];
}

- (void)waitForTimeInterval:(NSTimeInterval)timeInterval
{
	CFRunLoopRunInMode(kCFRunLoopDefaultMode, timeInterval, false);
}


#pragma mark Error reporting

- (void)recordFailureWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
{
	va_list arguments;
    va_start(arguments, format);
	NSString *description = [[NSString alloc] initWithFormat:format arguments:arguments];
    va_end(arguments);
	
	[self recordFailureWithDescription:description];
}

- (void)recordFailureWithDescription:(NSString *)description
{
	[self.testCase recordFailureWithDescription:description inFile:self.file atLine:self.line expected:NO];
}

@end
