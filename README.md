# AppKitActor

**AppKitActor** is an integration test framework for AppKit applications. It allows for easy automation of Mac OS X applications UI tests, helping developers check the state of UI elements and interact with `NSWindows` and `NSViews`.

It leverages the NSAccessibility to identify views and windows, check their state and interact with them. **AppKitActor** also uses undocumented Apple APIs, which should not be an issue for test builds but must not be included it in the production distributions.

**AppKitActor** is heavily inspired by [KIF](https://github.com/kif-framework/KIF) –a similar integration test framework for iOS. Similar concepts have been applied and even method names have tried to be kept consistent to make transition easier.



---
# Features

## Flexible matchers
Match views, controls and windows by their accessibility traits, values or class. Matchers can be combined using with `AND` and `OR` to build complex conditions.

## Containment aware
Identify specific views inside specific –or matching– windows and superviews.

## Lenient on the UI's timing
Don't fill your test code with sleeps to allow time for AppKit to animate changes or react to actions. **AppKitActor** waits for a reasonable time –10 seconds– for the UI to match the expected check, interspersing time for the main thread to run and retries.

**AppKitActor** can verify both if a UI element exists or if it is absent.

## Multiple window suport
Verify UI elements across multiple windows, including the *Status Bar*.

## Xcode 5 integration
**AppKitActor** reports test failures seamlessly on Xcode 5. See how on [Actor Macros](#actor-macros).


## Why not KIF?
[KIF](https://github.com/kif-framework/KIF) is an excellent framework for iOS, but it is not so easy to decouple from from UIKit.

- The NSAccessibility API is very different from UIAccessibility. You get to appreciate the simplicity of `UIView` when you have to face.
- **AppKitActor** needs to deal with far more widows at the same time in the screen.
- `NSControl`s have their responsibilities spread throughout themselves and their `NSCells`.



---
# Adding AppKitActor to your project

AppKitActor is available through [CocoaPods](http://cocoapods.org). To install it simply add the following lines to your Podfile indicating the appropriate target for your acceptance tests:

	```ruby
	target 'Acceptance Tests', :exclusive => true do
		pod 'AppKitActor', '~> 0.1.0'
	end
	```



---
# Using AppKitActor in your tests


## Import

Import the framework header file on your test files, or your acceptance test's target .pch.

	```objective-c
	#import <AppKitActor/AppKitActor.h>
	```

## Actor Macros

### `tester`
Use the `tester` macro as an entry point to interact with the UI. The macro creates an `AKAUITestActor` instance that can be used to check and interact with windows and views. It also captures the location and current test case to report failures where they are meaningful.

### `system`
Use the `system` macro as an entry point to interact with the application itself and the machine. The macro creates an `AKASystemTestActor` instance, and –like `tester`– captures the location and current test case to report failures where they are meaningful.


## Checking for existence of views

Methods of family `-waitForViewMatching:` check for a view matching the given `<AKAViewMatcher>` definition in any window of the application.

	```objective-c
	id<AKAViewMatcher> viewMatcher = [AKAAccessibilityMatcher matcherWithHelp:@"This is a tooltip"];
	[tester waitForViewMatching:viewMatcher];

	```

Narrow the view to only that inside a given superview:

	```objective-c
	id<AKAViewMatcher> viewMatcher = [AKAAccessibilityMatcher matcherWithHelp:@"This is a tooltip"];
	[tester waitForViewMatching:viewMatcher];
	```

Alternatively, the match can be narrowed by providing the containing window:

	```objective-c
	[tester waitForViewMatching:viewMatcher inWindow:aWindow];
	```

The containing window can even be defined as an `<AKAWindowMatcher>` itself, which makes testing far more flexible:

	```objective-c
	id<AKAWindowMatcher> windowMatcher = [AKANSWindowTitleMatcher matcherWithTitle:@"My Document"];
	[tester waitForViewMatching:viewMatcher inWindowMatching:windowMatcher];
	```

By default `<AKAUITestActor>` will try to locate the view every 0.1 second for a maximum of 10 seconds, pausing to let the main thread execute the UI code. If the maximum time allowed expires without the actor being able to locate the matching view, a failure is recorded and the test moves on. This failure will be reflected on Xcode, pointing to the line where the `tester` macro was used.

If a matching view is found, these methods will return the actual `NSView` (or `NSControl`) instance. If the match was actually performed on the internal `NSCell`, the containing control will be the one returned.


## Checking for absence of views

Methods `-waitForAbsenceOfWindowMatching:`, `-waitForAbsenceOfWindowMatching:inWindow:`, `-waitForAbsenceOfWindowMatching:inWindowMatching:` and `-waitForAbsenceOfWindowMatching:inView:` will wait for a view to disappear from the UI for up to 10 seconds by default.


## Windows

Similar methods are available to verify the existence or absence of windows: `-waitForWindowMatching:` and `-waitForAbsenceOfWindowMatching:`. The former will return the matched window, if successful.


## Actions
Through a `tester` –which creates a `AKAUITestActor`– actions can be performed on matching views.


### Clicking
Methods `-clickOnViewMatching:`, `-clickOnViewMatching:inWindow:`, `-clickOnViewMatching:inWindowMatching:`, `-clickOnViewMatching:inView:` will send a click event to the matching view. Clicks can also be performed through a more directed method `-clickOnView:` if the `NSView` instance itself is available.

To perform the click event:

- `NSControl` instances will receive a `-performClick:` message with `nil` sender.
- If supported by the view, the accessibility action `NSAccessibilityPressAction` will be performed on it.
- Otherwise, fake left mouse button events located at the center of the view will be send through `-mouseDown:` and `-mouseUp:`, in order.


### Typing
Methods `-typeText:onControlMatching:`, `-typeText:onControlMatching:inWindow:`, `-typeText:onControlMatching:inWindowMatching:` and `-typeText:onControlMatching:inView:` will attempt to set accessibility value `NSAccessibilityValueAttribute` with the provided text. These methods will wait until the string value has changed on the control, registering a failure if the verification times out.

Text can also be set through the more directed method `-typeText:onControl:`.

### Incrementing and Decrementing
Incrementing and decrementing are actions typically available on `NSStepper`s.

Methods `-incrementControlMatching:`, `-incrementControlMatching:inWindow:`, `-incrementControlMatching:inWindowMatching:`, `-incrementControlMatching:inView:` and `-incrementControl:` will increment the control's value. To do so, it attempts to locate the element that responds to `NSAccessibilityIncrementButtonAttribute` and click on it. A failure will be registered if not found.

Methods `-decrementControlMatching:`, `-decrementControlMatching:inWindow:`, `-decrementControlMatching:inWindowMatching:`, `-decrementControlMatching:inView:` and `-decrementControl:` will decrement the control's value. To do so, it attempts to locate the element that responds to `NSAccessibilityDecrementButtonAttribute` and click on it. A failure will be registered if not found.



---
# Matchers
There are two different kinds of matchers: ones targetting **NSView** and others targetting **NSWindow** elements.

## Operation matchers
Operation matchers of the same kind using operation classes `AKAANDMatcher` and `AKAORMatcher`. Operation classes themselves are agnostic and can behave both as `<AKAViewMatcher>` and `<AKAWindowMatcher>`. A runtime error will rise if matchers of different kinds are mixed in the same operation.

### AKAANDMatcher
Matches views or windows validated by all submatchers. One or more.

### AKAORMatcher
Matches views or windows validated by at least one of its submatchers.

## View matchers

### AKAAnyNSViewMatcher
Matches any `NSView` instance.
### AKANSButtonMatcher
Matches `NSButton` instances, filtering by:

- Any occurrence.
- An button with a given title.

### AKANSControlIsEnabledMatcher
Matches a `NSControl` instance, given its enabled or disabled state.

### AKANSImageViewMatcher
Matches `NSImageView` instances, filtering by:

- Any occurrence.
- An image view displaying an image with a given name.


### AKANSTextFieldMatcher
Matches `NSTextField` instances, filtering by:

- A text field with a given placeholder text.
- A text field with a given string value.
- A static (non-editable) text field with a given string value. Useful to detect labels.


### AKANSViewIsHiddenMatcher
Matches `NSView` instances, given its hidden or visible state.


## Window matchers
### AKANSAlertWindowMatcher
Matches `NSPanel` instances, typically used for alert windows.

### AKANSStatusBarWindowMatcher
Matches `NSStatusBarWindow` instances.  
Beware: this matcher checks for a private Apple class that represents the application's status bar.

### AKANSWindowTitleMatcher
Matches `NSWindow` instances, filtered by a given title.

## Agnostic matchers
### AKAAccessibilityMatcher
Matches any kind of accessibility attribute value on an `NSView` or `NSWindow` instance, and behave both as `<AKAViewMatcher>` and `<AKAWindowMatcher>`. Accessibility attribute values are listed in AppKit header file *NSAccessibility.h* [^1].

Convenience creation methods are provided for matchers filtering by:

- Accessibility description, when explictely provided.
- Help string, the most natural way to provide it is through the view's tool tip.
- Title, useful for buttons.
- Value, useful for stateful controls.

[^1]:Mind that NSAccessibility is far less standard thatn UIAccessibility on iOS. See Apple's [NSAccessibility documentation](https://developer.apple.com/library/mac/documentation/cocoa/Reference/ApplicationKit/Protocols/NSAccessibility_Protocol/Reference/Reference.html#//apple_ref/doc/c_ref/NSAccessibilityPressAction) for details.

---
# Examples
*To be documented shortly.*



---
# Extending the framework
*To be documented shortly.*



---
# Motivation
**AppKit** was first written inside an app I was developing at **[Karumi](http://www.gokarumi.com)**. In the recent years I have grown up to be convinced by TDD, and started to actively used it both on server backends and iOS applications. Unfortunately I could not find a solution as easy as [KIF](https://github.com/kif-framework/KIF) was for iOS to help me with my acceptance tests.

Collaboration is more than welcome. Please, help us get the testing culture going on Mac apps!

Cheers!  
Miguel Lara – <miguel@gokarumi.com>   
![Go Karumi](Docs/karumi.png)


