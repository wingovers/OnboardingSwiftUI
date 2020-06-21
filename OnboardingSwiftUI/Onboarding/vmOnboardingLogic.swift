//
//  vmOnboardingLogic.swift
//  OnboardingSwiftUI
//
//  Created by Ryan on 6/20/20.
//  Copyright © 2020 Wingover. All rights reserved.
//

import SwiftUI

extension OnboardingView {

    /// Logic for ending onboarding: There is nothing more to learn if the current page number equals the number of members of the content array (minus one to account for index 0).
    var isThereMoreToLearn: Bool {
        guard currentPage == self.pages.count - 1 else { return withAnimation { true } }
        return withAnimation { false }
    }

    /// Navigate through onboarding with left and right keyboard buttons in MacOS and iOS.
    /// - Parameter notification: Notifications specified in keyCommands in AppDelegate.swift.
    func navigateByKeyboard(_ notification: NotificationCenter.Publisher.Output) {
        if let direction = notification.object as? String {
            if direction == UIKeyCommand.inputLeftArrow || direction == UIKeyCommand.inputPageUp {
                guard self.currentPage > 0 && self.sortingHat.currentView == .onboarding else { return }
                withAnimation { self.currentPage -= 1 }
            }
            if direction == UIKeyCommand.inputRightArrow ||
                direction == "\r" ||
                direction == "\u{3}" ||
                direction == UIKeyCommand.inputPageDown {
                guard self.isThereMoreToLearn else {
                    self.sortingHat.didOnboard()
                    return }
                self.currentPage += 1
            }
            
            if direction == UIKeyCommand.inputHome {
                withAnimation { self.currentPage = 0 }
            }
            if direction == UIKeyCommand.inputEnd {
                withAnimation { self.currentPage = self.pages.count - 1 }
            }
        }
    }

    /// A swipe default for .gesture() to navigate onboarding pages.
    ///
    /// Required variables in the View:
    /// - `currentPage <Int>`
    /// - `dragged <CGSize>`    Gesture magnitude
    /// - `SortingHat <ObservableObject>`   To perform onboarding exit
    /// - `isThereMoreToLearn <Bool>`   Extension-provided variable to trigger onboarding exit
    ///
    /// You can change the swipe sensitivity threshold from the default of 40.
    ///
    /// - Returns: Updates variables in the View to change the onboarding page or exit onboarding.
    func swipeBackOrNext() -> _EndedGesture<_ChangedGesture<DragGesture>> {
        return DragGesture().onChanged { value in
            self.dragged = value.translation
        }
        .onEnded { _ in
            // 40 is my preferred sensitivity.
            if self.dragged.width > 40 {
                guard self.currentPage != 0 else {
                    self.dragged = .zero
                    return }
                withAnimation { self.currentPage -= 1 }
            }
            if self.dragged.width < -40 {
                guard self.isThereMoreToLearn else {
                    self.sortingHat.didOnboard()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.currentPage = 0
                    }
                    return }
                self.currentPage += 1
            }
            self.dragged = .zero
        }
    }

    /// A tap or click default for .gesture() to return to a prior onboarding page.
    ///
    /// Required variables in the View:
    /// * `currentPage <Int>`
    ///
    /// - Returns: Updates a variable in the View to change the onboarding page.
    func tapBack() -> _EndedGesture<TapGesture> {
        return TapGesture()
            .onEnded { _ in
                guard self.currentPage > 0 else { return }
                    self.currentPage -= 1
        }
    }

    /// A tap or click default for .gesture() to advance through onboarding pages and exit when complete.
    ///
    /// Required variables in the View:
    /// * `currentPage <Int>`
    /// * `SortingHat <ObservableObject>`   To perform onboarding exit
    /// * `isThereMoreToLearn` <Bool>   Extension-provided variable to trigger onboarding exit
    ///
    /// - Returns: Updates variables in the View to change the onboarding page or exit onboarding.
    func tapForward() -> _EndedGesture<TapGesture> {
        return TapGesture()
            .onEnded { _ in
                    guard self.isThereMoreToLearn else {
                        self.sortingHat.didOnboard()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.currentPage = 0
                        }
                        return }
                self.currentPage += 1
        }
    }

    /// Moves a super-wide HStack of pages step-wise. It compensates for odd margin issues, which you may need to adjust.
    /// - Parameters:
    ///   - currentPage: @State for current onboarding page
    ///   - pageWidth: GeometryReader calculated frame width for one view
    ///   - pageCount: Number of onboarding pages in total
    /// - Returns: The x-axis offset for the onboarding page to be displayed.
    func calculateOffsetFor(currentPage: Int, basedOnPageWidth pageWidth: CGFloat, andPageCount pageCount: Int) -> CGFloat {
        let alignToLeadingEdge = pageWidth * CGFloat(pageCount - 1)/2
        let presentCurrentPage = pageWidth * -CGFloat(currentPage)
        // Compensate for odd margins: If the currentPage is the first one, it is offset 2 to the left. Any subsequent view is first offset to the left and some more per page progression.
        let compensateForOddMargins = currentPage == 0 ? CGFloat(-2) : CGFloat(currentPage * -7 - 5)

        return alignToLeadingEdge + presentCurrentPage + compensateForOddMargins
    }
}
