//
//  ViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 3.05.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var BMCCalculators: UIButton!
    @IBOutlet var DCCalculators: UIButton!
    @IBOutlet var FCCalculators: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func bodyAnimation(_ sender: UIButton) {
        animate(sender)
    }
    @IBAction func fitnessAnimation(_ sender: UIButton) {
        animate(sender)
    }
    @IBAction func dietaryAnimation(_ sender: UIButton) {
        animate(sender)
    }
    
    func animate(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.85, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.2) {
                    sender.transform = .identity
            }
        })
    }
}

