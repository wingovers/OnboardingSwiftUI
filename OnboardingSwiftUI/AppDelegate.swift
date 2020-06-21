//
//  AppDelegate.swift
//  OnboardingSwiftUI
//
//  Created by Ryan on 6/20/20.
//  Copyright © 2020 Wingover. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // The next two blocks listen for specific keyboard inputs, which individual views can use by an onReceive function to listen for these notifications.
    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(title: "Back",
                         action: #selector(handleKeyCommand(sender:)),
                         input: UIKeyCommand.inputLeftArrow),
            UIKeyCommand(title: "Next",
                         action: #selector(handleKeyCommand(sender:)),
                         input: UIKeyCommand.inputRightArrow),
            UIKeyCommand(input: "\r",
                         modifierFlags: [],
                         action: #selector(handleKeyCommand(sender:))),
            UIKeyCommand(input: "\u{3}",
                         modifierFlags: [],
                         action: #selector(handleKeyCommand(sender:))),
            UIKeyCommand(input: UIKeyCommand.inputHome,
                         modifierFlags: [],
                         action: #selector(handleKeyCommand(sender:))),
            UIKeyCommand(input: UIKeyCommand.inputEnd,
                         modifierFlags: [],
                         action: #selector(handleKeyCommand(sender:))),
            UIKeyCommand(input: UIKeyCommand.inputPageDown,
                         modifierFlags: [],
                         action: #selector(handleKeyCommand(sender:))),
            UIKeyCommand(input: UIKeyCommand.inputPageUp,
                         modifierFlags: [],
                         action: #selector(handleKeyCommand(sender:)))
        ]
    }

    @objc func handleKeyCommand(sender: UIKeyCommand) {
        if let direction = sender.input {
            NotificationCenter.default.post(name: .init("navigate"), object: direction)
        }

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

