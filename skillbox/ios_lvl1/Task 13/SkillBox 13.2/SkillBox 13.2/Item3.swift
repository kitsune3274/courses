//
//  ViewController.swift
//  test1
//
//  Created by Василий Крылов on 24.02.2025.
//

import UIKit

class Item3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setupConstrains()
    }
    let nextButton = UIButton()
    
    private func setupViews(){
        self.navigationItem.title = "1"
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem (title: "Назад", style: .plain, target: nil, action: nil)
        
        nextButton.setTitle("Далее", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.addAction(UIAction(handler: {
            [weak self] _ in
            self?.navigationController?.pushViewController(SecondItem3ViewController(), animated: true)
        }), for: .touchUpInside)
        view.addSubview(nextButton)
    }
   
    private func setupConstrains(){
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
