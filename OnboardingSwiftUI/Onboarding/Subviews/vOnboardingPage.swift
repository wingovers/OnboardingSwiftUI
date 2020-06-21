//
//  vOnboardingPage.swift
//  OnboardingSwiftUI
//
//  Created by Ryan on 6/20/20.
//  Copyright © 2020 Wingover. All rights reserved.
//

import SwiftUI

struct OnboardingPageView: View {

    var content: OnboardingPageContent
    var width: CGFloat

    var body: some View {
        VStack(alignment: .center) {
            Image(content.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .fixedSize(horizontal: true, vertical: false)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text(content.line1)
                    .font(.system(.title, design: .rounded))
                Text(content.line2)
                    .font(.system(.title, design: .rounded))
            }
            .fixedSize(horizontal: false, vertical: true)
            .layoutPriority(1)
            .allowsTightening(true)
            .multilineTextAlignment(.center)
            .padding(.vertical)
        }
        .frame(width: width)
    }
}
