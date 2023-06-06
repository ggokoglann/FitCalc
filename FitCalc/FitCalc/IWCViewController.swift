//
//  IWCViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 26.05.2023.
//

import UIKit

class IWCViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var IWCLabel: UILabel!
    @IBOutlet var iwcReaction: UILabel!
    @IBOutlet var age: UITextField!
    @IBOutlet var height: UITextField!
    @IBOutlet var maleOrFemale: UISegmentedControl!
    @IBOutlet var calculateButton: UIButton!
    
    var selections = 0
    var ageInput: Int?
    var heightInput: Int?
    var selection: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        age.delegate = self
        height.delegate = self
        
            // Result Label
        IWCLabel.text = "Ideal Weight Calculator"
        IWCLabel.font = UIFont(name: "HelveticaNeue-Light", size: 28)
        
            // Reaction Label
        iwcReaction.text = "Ideal weight calculator helps estimate a healthy weight based on your gender, age and height. It provides a general guideline for maintaining optimal health and can be useful for weight management goals. Keep in mind that it offers an approximate number, and individual factors may vary. Consult with a healthcare professional for personalized advice."
        iwcReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        iwcReaction.numberOfLines = 0
        iwcReaction.sizeToFit()
        
            // Textfields
        age.keyboardType = .numberPad
        height.keyboardType = .numberPad
        
            // Done Button For Keyboards
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [doneButton]
        
        age.inputAccessoryView = toolbar
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
    
    @IBAction func Calculate(_ sender: UIButton) {
        if let heightInput = height.text, let height = Float(heightInput) {
            
            if maleOrFemale.selectedSegmentIndex == 0 {
                let idealWeight = 52 + (((height - 152) / 2.54) * 1.9)
                
                let iwString = String(format: "%.2f", idealWeight)
                let iwPrefix = iwString.prefix(4)
                
                IWCLabel.text = "Your Ideal Weight: \(iwPrefix) Kg"
                IWCLabel.font = UIFont(name: "HelveticaNeue-Light", size: 24)
                
                animate(sender)
                
                iwcReaction.text = "Based on the information you provided, your estimated ideal weight is \(iwPrefix) kilograms. Please note that this is a general calculation, and individual factors may vary. It's always recommended to consult with a healthcare professional for personalized guidance on maintaining a healthy weight and lifestyle."
                iwcReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
                
            } else if maleOrFemale.selectedSegmentIndex == 1 {
                let idealWeight = 49 + (((height - 152) / 2.54) * 1.7)
                
                let iwString = String(format: "%.2f", idealWeight)
                let iwPrefix = iwString.prefix(4)
                
                IWCLabel.text = "Your Ideal Weight: \(iwPrefix) Kg"
                IWCLabel.font = UIFont(name: "HelveticaNeue-Light", size: 24)
                
                animate(sender)
                
                iwcReaction.text = "Based on the information you provided, your estimated ideal weight is \(iwPrefix) kilograms. Please note that this is a general calculation, and individual factors may vary. It's always recommended to consult with a healthcare professional for personalized guidance on maintaining a healthy weight and lifestyle."
                iwcReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
                
            } else {
                print("Please pick your gender and enter valid values for height and age.")
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
