//
//  SortingHat.swift
//  OnboardingSwiftUI
//
//  Created by Ryan on 6/20/20.
//  Copyright © 2020 Wingover. All rights reserved.
//

import SwiftUI
import Combine

// MARK: - View that either starts Onboarding or starts the app based on UserDefaults.
struct GreatHallView: View {
    @ObservedObject var sortingHat: SortingHat

    @ViewBuilder
    var body: some View {
        ZStack {
            if sortingHat.currentView == .onboarding {
                OnboardingView(sortingHat: sortingHat)
                    .transition(
                        .asymmetric(insertion: .opacity, removal: .move(edge: .leading)))

            } else if sortingHat.currentView == .initial {

                // Link your initial view here. The observed object does not need to be passed to it if you don't want to revisit onboarding.
                InitialView(sortingHat: sortingHat)
                    .transition(
                        .asymmetric(insertion: .move(edge:. trailing), removal: .opacity))
            } else {
                EmptyView()
            }
        }.animation(.spring())
    }
}

// MARK: - Logic for how views are chosen and UserDefaults are saved.
class SortingHat: ObservableObject {
    @Published private(set) var currentView: Houses

    init() {
        guard UserDefaults.standard.bool(forKey: "didOnboard")
            else {
                currentView = .onboarding
                return
        }
        currentView = .initial
    }

    public func didOnboard() {
        UserDefaults.standard.set(true, forKey: "didOnboard")
        withAnimation {
            currentView = .initial
        }
    }

    public func redoOnboard() {
        UserDefaults.standard.set(false, forKey: "didOnboard")
        withAnimation {
            currentView = .onboarding
        }
    }
}

// Root views to choose between.
extension SortingHat {
    enum Houses {
        case onboarding, initial
    }
}
