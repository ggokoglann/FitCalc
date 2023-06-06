//
//  BodyMeasurementCalculatorsViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 26.05.2023.
//

import UIKit

class BodyMeasurementCalculatorsViewController: UIViewController {
    @IBOutlet var idealWeightCalculator: UIButton!
    @IBOutlet var bmiCalculator: UIButton!
    @IBOutlet var bodyFatCalculator: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func idealAnimation(_ sender: UIButton) {
        animate(sender)
    }
    @IBAction func bmiAnimation(_ sender: UIButton) {
        animate(sender)
    }
    @IBAction func fatAnimation(_ sender: UIButton) {
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
