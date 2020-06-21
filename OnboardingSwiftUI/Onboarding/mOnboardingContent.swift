//
//  mOnboardingContent.swift
//  OnboardingSwiftUI
//
//  Created by Ryan on 6/20/20.
//  Copyright © 2020 Wingover. All rights reserved.
//

import SwiftUI

// In addition to changing the three Structs below, please set
// — The "initial view" for your app in "VM VB SortingHat.swift"
// — Modify SceneDelegate.swift to have the rootView be GreatHallView().environmentObject(SortingHat())
// If you encounter odd alignment issues as views progress, you can adjust compensateForOddMargins in func calculateOffsetFor() inside ViewModel Onboarding.swift.

/// The structure for populating all page and button content. Defaults for colors or images consistent across views can be specified here. Currently, the views use SFSymbols, but you can change that code to ask for an image asset.
struct OnboardingPageContent {
    let image: String
    let line1: String
    let line2: String
    let buttonOnSystemImageName: String
    let buttonOffSystemImageName = "circle.fill"
    let buttonOnColor = Color(UIColor.systemTeal)
    let buttonOffColor = Color(UIColor.systemGray4)
}

/// Each entry creates a navigable onboarding page, initialized in V Onboarding.swift.
struct OnboardingContent {

    let pages: [OnboardingPageContent] = [
        OnboardingPageContent(image: "1",
                              line1: "Generate onboarding screens",
                              line2: "by editing an array",
                              buttonOnSystemImageName: "hammer.fill"),

        OnboardingPageContent(image: "2",
                              line1: "Works on iOS, iPadOS",
                              line2: "and MacCatalyst",
                              buttonOnSystemImageName: "heart.fill"),

        OnboardingPageContent(image: "3",
                              line1: "Use touch,",
                              line2: "mouse or keyboard",
                              buttonOnSystemImageName: "keyboard"),

        OnboardingPageContent(image: "4",
                              line1: "Redraws for",
                              line2: "screen orientation",
                              buttonOnSystemImageName: "rotate.right.fill")
    ]

}

/// On the last onboarding page, this button appears to "start the app".
struct OnboardingCompleteButtonContent {
    let label = "Begin"
}
