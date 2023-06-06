//
//  BMRViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 3.05.2023.
//

import UIKit

class BMRViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var BMRLabel: UILabel!
    @IBOutlet var bmrReaction: UILabel!
    @IBOutlet var age: UITextField!
    @IBOutlet var height: UITextField!
    @IBOutlet var weight: UITextField!
    @IBOutlet var maleOrFemale: UISegmentedControl!
    @IBOutlet var calculateButton: UIButton!
        
    var selections = 0
    var ageInput: Int?
    var heightInput: Int?
    var weigthInput: Int?
    var selection: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        age.delegate = self
        height.delegate = self
        weight.delegate = self
        
            // Result Label
        BMRLabel.text = "BMR Calculator"
        BMRLabel.font = UIFont(name: "HelveticaNeue-Light", size: 32)
        
            // Reaction Label
        bmrReaction.text = "BMR stands for Basal Metabolic Rate. It's the number of calories your body burns while at rest, just to keep your body functioning properly. This includes things like breathing, circulating blood, and maintaining body temperature."
        bmrReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        bmrReaction.numberOfLines = 0
        bmrReaction.sizeToFit()
        
            // Textfields
        age.keyboardType = .numberPad
        height.keyboardType = .numberPad
        weight.keyboardType = .numberPad
        
            // Done Button For Keyboards
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [doneButton]
        
        age.inputAccessoryView = toolbar
        weight.inputAccessoryView = toolbar
        height.inputAccessoryView = toolbar
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == height {
            if let input = textField.text, let number = Int(input) {
                heightInput = number
            } else {
                heightInput = nil
            }
            weight.becomeFirstResponder()
        } else if textField == weight {
            if let input = textField.text, let number = Int(input) {
                weigthInput = number
            } else {
                weigthInput = nil
            }
            age.becomeFirstResponder()
        } else if textField == age {
            if let input = textField.text, let number = Int(input) {
                ageInput = number
            } else {
                ageInput = nil
            }
        }
        return true
    }
    
    @IBAction func calculateBMR(_ sender: UIButton) {
        if let ageInput = age.text, let weightInput = weight.text, let heightInput = height.text,
           let age = Float(ageInput), let weight = Float(weightInput), let height = Float(heightInput) {
            
            if maleOrFemale.selectedSegmentIndex == 0 {
                let bmr1 = (weight * 10) + (height * 6.25) - (age * 5) + 5
                
                let bmrString = String(format: "%.2f", bmr1)
                let bmrPrefix = bmrString.prefix(4)
                
                BMRLabel.text = "Your Bmr: \(bmrPrefix) kcal/day"
                BMRLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
                animate(sender)
                
                bmrReaction.text = "Your Basal Metabolic Rate (BMR) is the number of calories your body burns at rest. Based on your input, your BMR is calculated to be \(bmrPrefix) kcal/day. This means that your body burns approximately \(bmrPrefix) calories per day even if you don't move at all.Knowing your BMR is helpful for creating a nutrition and exercise plan that supports your goals, whether you're looking to lose weight, gain weight, or maintain your current weight. By adjusting your daily caloric intake and exercise regimen based on your BMR, you can achieve your desired outcome."
                bmrReaction.font = UIFont(name: "HelveticaNeue-Light", size: 18)
                bmrReaction.numberOfLines = 0
                bmrReaction.sizeToFit()
                
            } else if maleOrFemale.selectedSegmentIndex == 1 {
                let bmr1 = (weight * 10) + (height * 6.25) - (age * 5) - 161
                
                let bmrString = String(format: "%.2f", bmr1)
                let bmrPrefix = bmrString.prefix(4)
                
                BMRLabel.text = "Your Bmr: \(bmrPrefix) kcal/day"
                
                animate(sender)
                
                bmrReaction.text = "Your Basal Metabolic Rate (BMR) is the number of calories your body burns at rest. Based on your input, your BMR is calculated to be \(bmrPrefix) kcal/day. This means that your body burns approximately \(bmrPrefix) calories per day even if you don't move at all.Knowing your BMR is helpful for creating a nutrition and exercise plan that supports your goals, whether you're looking to lose weight, gain weight, or maintain your current weight. By adjusting your daily caloric intake and exercise regimen based on your BMR, you can achieve your desired outcome."
                bmrReaction.numberOfLines = 0
                bmrReaction.sizeToFit()
                
            } else {
                print("Please enter valid values for height, age and weight.")
            }
        }
    }
        
    @IBAction func selectionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                // Male segment selected
                selection = true
            case 1:
                // Female segment selected
                selection = false
            default:
                break
        }
    }
    
    @objc func doneButtonTapped() {
        age.resignFirstResponder()
        weight.resignFirstResponder()
        height.resignFirstResponder()
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
