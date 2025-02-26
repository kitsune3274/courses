//
//  AppDelegate.swift
//  SkillBox 13.2
//
//  Created by Василий Крылов on 26.02.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBerController = TabBarController()
        let navigation = UINavigationController(rootViewController: tabBerController)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }

}

