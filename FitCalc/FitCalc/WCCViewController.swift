//
//  WCCViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 2.06.2023.
//

import UIKit

class WCCViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var duration: UITextField!
    @IBOutlet var bodyWeight: UITextField!
    @IBOutlet var walkReaction: UILabel!
    @IBOutlet var walkLabel: UILabel!
    
    var durationInput: Int?
    var bodyWeightInput: Int?
    var walkResult: Float = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        duration.delegate = self
        bodyWeight.delegate = self
        
            // Result Label
        walkLabel.text = "Walking Calorie Calculator"
        walkLabel.font = UIFont(name: "HelveticaNeue-Light", size: 28)
        
            // Reaction Label
        walkReaction.text = "The walking calorie calculator estimates the calories burned while walking based on your weight and duration. It helps you track your calorie expenditure during walking exercises, aiding in weight management and fitness goals."
        walkReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        walkReaction.numberOfLines = 0
        walkReaction.sizeToFit()
        
            // Textfields
        duration.keyboardType = .numberPad
        bodyWeight.keyboardType = .numberPad
        
            // Done Button For Keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [doneButton]
                
        duration.inputAccessoryView = toolbar
        bodyWeight.inputAccessoryView = toolbar

    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == duration {
            if let input = textField.text, let number = Int(input) {
                durationInput = number
            } else {
                durationInput = nil
            }
            bodyWeight.becomeFirstResponder()
        } else if textField == bodyWeight {
            if let input = textField.text, let number = Int(input) {
                bodyWeightInput = number
            } else {
                bodyWeightInput = nil
            }
        }
        return true
    }

    @IBAction func calculateWCC(_ sender: UIButton) {
        if let durationInput = duration.text, let bodyWeightInput = bodyWeight.text,
        let duration = Float(durationInput), let bodyWeight = Float(bodyWeightInput) {
            
            let walkCalorie = (duration * 12.5 * bodyWeight) / 200
            
            let walkString = String(format: "%.2f", walkCalorie)
            let walkPrefix = walkString.prefix(4)
                        
            walkReaction.text = "Your Burned \(walkPrefix) Calories"
            walkReaction.font = UIFont(name: "HelveticaNeue-Light", size: 26)
            walkReaction.numberOfLines = 0
            walkReaction.sizeToFit()
            
            animate(sender)
        }
    }
        
    @objc func doneButtonTapped() {
        duration.resignFirstResponder()
        bodyWeight.resignFirstResponder()
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
