//
//  ViewController.swift
//  SkillBox13
//
//  Created by Василий Крылов on 24.02.2025.
//

import UIKit

class AlertViewController: UIViewController {
    let alertButton = UIButton()
    
    @IBAction func alertAction(_ sender: Any) {
        let alert = self.createAlert()
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private func createAlert() -> UIAlertController {
        let alert = UIAlertController(
        title: "Вы достигли последней страницы",
        message: nil,
        preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        return alert
    }
}


