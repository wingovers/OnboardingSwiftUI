//
//  vControlButtons.swift
//  OnboardingSwiftUI
//
//  Created by Ryan on 6/20/20.
//  Copyright © 2020 Wingover. All rights reserved.
//


import SwiftUI

// MARK: - Template for each progress indicator at the bottom of the view
// Model OnboardingContent.swift specifies a custom "on" state (buttonOnSystemImage)
// and a default or per-item customized "off" state (buttonOffSystemImageName).
struct OnboardingProgressIndicators: View {

    @Binding var currentPage: Int
    var pageNumber: Int
    var content: OnboardingPageContent

    @State private var isHovering = false

    var body: some View {
        Button(action: { self.currentPage = self.pageNumber }) {
            Image(systemName: "\(self.currentPage == self.pageNumber ? content.buttonOnSystemImageName : content.buttonOffSystemImageName)")
                .padding()
                .pulseWhen(isHovering)
                .scaleEffect(currentPage == pageNumber ? 1.5 : 0.5)
                .scaleEffect(isHovering && currentPage != pageNumber ? 3 : 1)
                .scaleEffect(isHovering && currentPage == pageNumber ? 1.23 : 1)
                .accentColor(currentPage == pageNumber ? content.buttonOnColor : content.buttonOffColor)
        }
        .isHoveringCatalyst { self.isHovering = $0 }
        .onTapGesture { self.currentPage = self.pageNumber }
        .animation(.interactiveSpring())
    }
}

// MARK: - Transient complete onboarding button
struct OnboardingCompleteButton: View {
    let content = OnboardingCompleteButtonContent()

    @Binding var trigger: Bool

    var body: some View {
        HStack {
            Text(content.label)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding()
                .background(Color(UIColor.systemTeal))
                .foregroundColor(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .pulseWhen(trigger)
                .isHoveringCatalyst { self.trigger = $0 }
        }.frame(width: 150, height: 50)

    }
}

// MARK: - Transient advance onboarding page indicator (helpful for MacOS UI)
extension OnboardingView {
    func showChevron() -> some View {
        return Image(systemName: "chevron.compact.right")
            .actLikeNavButton(trigger: $isHoveringRightChevron, colorsFrom: pages[0])
    }
}

// MARK: - Styling and animation for the buttons flanking the page indicators for going forward or backgward (helpful for MacOS UI)
struct ActLikeNavButton: ViewModifier {
    @Binding var trigger: Bool
    var colors: OnboardingPageContent

    func body(content: Content) -> some View {
        return content
            .pulseWhen(trigger)
            .scaleEffect(trigger ? 2.8 : 2.2)
            .frame(width: 150, height: 70)
            .foregroundColor(trigger ? colors.buttonOnColor : colors.buttonOffColor)
            .isHoveringCatalyst { self.trigger = $0 }
    }
}
