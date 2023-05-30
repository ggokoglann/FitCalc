//
//  CalViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 9.05.2023.
//

import UIKit

class CalViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource {
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
    
    let options = ["Pick Activity Level", "Little/no exercise", "Exercise 1-2 times/week", "Exercise 2-3 times/week", "Exercise 3-5 times/week", "Exercise 6-7 times/week", "Proffesional Athlete"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        age.delegate = self
        height.delegate = self
        weight.delegate = self
        
        activityLevel.delegate = self
        activityLevel.dataSource = self
        
        // Result Label
        calLabel.text = "Calorie Calculator"
        calLabel.font = UIFont(name: "HelveticaNeue-Light", size: 32)
        
        // Reaction Label
        calReaction.text = "The calorie calculator, also called the TDEE calculator, can help you in determining how many calories should you eat a day – or what your starting point is if you want to gain or lose weight."
        calReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        calReaction.numberOfLines = 0
        calReaction.sizeToFit()
        
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
    
        // Activity Picker Control Change
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
            // Handle the selected option
        }
    
    @IBAction func calculateCAL(_ sender: UIButton) {
        if let ageInput = age.text, let weightInput = weight.text, let heightInput = height.text,
           let age = Float(ageInput), let weight = Float(weightInput), let height = Float(heightInput) {
            
            if maleOrFemale.selectedSegmentIndex == 0 {
                    // BMR Formula for Man
                let cal1 = (weight * 10) + (height * 6.25) - (age * 5) + 5
                
                    // Calculating the calorie need based on picked activity level
                switch selectedOption {
                case "Pick Activity Level":
                    calReaction.text = "Please Pick Activity Level"
                    
                case "Little/no exercise":
                    let cal2 = cal1 + 300
                    let calString = String(format: "%.2f", cal2)
                    let calPrefix = calString.prefix(4)
                    calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                                                                
                case "Exercise 1-2 times/week":
                    let cal2 = cal1 + 600
                    let calString = String(format: "%.2f", cal2)
                    let calPrefix = calString.prefix(4)
                    calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                                                        
                case "Exercise 2-3 times/week":
                    let cal2 = cal1 + 900
                    let calString = String(format: "%.2f", cal2)
                    let calPrefix = calString.prefix(4)
                    calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                                                            
                case "Exercise 3-5 times/week":
                    let cal2 = cal1 + 1200
                    let calString = String(format: "%.2f", cal2)
                    let calPrefix = calString.prefix(4)
                    calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                                                            
                case "Exercise 6-7 times/week":
                    let cal2 = cal1 + 1500
                    let calString = String(format: "%.2f", cal2)
                    let calPrefix = calString.prefix(4)
                    calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                                                            
                case "Proffesional Athlete":
                    let cal2 = cal1 + 2000
                    let calString = String(format: "%.2f", cal2)
                    let calPrefix = calString.prefix(4)
                    calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                                                            
                default:
                    break
                }
                    
                } else if maleOrFemale.selectedSegmentIndex == 1 {
                    
                        // BMR Formula for Woman
                    let cal1 = (weight * 10) + (height * 6.25) - (age * 5) - 161
                    
                        // Calculating the calorie need based on picked activity level
                    switch selectedOption {
                    case "Pick Activity Level":
                        calReaction.text = "Please Pick Activity Level"
                        
                    case "Little/no exercise":
                        let cal2 = cal1 + 200
                        let calString = String(format: "%.2f", cal2)
                        let calPrefix = calString.prefix(4)
                        calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                        
                    case "Exercise 1-2 times/week":
                        let cal2 = cal1 + 400
                        let calString = String(format: "%.2f", cal2)
                        let calPrefix = calString.prefix(4)
                        calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                                            
                    case "Exercise 2-3 times/week":
                        let cal2 = cal1 + 600
                        let calString = String(format: "%.2f", cal2)
                        let calPrefix = calString.prefix(4)
                        calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                                            
                    case "Exercise 3-5 times/week":
                        let cal2 = cal1 + 800
                        let calString = String(format: "%.2f", cal2)
                        let calPrefix = calString.prefix(4)
                        calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                                            
                    case "Exercise 6-7 times/week":
                        let cal2 = cal1 + 1000
                        let calString = String(format: "%.2f", cal2)
                        let calPrefix = calString.prefix(4)
                        calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                                            
                    case "Proffesional Athlete":
                        let cal2 = cal1 + 1200
                        let calString = String(format: "%.2f", cal2)
                        let calPrefix = calString.prefix(4)
                        calReaction.text = "Your Daily Calorie Intake : \(calPrefix) kcal/day"
                                            
                    default:
                        break
                    }
                } else {
                    calLabel.text = "Calorie Calculator"
                    calLabel.font = UIFont(name: "HelveticaNeue-Light", size: 32)
                    calReaction.text = "Please enter valid values for height, age and weight."
                }
            }
        }
       
                // Done Button
            @objc func doneButtonTapped() {
                age.resignFirstResponder()
                weight.resignFirstResponder()
                height.resignFirstResponder()
            }
    
                // Male Female Selector Change
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
        }
   
