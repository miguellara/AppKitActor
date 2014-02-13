//
//  AKAAccessibilityDescriptionMatcher.h
//  AppKitActor
//
//  Created by Miguel Lara on 13/01/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKAViewMatcher.h"
#import "AKAWindowMatcher.h"

@interface AKAAccessibilityMatcher : NSObject <AKAViewMatcher, AKAWindowMatcher>

/**
 @abstract Convenience method that will match against the view's \c NSAccessibilityDescriptionAttribute.
 */
+ (instancetype)matcherWithDescription:(NSString *)description;

/*!
 @abstract Convenience method that will match against the view's \c NSAccessibilityHelpAttribute.
 @abstract The most natural way to set the help attribute on a view is though its Tool Tip.
 @see -setToolTip: on NSView
 */
+ (instancetype)matcherWithHelp:(NSString *)help;

/*!
 @abstract Convenience method that will match against the view's \c NSAccessibilityTitleAttribute.
 */
+ (instancetype)matcherWithTitle:(NSString *)title;

/*!
 @abstract Convenience method that will match against the view's \c NSAccessibilityValueAttribute.
 */
+ (instancetype)matcherWithValue:(NSString *)value;


+ (instancetype)matcherWithAccessibilityAttribute:(NSString *)attribute value:(id)value;

@end
