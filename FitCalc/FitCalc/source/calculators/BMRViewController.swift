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
    var nextTapped: Float = 0
    var activeTextField: UITextField?    
    let toolbar = UIToolbar()
    var result: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        
        toolbar.items = [flexibleSpace, nextButton]
        toolbar.sizeToFit()
        
        age.inputAccessoryView = toolbar
        height.inputAccessoryView = toolbar
        
        age.delegate = self
        height.delegate = self
        weight.delegate = self
                    
        BMRLabel.text = "BMR Calculator"
        BMRLabel.font = UIFont(name: "HelveticaNeue-Light", size: 32)
                    
        bmrReaction.text = "BMR stands for Basal Metabolic Rate. It's the number of calories your body burns while at rest, just to keep your body functioning properly. This includes things like breathing, circulating blood, and maintaining body temperature."
        bmrReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        bmrReaction.numberOfLines = 0
        bmrReaction.sizeToFit()
                   
        age.keyboardType = .numberPad
        height.keyboardType = .numberPad
        weight.keyboardType = .numberPad
        
        age.keyboardAppearance = .dark
        weight.keyboardAppearance = .dark
        height.keyboardAppearance = .dark
        
        let doneToolbar = UIToolbar()
        doneToolbar.items = [flexibleSpace, doneButton]
        doneToolbar.sizeToFit()
        weight.inputAccessoryView = doneToolbar
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {        
        NotificationCenter.default.removeObserver(self)
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
    
    func calculation() {
        if let ageInput = age.text, let weightInput = weight.text, let heightInput = height.text,
           let age = Float(ageInput), let weight = Float(weightInput), let height = Float(heightInput) {
            
            if maleOrFemale.selectedSegmentIndex == 0 {
                    // BMR Calculation formula for male
                let bmr1 = (weight * 10) + (height * 6.25) - (age * 5) + 5
                result = bmr1
                
            } else if maleOrFemale.selectedSegmentIndex == 1 {
                    // BMR Calculation formula for female
                let bmr1 = (weight * 10) + (height * 6.25) - (age * 5) - 161
                result = bmr1
                
            } else {
                print("Please enter valid values for height, age and weight.")
            }
        }
    }
    
    func reaction(_ result: Float) {
        let bmrString = String(format: "%.2f", result)
        let bmrPrefix = bmrString.prefix(4)
        
        BMRLabel.text = "Your Bmr: \(bmrPrefix) kcal/day"
        BMRLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
        bmrReaction.text = "Your Basal Metabolic Rate (BMR) is the number of calories your body burns at rest. Based on your input, your BMR is calculated to be \(bmrPrefix) kcal/day. This means that your body burns approximately \(bmrPrefix) calories per day even if you don't move at all.Knowing your BMR is helpful for creating a nutrition and exercise plan that supports your goals, whether you're looking to lose weight, gain weight, or maintain your current weight. By adjusting your daily caloric intake and exercise regimen based on your BMR, you can achieve your desired outcome."
        bmrReaction.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        bmrReaction.numberOfLines = 0
        bmrReaction.sizeToFit()
    }
      
    @IBAction func calculateBMR(_ sender: UIButton) {
        calculation()                                   // Calculation
        reaction(result)                                // Reaction based on result
        animate(sender)                                 // Animation
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        let keyboardHeight = keyboardFrame.height

        if let activeTextField = activeTextField {
            let textFieldFrame = activeTextField.convert(activeTextField.bounds, to: self.view)
            let visibleAreaHeight = self.view.bounds.height - keyboardHeight

            if textFieldFrame.origin.y + textFieldFrame.height > visibleAreaHeight {
                let offset = textFieldFrame.origin.y + textFieldFrame.height - visibleAreaHeight
                self.view.frame.origin.y = -offset - 40
                
                BMRLabel.isHidden = true
                bmrReaction.isHidden = true
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
        BMRLabel.isHidden = false
        bmrReaction.isHidden = false
    }
    
    @objc func nextButtonTapped() {
        if nextTapped == 0 {
            height.becomeFirstResponder()
            nextTapped += 1
        } else if nextTapped == 1 {
            weight.becomeFirstResponder()
            nextTapped = 0
        }
    }
    
    @objc func doneButtonTapped() {
        weight.resignFirstResponder()
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
