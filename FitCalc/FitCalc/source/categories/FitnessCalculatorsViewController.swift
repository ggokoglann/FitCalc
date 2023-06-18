//
//  FitnessCalculatorsViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 26.05.2023.
//

import UIKit

class FitnessCalculatorsViewController: UIViewController {
    @IBOutlet var weightLossCalculator: UIButton!
    @IBOutlet var walkingCalculator: UIButton!
    @IBOutlet var oneRepMaxCalculator: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func weightAnimation(_ sender: UIButton) {
        animate(sender)
    }
    @IBAction func walkingAnimation(_ sender: UIButton) {
        animate(sender)
    }
    @IBAction func oneRepAnimation(_ sender: UIButton) {
        animate(sender)
    }
    
    func animate(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3) {
                    sender.transform = .identity
            }
        })
    }
}
