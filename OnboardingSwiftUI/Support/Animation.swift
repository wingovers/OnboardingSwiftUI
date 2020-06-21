//
//  Animation.swift
//  OnboardingSwiftUI
//
//  Created by Ryan on 6/20/20.
//  Copyright © 2020 Wingover. All rights reserved.
//

import SwiftUI

// MARK: - Extension for easy access view modifiers and UIViewRepresentables later in this file

extension View {

    // Pulse on mouse hover for iPad or MacOS
    func pulseWhen(_ trigger: Bool) -> some View {
        return ModifiedContent(content: self, modifier: PulseOnHover(trigger: trigger))
    }

    func pulseSubtleWhen(_ trigger: Bool) -> some View {
        return ModifiedContent(content: self, modifier: PulseOnHoverSubtle(trigger: trigger))
    }

    // Animation effects for the nav buttons in V Onboarding.swift
    func actLikeNavButton(trigger: Binding<Bool>, colorsFrom: OnboardingPageContent) -> some View {
        return ModifiedContent(content: self, modifier: ActLikeNavButton(trigger: trigger, colors: colorsFrom))
    }

    // Utility for any hover reaction on iPad or MacOS. See notes below for correct use. IT MUST COME AFTER .GESTURE()
    func isHoveringCatalyst(perform action: @escaping (Bool) -> Void) -> some View {
        return self.overlay(HoverRecognizer(action: action))
    }
}

struct PulseOnHover: ViewModifier {
    var trigger: Bool
    func body(content: Content) -> some View {
        return content
            .scaleEffect(trigger ? 1.05 : 0.95)
            .animation(trigger ? Animation.easeInOut(duration: 0.7)
                .repeatForever(autoreverses: true) : .default)
    }
}

struct PulseOnHoverSubtle: ViewModifier {
    var trigger: Bool
    func body(content: Content) -> some View {
        return content
            .scaleEffect(trigger ? 1.02 : 0.98)
            .animation(trigger ? Animation.easeInOut(duration: 0.7)
                .repeatForever(autoreverses: true) : .default)
    }
}

// This enables hover for MacOS because .onHover() does not work for all shapes on MacOS. Credit: Paul Colton for SO kindness.
// Also, the solution below does NOT respond to .contentShape() but DOES respond to .frame()
// Finally, order matters. .onHoverCatalyst() must come AFTER .gesture()
// https://stackoverflow.com/questions/60001653/how-to-implement-onhover-event-with-catalyst

public struct HoverRecognizer: UIViewRepresentable {

    var action: (Bool) -> Void

    public func makeUIView(context: Context) -> UIView {
        return HoverView(action)
    }

    public func updateUIView(_ uiView: UIView, context: Context) {
    }

    private class HoverView: UIView {
        var action: (Bool) -> Void

        init(_ action: @escaping (Bool) -> Void) {
            self.action = action
            super.init(frame: CGRect.zero)

            self.addGestureRecognizer(UIHoverGestureRecognizer(
                target: self,
                action: #selector(hovering(_:))))
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        @objc
        func hovering(_ recognizer: UIHoverGestureRecognizer) {
            switch recognizer.state {
            case .began, .changed:
                action(true)
            case .ended:
                action(false)
            default:
                break
            }
        }
    }
}
