//
//  AlertItem2Controller.swift
//  SkillBox 13.2
//
//  Created by Василий Крылов on 26.02.2025.
//

import Foundation
import UIKit

class AlertItem3Controller: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setupConstrains()
    }
    let alertButton = UIButton()
    
    private func setupViews(){
        self.navigationItem.title = "3"
        view.backgroundColor = .white
        
        
        alertButton.setTitle("Конец", for: .normal)
        alertButton.setTitleColor(.black, for: .normal)
        alertButton.addAction(
            UIAction(
                handler: { [weak self] _ in
                    let alert = self?.createAlert() ?? UIAlertController()
                    self?.present(alert, animated: true, completion: nil)
//            self?.navigationController?.popViewController(animated: true)
        }),
            for: .touchUpInside)
        view.addSubview(alertButton)
    }
   
    private func setupConstrains(){
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func createAlert() -> UIAlertController {
        let alert = UIAlertController(
        title: "End??",
        message: nil,
        preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
        
    }
}
