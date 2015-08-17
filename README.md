pod-cocoa-touch-framework
=========================

This repo addresses an issue with cocoapods which I'm not able to solve. Help wanted 😎

# The Goal
The goal is to split UI code and business logic. The business logic should be capusled in a seperate framework. A Cocooa Touch Framework.

# How I did it
1. Create a new Xcode Project -> Choose Single View Application.
2. Add a new Target -> Choose Cocoa Touch Framework.
3. Run `pod init`.
4. Add some pods in the `Podfile` for each target.
5. Run `pod install`.
6. Implement some code in the UI and Framework (See ViewController.swift and Utils.swift)

# On Simulator
This runs on the simulator properly.

# On Device
This project can not be run on a device. The error which shows up is the following:
```
dyld: Library not loaded: @rpath/SwiftAddressBook.framework/SwiftAddressBook
  Referenced from: /private/var/mobile/Containers/Bundle/Application/48E58889-78D4-4D71-B8DA-154ADEB98894/Pod Error Framework.app/Frameworks/PodErrorKit.framework/PodErrorKit
  Reason: image not found
```

# The Solution
To be found...
