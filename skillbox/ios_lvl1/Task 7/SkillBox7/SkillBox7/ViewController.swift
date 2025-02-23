//
//  ViewController.swift
//  SkillBox7
//
//  Created by Василий Крылов on 07.02.2025.
//

import UIKit

class ViewController: UIViewController {
    var counter: Int = 0
    @IBOutlet weak var nameHeader: UILabel!
    
    @IBOutlet weak var nameButton: UIButton!
    @IBAction func touchButton(_ sender: Any) {
        incrementCounter()
    }
    
    
    func incrementCounter () {
        counter += 1
        nameHeader1()
    }
    func nameHeader1 () {
        nameHeader.text = "Нажатий: \(counter)"
    }
    func nameButton1 () {
       nameButton.setTitle("Нажать", for: .normal)
       // button.backgroundColor = UIColor(rgb: 0x9BFAF8)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameButton1()
        nameHeader1()
    }

   
}

