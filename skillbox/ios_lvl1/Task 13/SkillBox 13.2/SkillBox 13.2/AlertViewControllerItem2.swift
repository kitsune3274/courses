//
//  AlertViewController.swift
//  SkillBox 13.2
//
//  Created by Василий Крылов on 26.02.2025.
//


import UIKit

class AlertViewControllerItem2: AlertButtonControllerItem1 {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
    }
    override public func setupViews() {
        super.setupViews()
        self.navigationItem.title = "2"
    }
}

extension AlertButtonControllerItem1 {
    
}
