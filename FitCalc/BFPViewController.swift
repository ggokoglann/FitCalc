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
                
                animate(sender)
                
                bfpResult = bodyFat
                switch bfpResult {
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
                                                
                let bmi = 10000 * (weight / (height * height))
                let bodyFat = 1.2 * bmi + 0.23 * age - 5.4
                
                let bodyFatString = String(format: "%.2f", bodyFat)
                let bodyFatPrefix = bodyFatString.prefix(4)
                
                BodyFatLabel.text = "Body Fat : %\(bodyFatPrefix)"
                
                animate(sender)
                
                bfpResult = bodyFat
                switch bfpResult {
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
        age.resignFirstResponder()
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
