//
//  AKAViewMatcher.h
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AKAViewMatcher <NSObject>

- (BOOL)matchesView:(NSView *)view;

@end
