//
//  vOnboarding.swift
//  OnboardingSwiftUI
//
//  Created by Ryan on 6/20/20.
//  Copyright © 2020 Wingover. All rights reserved.
//

import SwiftUI
import Combine

// Autogenerates the onboarding screens based on the number of OnboardingContent array members in Model "OnboardingContent.swift". After completing onboarding, routing to the initial app screen and updating of UserDefaults to skip onboarding on all subsequent launches is handled in "VM VB SortingHat.swift".

struct OnboardingView: View {

    // Navigation variables
    @ObservedObject var sortingHat: SortingHat
    @State var currentPage = 0
    @State var dragged = CGSize.zero
    @State var isHoveringLeftChevron = false
    @State var isHoveringRightChevron = false

    // Update the view if the device is rotated.
    @Environment(\.verticalSizeClass) var sizeClass

    // Loads custom content from OnboardingContent.swift to programatically generate onboarding views and buttons.
    let pages = OnboardingContent().pages

    var body: some View {

        // Top: a layer for displaying content followed by a layer for touch response
        // Bottom: an HStack of left, contents, and right buttons
        VStack {

            ZStack {

                // Make page views and add the gestures for progressing them
                GeometryReader { gr in
                    HStack {
                        ForEach(0..<self.pages.count) { page in
                            OnboardingPageView(content: self.pages[page],
                                               width: gr.frame(in: .global).width)
                        }
                    }
                        // Creates a very wide frame for the HStack
                        .frame(width: gr.frame(in: .global).width * CGFloat(self.pages.count),
                               height: nil,
                               alignment: .leading)

                        // Offset so dragging will temporarily wiggle the view
                        .offset(x: self.dragged.width)

                        // Offset so navigation functions can move through the wide HStack
                        .offset(x: self.calculateOffsetFor(currentPage: self.currentPage,
                                                           basedOnPageWidth: gr.frame(in: .global).width,
                                                           andPageCount: self.pages.count))
                        .animation(.spring())
                }

                // Invisible touch and hover areas for iOS and MacOS, split unevenly between backward and forward
                HStack(spacing: 0) {
                    Rectangle()
                        .aspectRatio(5/12, contentMode: .fit)
                        .opacity(0)
                        .isHoveringCatalyst { self.isHoveringLeftChevron = $0 }
                        .gesture(tapBack())
                    Rectangle()
                        .opacity(0)
                        .isHoveringCatalyst { self.isHoveringRightChevron = $0 }
                        .gesture(tapForward())
                }
                .gesture(swipeBackOrNext())
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("navigate"))) { notification in self.navigateByKeyboard(notification) }
            }

            // Make buttons that identify pages and progress on tap.
            if UIScreen.main.bounds.width > 414 {
                HStack(spacing: 0) {

                    // Left hoverable chevron
                    Image(systemName: "chevron.compact.left")
                        .actLikeNavButton(trigger: self.$isHoveringLeftChevron, colorsFrom: self.pages[0])
                        .gesture(self.tapBack())
                        .opacity(self.currentPage > 0 ? 1 : 0)
                    Spacer()

                    // Center page progress buttons
                    ForEach(0..<self.pages.count) { page in
                        OnboardingProgressIndicators(currentPage: self.$currentPage,
                                                     pageNumber: page,
                                                     content: self.pages[page])
                    }
                    Spacer()

                    // Right hoverable chevron and conditional start the app button
                    ZStack {
                        if self.isThereMoreToLearn { self.showChevron() } else {
                            OnboardingCompleteButton(trigger: self.$isHoveringRightChevron)
                        }
                    }
                    .gesture(self.tapForward())

                }
                .padding(.horizontal, 100)

            } else {
            // In a narrow portrait orientation, ensure buttons fit on the screen by rendering only the center progress buttons or, in their place, the onboarding complete button.

                ZStack {
                    if self.isThereMoreToLearn {

                        // Center page progress buttons
                        HStack(spacing: 0) {
                            ForEach(0..<self.pages.count) { page in
                                OnboardingProgressIndicators(currentPage: self.$currentPage,
                                                             pageNumber: page,
                                                             content: self.pages[page])
                            }
                        }
                    } else {
                        OnboardingCompleteButton(trigger: self.$isHoveringRightChevron)
                    }
                }
                .gesture(self.tapForward())

            }
        }
        .padding(.bottom, 20)
    }
}


struct VOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(sortingHat: SortingHat())
    }
}
