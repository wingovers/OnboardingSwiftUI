# OnboardingSwiftUI
Edit one array to generate onboarding screens and navigation buttons for MacCatalyst, iPadOS, and iOS

== HOW TO USE ==
1. Customize the onboarding caurosel by:
- Editing the basic content and possible fields in "mOnboardingContent.swift"
- Editing the template OnboardingPage in "vOnboardingPage.swift"
- A background color for the whole caurosel is currently set at the bottom of "vOnboarding.swift", but you can move and override that.

2. Hook it up:
- In "SceneDelegate.swift" initialize the Harry Potter-themed SortingHat for the GreatHallView.
- In "SortingHat.swift" change InitialView to your app's first view. No need to pass it that ObservableObject, unless you want to call a function to redo onboarding.


== ABOUT ==

After first learning to program a month ago, I tried making an onboarding screen for my first app in SwiftUI. Tutorials took different routes that didn't cover all the bases:
- Didn't work in MacOS
- Didn't have keyboard shortcuts
- Didn't flip well in landscape
- Used hard-coded logic that didn't scale easily when adding or subtracting pages

My goal was to create a simpler onboarding setup that I could revisit later without remembering all the details. Hope it helps, but also please send me tips to learn how to better organize it and code more clearly/concisely.
