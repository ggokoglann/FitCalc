//
//  BMIViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 3.05.2023.
//

import UIKit

class BMIViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var result: UILabel!
    @IBOutlet var bmiReaction: UILabel!
    @IBOutlet var calculate: UIButton!
    @IBOutlet var weight: UITextField!
    @IBOutlet var height: UITextField!
    var activeTextField: UITextField?
        
    var heightInput: Int?
    var weigthInput: Int?
    var bmiResult: Float = 0
    
    let toolbar = UIToolbar()
                       
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // Create a flexible space item for aligning buttons
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
            // Create the "Next" button for the height text field
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        
            // Create the "Done" button for the weight text field
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        
            // Add the items to the toolbar
        toolbar.items = [flexibleSpace, nextButton]
        toolbar.sizeToFit()
        
            // Assign the toolbar as the input accessory view for the height text field
        height.inputAccessoryView = toolbar
        
            // Wrap the "Done" button in a toolbar and assign it as the input accessory view for the second text field
        let doneToolbar = UIToolbar()
        doneToolbar.items = [flexibleSpace, doneButton]
        doneToolbar.sizeToFit()
        weight.inputAccessoryView = doneToolbar
               
            // Result Label
        result.text = "BMI Calculator"
        result.font = UIFont(name: "HelveticaNeue-Light", size: 32)
                
            // Reaction Label
        bmiReaction.text = "BMI stands for Body Mass Index, which is a measure that uses weight and height to determine whether a person has a healthy body weight. It is often used as a screening tool to identify possible weight problems in adults. "
        bmiReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        bmiReaction.numberOfLines = 0
        bmiReaction.sizeToFit()
        
            // Set the delegate for the text fields
        height.delegate = self
        weight.delegate = self
        
            // Set the keyboard types to number pad
        height.keyboardType = .numberPad
        weight.keyboardType = .numberPad
        
            // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        // Unregister for keyboard notifications
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
            }
            return true
        }
    
    @IBAction func calculateBegin(_ sender: UIButton) {
        if let heightInput = height.text, let weigthInput = weight.text,
               let height = Float(heightInput), let weight = Float(weigthInput) {
                
                let bmi1 = 10000 * (weight / (height * height))
                // BMI Calculation Formula
                        
                let bmiString = String(format: "%.2f", bmi1)
                let bmiPrefix = bmiString.prefix(4)
                // Converting bmi result(Float) to string to show it to the user and also we are just showing them the first 4 numbers to get over any missunderstandings
            
                bmiResult = bmi1
                switch bmiResult {
                case 0..<18.5:
                    bmiReaction.text = "Underweight: If your BMI is in the underweight category, it's important to focus on gaining weight in a healthy way. You can try increasing your calorie intake and incorporating strength training exercises to build muscle mass."
                case 18.5..<24.9:
                    bmiReaction.text = "Normal weight: Congratulations! Your BMI is in the normal range, which means you're at a healthy weight for your height. Keep up the good work by maintaining a healthy diet and staying active."
                case 24.9..<29.9:
                    bmiReaction.text = "Overweight: If your BMI is in the overweight category, it's important to focus on losing weight in a healthy way. You can try reducing your calorie intake, increasing your physical activity, and incorporating more fruits and vegetables into your diet."
                case 29.9..<34.9:
                    bmiReaction.text = "Obese: If your BMI is in the obese category, it's important to focus on losing weight in a healthy way. You may want to consult with a healthcare provider or registered dietitian to develop a personalized plan for weight loss."
                case 34.9..<100:
                    bmiReaction.text = "Extremely obese: If your BMI is in the extremely obese category, it's important to seek medical help to manage your weight. You may be at higher risk for health problems such as heart disease, diabetes, and high blood pressure. A healthcare provider or registered dietitian can help you develop a plan to achieve a healthy weight."
                default:
                    bmiReaction.text = "Please enter valid values for height and weight."
                }
                    // Switch case showing user the advice texts depending on results they get
                    
            bmiReaction.numberOfLines = 0
            bmiReaction.sizeToFit()
                        
                result.text = "Your Bmi: \(bmiPrefix)"
                // Showing the actual bmi result
                            
                } else {
            print("Please enter valid values for height and weight.")
         
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        let keyboardHeight = keyboardFrame.height

        if let activeTextField = activeTextField {
            let textFieldFrame = activeTextField.convert(activeTextField.bounds, to: self.view)
            let visibleAreaHeight = self.view.bounds.height - keyboardHeight - 40

            if textFieldFrame.origin.y + textFieldFrame.height > visibleAreaHeight {
                let offset = textFieldFrame.origin.y + textFieldFrame.height - visibleAreaHeight
                self.view.frame.origin.y = -offset
            }
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
    }
    

    
    @objc func nextButtonTapped() {
        // Make the weight text field become the first responder
        weight.becomeFirstResponder()
    }
    
    @objc func doneButtonTapped() {
        // Dismiss the keyboard by resigning the weight text field's first responder status
        weight.resignFirstResponder()
    }
}
