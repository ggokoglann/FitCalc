//
//  CalViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 9.05.2023.
//

import UIKit

class CALViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource {
    @IBOutlet var calLabel: UILabel!
    @IBOutlet var calReaction: UILabel!
    @IBOutlet var age: UITextField!
    @IBOutlet var height: UITextField!
    @IBOutlet var weight: UITextField!
    @IBOutlet var maleOrFemale: UISegmentedControl!
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var activityLevel: UIPickerView!
    
    var ageInput: Int?
    var heightInput: Int?
    var weightInput: Int?
    var selection: Bool?
    var calResult: Float = 0
    var selectedOption: String = "Pick Activity Level"
    var nextTapped: Float = 0
    var activeTextField: UITextField?
    let toolbar = UIToolbar()
    var calorie: Float = 0
    
    let options = ["Pick Activity Level", "Little/no exercise", "Exercise 1-2 times/week", "Exercise 2-3 times/week", "Exercise 3-5 times/week", "Exercise 6-7 times/week", "Proffesional Athlete"]
        
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
        
        activityLevel.delegate = self
        activityLevel.dataSource = self
        
        calLabel.text = "Calorie Calculator"
        calLabel.font = UIFont(name: "HelveticaNeue-Light", size: 28)
        
        calReaction.text = "The calorie calculator, also called the TDEE calculator, can help you in determining how many calories should you eat a day – or what your starting point is if you want to gain or lose weight."
        calReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        calReaction.textAlignment = .left
        calReaction.contentMode = .topLeft
        calReaction.numberOfLines = 0
        calReaction.sizeToFit()
           
        age.keyboardType = .numberPad
        height.keyboardType = .numberPad
        weight.keyboardType = .numberPad
        
        age.keyboardAppearance = .dark
        weight.keyboardAppearance = .dark
        height.keyboardAppearance = .dark
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedOption = options[row]
            print("selected row: \(selectedOption)")
        }
    
    func formula(_ result: Float) {
        let calString = String(format: "%.2f", result)
        let calPrefix = calString.prefix(4)
        calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
    }
    
    func reaction(_ cal1: Float) {
        if maleOrFemale.selectedSegmentIndex == 0 {
            // Male reactions
        switch selectedOption {
        case "Pick Activity Level":
            calReaction.text = "Please Pick Activity Level"
        case "Little/no exercise":
            formula(cal1 + 300)
        case "Exercise 1-2 times/week":
            formula(cal1 + 600)
        case "Exercise 2-3 times/week":
            formula(cal1 + 900)
        case "Exercise 3-5 times/week":
            formula(cal1 + 1200)
        case "Exercise 6-7 times/week":
            formula(cal1 + 1500)
        case "Proffesional Athlete":
            formula(cal1 + 2000)
        default:
            break
        }
    } else if maleOrFemale.selectedSegmentIndex == 1 {
            // Female reactions
        switch selectedOption {
        case "Pick Activity Level":
            calReaction.text = "Please Pick Activity Level"
        case "Little/no exercise":
            formula(cal1 + 200)
        case "Exercise 1-2 times/week":
            formula(cal1 + 400)
        case "Exercise 2-3 times/week":
            formula(cal1 + 600)
        case "Exercise 3-5 times/week":
            formula(cal1 + 800)
        case "Exercise 6-7 times/week":
            formula(cal1 + 1000)
        case "Proffesional Athlete":
            formula(cal1 + 1200)
        default:
            break
            }
        }
    }
    
    func calculation() {
        if let ageInput = age.text, let weightInput = weight.text, let heightInput = height.text,
           let age = Float(ageInput), let weight = Float(weightInput), let height = Float(heightInput) {
            
            if maleOrFemale.selectedSegmentIndex == 0 {
                    // Calorie intake formula for male
                let cal1 = (weight * 10) + (height * 6.25) - (age * 5) + 5
                calorie = cal1
                
            } else if maleOrFemale.selectedSegmentIndex == 1 {
                    // Calorie intake formula for female
                let cal1 = (weight * 10) + (height * 6.25) - (age * 5) - 161
                calorie = cal1
                
            } else {
                calReaction.text = "Please enter valid values for height, age and weight."
            }
        }
    }
    
    @IBAction func calculateCAL(_ sender: UIButton) {
        calculation()                                    // Calculation
        reaction(calorie)                                // Reaction based on result
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
                
                calReaction.isHidden = true
                calLabel.isHidden = true
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
        calReaction.isHidden = false
        calLabel.isHidden = false
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
   
