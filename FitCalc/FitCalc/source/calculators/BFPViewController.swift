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
    var bfpResult: Float = 0
    var nextTapped: Float = 0
    var activeTextField: UITextField?
    let toolbar = UIToolbar()
    var bodyf: Float = 0
    
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
                    
        BodyFatLabel.text = "Body Fat Calculator"
        BodyFatLabel.font = UIFont(name: "HelveticaNeue-Light", size: 32)
                    
        reaction.text = "Knowing your body fat percentage can provide valuable insights into your overall health and fitness levels. It is often used as an indicator of body composition, helping you understand the distribution of fat throughout your body. Higher body fat percentages are generally associated with increased health risks, while lower percentages are often associated with improved athletic performance and overall well-being."
        reaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        reaction.numberOfLines = 0
        reaction.sizeToFit()
                    
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
    
    func calculation() {
        if let heightInput = height.text, let ageInput = age.text, let weightInput = weight.text,
           let height = Float(heightInput), let age = Float(ageInput), let weight = Float(weightInput) {
            if maleOrFemale.selectedSegmentIndex == 0 {
                
                let bmi = 10000 * (weight / (height * height))
                let bodyFat = 1.2 * bmi + 0.23 * age - 16.2
                bodyf = bodyFat
                
            } else if maleOrFemale.selectedSegmentIndex == 1 {
                
                let bmi = 10000 * (weight / (height * height))
                let bodyFat = 1.2 * bmi + 0.23 * age - 5.4
                bodyf = bodyFat
                
            } else {
                print("Please enter valid values for height, age and weight.")
            }
        }
    }
    
    func reaction(_ bodyf: Float) {
        let bodyFatString = String(format: "%.2f", bodyf)
        let bodyFatPrefix = bodyFatString.prefix(4)
        BodyFatLabel.text = "Body Fat : %\(bodyFatPrefix)"        
            
        if maleOrFemale.selectedSegmentIndex == 0 {
                // Male Reactions
            switch bodyf {
            case 2..<6:
                reaction.text = "Congratulations! Your body fat percentage falls within the essential fat category. Essential fat is necessary for various physiological functions. Keep up the good work!"
            case 6..<14:
                reaction.text = "Great job! Your body fat percentage is in the athlete category. This level of body fat is often associated with optimal performance and fitness. Keep up the hard work and maintain your healthy lifestyle!"
            case 14..<18:
                reaction.text = "Excellent! Your body fat percentage falls within the fitness category. This level of body fat is considered healthy and indicates good fitness levels. Keep up your exercise routine and balanced diet to maintain your fitness goals!"
            case 18..<24:
                reaction.text = "Good job! Your body fat percentage falls within the average category. This level of body fat is considered typical for men of your age and is generally associated with good health. Keep maintaining a balanced lifestyle!"
            case 24..<100:
                reaction.text = "It appears that your body fat percentage falls within the obese category. It's important to focus on your health and well-being. Consider consulting a healthcare professional or a fitness expert to develop a plan to improve your body composition and overall health."
            default:
                reaction.text = "Please enter valid values for height and weight."
            }
            reaction.numberOfLines = 0
            reaction.sizeToFit()
            
        } else if maleOrFemale.selectedSegmentIndex == 1 {
                // Female Reactions
            switch bodyf {
            case 2..<6:
                reaction.text = "Congratulations! Your body fat percentage falls within the essential fat category. Essential fat is crucial for maintaining reproductive and hormonal health. Well done!"
            case 6..<14:
                reaction.text = "Well done! Your body fat percentage is in the athlete category. This level of body fat is commonly seen in athletes and indicates a high level of fitness. Keep pushing your boundaries and stay active!"
            case 14..<18:
                reaction.text = "Fantastic! Your body fat percentage falls within the fitness category. This level of body fat is associated with a healthy and fit lifestyle. Keep up your fitness regimen and enjoy the benefits of an active lifestyle!"
            case 18..<24:
                reaction.text = "Well done! Your body fat percentage falls within the average category. This level of body fat is commonly observed in women of your age and is generally associated with good health. Continue your healthy habits!"
            case 24..<100:
                reaction.text = "It seems that your body fat percentage falls within the obese category. Prioritizing your health and well-being is essential. We recommend seeking guidance from a healthcare professional or a fitness expert to develop a plan for improving your body composition and overall health."
            default:
                reaction.text = "Please enter valid values for height and weight."
            }
            reaction.numberOfLines = 0
            reaction.sizeToFit()
        }
    }
        
    @IBAction func calculateBodyFat(_ sender: UIButton) {
        calculation()                                       // Calculation
        reaction(bodyf)                                     // Reaction based on result
        animate(sender)                                     // Animation
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
                
                BodyFatLabel.isHidden = true
                reaction.isHidden = true
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
        BodyFatLabel.isHidden = false
        reaction.isHidden = false
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
