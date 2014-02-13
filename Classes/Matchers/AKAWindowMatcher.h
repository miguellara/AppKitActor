//
//  AKAWindowMatcher.h
//  AppKitActor
//
//  Created by Miguel Lara on 14/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AKAWindowMatcher <NSObject>

- (BOOL)matchesWindow:(NSWindow *)window;

@end
