//
//  ViewController.swift
//  SkillBox 13.2
//
//  Created by Василий Крылов on 26.02.2025.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupViews()
    }
    
    private func setupViews() {
        let item1 = Item1 ()
        let icon1 = UITabBarItem(title: "1", image: UIImage(systemName: "pencil.tip"), selectedImage: nil)
        item1.tabBarItem = icon1
        let item2 = Item2 ()
        let icon2 = UITabBarItem(title: "2", image: UIImage(systemName: "pencil.circle"), selectedImage: nil)
        item2.tabBarItem = icon2
        let item3 = Item3 ()
        let icon3 = UITabBarItem(title: "3", image: UIImage(systemName: "pencil"), selectedImage: nil)
        item3.tabBarItem = icon3
        
        let controllers = [item1, item2, item3]
        self.viewControllers = controllers
    }
}

