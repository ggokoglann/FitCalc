//
//  BFPViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 3.05.2023.
//

import UIKit

class BFPViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var BodyFatLabel: UILabel!
    @IBOutlet var age: UITextField!
    @IBOutlet var height: UITextField!
    @IBOutlet var weight: UITextField!
    @IBOutlet var maleOrFemale: UISegmentedControl!
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var reaction: UILabel!
    
    var ageInput: Int?
    var heightInput: Int?
    var weightInput: Int?
    var selection: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        age.delegate = self
        height.delegate = self
        weight.delegate = self
        
            // Result Label
        BodyFatLabel.text = "Body Fat Calculator"
        BodyFatLabel.font = UIFont(name: "HelveticaNeue-Light", size: 32)
        
            // Reaction Label
        reaction.text = "Knowing your body fat percentage can provide valuable insights into your overall health and fitness levels. It is often used as an indicator of body composition, helping you understand the distribution of fat throughout your body. Higher body fat percentages are generally associated with increased health risks, while lower percentages are often associated with improved athletic performance and overall well-being."
        reaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        reaction.numberOfLines = 0
        reaction.sizeToFit()
        
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
        height.inputAccessoryView = toolbar
        weight.inputAccessoryView = toolbar
        
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
                weightInput = number
            } else {
                weightInput = nil
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
            
    @IBAction func calculateBodyFat(_ sender: UIButton) {
        if let heightInput = height.text, let ageInput = age.text, let weightInput = weight.text,
            let height = Float(heightInput), let age = Float(ageInput), let weight = Float(weightInput) {
            
            if maleOrFemale.selectedSegmentIndex == 0 {
                
                let bmi = 10000 * (weight / (height * height))
                let bodyFat = 1.2 * bmi + 0.23 * age - 16.2
                
                let bodyFatString = String(format: "%.2f", bodyFat)
                let bodyFatPrefix = bodyFatString.prefix(4)
                
                BodyFatLabel.text = "Body Fat : %\(bodyFatPrefix)"
                
            } else if maleOrFemale.selectedSegmentIndex == 1 {
                                                
                let bmi = 10000 * (weight / (height * height))
                let bodyFat = 1.2 * bmi + 0.23 * age - 5.4
                
                let bodyFatString = String(format: "%.2f", bodyFat)
                let bodyFatPrefix = bodyFatString.prefix(4)
                
                BodyFatLabel.text = "Body Fat : %\(bodyFatPrefix)"
                
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
        weight.resignFirstResponder()
        height.resignFirstResponder()
    }
}
