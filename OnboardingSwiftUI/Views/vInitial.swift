//
//  vInitial.swift
//  OnboardingSwiftUI
//
//  Created by Ryan on 6/20/20.
//  Copyright © 2020 Wingover. All rights reserved.
//

import SwiftUI
import Combine

struct InitialView: View {
    @ObservedObject var sortingHat: SortingHat


    var body: some View {
        ZStack {
            Color(UIColor.systemGray4).edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                DebugOnboardingButton(sortingHat: sortingHat)
            }

            VStack {
                Text("Your app's first screen.")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView(sortingHat: SortingHat())
    }
}
