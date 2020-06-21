//
//  vDebugButton.swift
//  OnboardingSwiftUI
//
//  Created by Ryan on 6/20/20.
//  Copyright © 2020 Wingover. All rights reserved.
//

import SwiftUI

struct DebugOnboardingButton: View {
    @ObservedObject var sortingHat: SortingHat
    @State var redoOnboardingHover = false

    var body: some View {

        HStack {
            Button(action: { self.sortingHat.redoOnboard() }) {
                HStack {
                    Image(systemName: "ant.fill")
                        .scaleEffect(1.25)
                    Text("Redo Onboarding")
                }
                .padding()
                .foregroundColor(Color(.systemBackground))
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .pulseSubtleWhen(redoOnboardingHover)
                .isHoveringCatalyst { self.redoOnboardingHover = $0 }
            }
            .padding(50)
            Spacer()
        }
    }
}

struct DebugOnboardingButton_Previews: PreviewProvider {
    static var previews: some View {
        DebugOnboardingButton(sortingHat: SortingHat())
    }
}
