# OnboardingSwiftUI
Edit one array to generate onboarding screens and navigation buttons for MacCatalyst, iPadOS, and iOS

## HOW TO USE
1. Customize the onboarding caurosel by:
- Editing the basic content and possible fields in "mOnboardingContent.swift"
- Editing the template OnboardingPage in "vOnboardingPage.swift"
- A background color for the whole caurosel is currently set at the bottom of "vOnboarding.swift", but you can move and override that.

2. Hook it up:
- In "SceneDelegate.swift" initialize the Harry Potter-themed SortingHat for the GreatHallView.
- In "SortingHat.swift" change InitialView to your app's first view. No need to pass it that ObservableObject, unless you want to call a function to redo onboarding.


## ABOUT
After first learning to program a month ago, I tried making an onboarding screen for my first app using SwiftUI for iPadOS and MacCatalyst. Several tutorials took different routes that had quirks:
- Didn't work in MacOS
- Didn't have keyboard shortcuts
- Didn't render well in different orientations or device sizes
- Didn't respond fluidly with animation to touch
- Used hard-coded logic that didn't scale easily when adding or subtracting pages
- Relied on UIKit

My goal was to create a simpler onboarding setup that I could revisit later without remembering all the details. Hope it helps, but also please send me tips to learn how to better organize it and code more clearly/concisely.

**Problems with my v1**
- Design of my OnboardingPage fits just a couple short lines of text. But you can change that.
- I wish I could write the onboarding viewmodel as a class, rather than as an extension. That would make the Views more concise. But I couldn't sort in my beginner's head how to modify the sortingHat (ViewRouter) ObservableObject from another ViewModel class — or avoid placing all the onboarding functions into that sortingHat ObservableObject, which would load them even if no onboarding screens will be displayed.
- You'll probably find more than that.

## CREDITS
These tutorials helped me understand what to do:

**Onboarding**
* AJ Picard: https://www.youtube.com/watch?v=brUrG0JsBgw&feature=youtu.be&app=desktop#menu
* Farukh Academy: https://www.youtube.com/watch?v=toyI7znf4Rg
* Farukh Academy (2): https://www.youtube.com/watch?v=61FxTbxrJmQ&t
* Blckbirds: https://blckbirds.com/post/how-to-create-a-onboarding-screen-in-swiftui-1/
* Liquid Coder: https://www.youtube.com/watch?v=MUsofD-uvtw 
* Liquid Coder  (2): https://liquidcoder.com/swiftui-onboarding-screen/

**MacCatalyst Hover Recognition**
* Paul Colton: https://stackoverflow.com/questions/60001653/how-to-implement-onhover-event-with-catalyst

**MacCatalyst and iPadOS Keyboard Shortcuts**
* emcro: https://github.com/emcro/SwiftUI-Keyboard-Demo
