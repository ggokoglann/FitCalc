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
    
    var heightInput: Int?
    var weigthInput: Int?
    var bmiResult: Float = 0
    var activeTextField: UITextField?
    let toolbar = UIToolbar()
    var resultbmi : Float = 0
                       
    override func viewDidLoad() {
        super.viewDidLoad()
                    
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
                    
        toolbar.items = [flexibleSpace, nextButton]
        toolbar.sizeToFit()
                   
        height.inputAccessoryView = toolbar
        
        height.delegate = self
        weight.delegate = self
        
        let doneToolbar = UIToolbar()
        doneToolbar.items = [flexibleSpace, doneButton]
        doneToolbar.sizeToFit()
        weight.inputAccessoryView = doneToolbar
                           
        result.text = "BMI Calculator"
        result.font = UIFont(name: "HelveticaNeue-Light", size: 32)
                            
        bmiReaction.text = "BMI stands for Body Mass Index, which is a measure that uses weight and height to determine whether a person has a healthy body weight. It is often used as a screening tool to identify possible weight problems in adults. "
        bmiReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        bmiReaction.numberOfLines = 0
        bmiReaction.sizeToFit()
                        
        height.keyboardType = .numberPad
        weight.keyboardType = .numberPad
                    
        height.keyboardAppearance = .dark
        weight.keyboardAppearance = .dark
        
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
            }
            return true
        }
    
    func calculation() {
        if let heightInput = height.text, let weigthInput = weight.text,
           let height = Float(heightInput), let weight = Float(weigthInput) {
            
            let bmi1 = 10000 * (weight / (height * height))
            resultbmi = bmi1
        }
    }
    
    func reaction(_ resultbmi: Float) {
        let bmiString = String(format: "%.2f", resultbmi)
        let bmiPrefix = bmiString.prefix(4)
        result.text = "Your Bmi: \(bmiPrefix)"
        
        switch resultbmi {
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
        bmiReaction.numberOfLines = 0
        bmiReaction.sizeToFit()
    }
    
    @IBAction func calculateBegin(_ sender: UIButton) {
        calculation()                                    // Calculation
        reaction(resultbmi)                              // Reaction based on result
        animate(sender)                                  // Animation
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
                
                result.isHidden = true
                bmiReaction.isHidden = true
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
        result.isHidden = false
        bmiReaction.isHidden = false
    }
    @objc func nextButtonTapped() {
        weight.becomeFirstResponder()
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
