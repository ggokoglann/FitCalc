//
//  ORMViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 26.05.2023.
//

import UIKit

class ORMViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet var ORMLabel: UILabel!
    @IBOutlet var weight: UITextField!
    @IBOutlet var rep: UITextField!
    @IBOutlet var ormReaction: UILabel!
    @IBOutlet var calculateButton: UIButton!
        
    var selections = 0
    var weightInput: Int?
    var repInput: Int?
    var selection: Bool?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weight.delegate = self
        rep.delegate = self
        
            // Result Label
        ORMLabel.text = "One Rep Max Calculator"
        ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)

            // Reaction Label
        ormReaction.text = "The One Rep Max (ORM) Calculator is a tool used to estimate the maximum weight you can lift for a given exercise. It helps determine your strength and is commonly used in strength training programs. By inputting the weight you lifted and the number of repetitions performed, the calculator provides an estimate of your maximum lifting capacity. This information is useful for tracking progress, setting training goals, and optimizing your workout routine."
        ormReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        ormReaction.numberOfLines = 0
        ormReaction.sizeToFit()
        
            // Textfields
        weight.keyboardType = .numberPad
        rep.keyboardType = .numberPad
        
            // Done Button For Keyboards
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [doneButton]
        
        weight.inputAccessoryView = toolbar
        rep.inputAccessoryView = toolbar
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == weight {
            if let input = textField.text, let number = Int(input) {
                weightInput = number
            } else {
                weightInput = nil
            }
            rep.becomeFirstResponder()
        } else if textField == rep {
            if let input = textField.text, let number = Int(input) {
                repInput = number
            } else {
                repInput = nil
            }
        }
        return true
    }

    @IBAction func calculateORM(_ sender: UIButton) {
        if let weightInput = weight.text, let repInput = rep.text, let weight = Float(weightInput) {
            
                // Calculating the one rep max using switch case based on the rep input.
            switch repInput {
            case "1": let oneRM = weight * 1
                let oneRMString = String(format: "%.2f", oneRM)
                let oneRMPrefix = oneRMString.prefix(3)
                ORMLabel.text = "Your One Rep Max is: \(oneRMPrefix) Kg"
                ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
            case "2": let oneRM = weight * 1.03
                let oneRMString = String(format: "%.2f", oneRM)
                let oneRMPrefix = oneRMString.prefix(3)
                ORMLabel.text = "Your One Rep Max is: \(oneRMPrefix) Kg"
                ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
            case "3": let oneRM = weight * 1.06
                let oneRMString = String(format: "%.2f", oneRM)
                let oneRMPrefix = oneRMString.prefix(3)
                ORMLabel.text = "Your One Rep Max is: \(oneRMPrefix) Kg"
                ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
            case "4": let oneRM = weight * 1.09
                let oneRMString = String(format: "%.2f", oneRM)
                let oneRMPrefix = oneRMString.prefix(3)
                ORMLabel.text = "Your One Rep Max is: \(oneRMPrefix) Kg"
                ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
            case "5": let oneRM = weight * 1.13
                let oneRMString = String(format: "%.2f", oneRM)
                let oneRMPrefix = oneRMString.prefix(3)
                ORMLabel.text = "Your One Rep Max is: \(oneRMPrefix) Kg"
                ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
            case "6": let oneRM = weight * 1.16
                let oneRMString = String(format: "%.2f", oneRM)
                let oneRMPrefix = oneRMString.prefix(3)
                ORMLabel.text = "Your One Rep Max is: \(oneRMPrefix) Kg"
                ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
            case "7": let oneRM = weight * 1.20
                let oneRMString = String(format: "%.2f", oneRM)
                let oneRMPrefix = oneRMString.prefix(3)
                ORMLabel.text = "Your One Rep Max is: \(oneRMPrefix) Kg"
                ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
            case "8": let oneRM = weight * 1.24
                let oneRMString = String(format: "%.2f", oneRM)
                let oneRMPrefix = oneRMString.prefix(3)
                ORMLabel.text = "Your One Rep Max is: \(oneRMPrefix) Kg"
                ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
            case "9": let oneRM = weight * 1.29
                let oneRMString = String(format: "%.2f", oneRM)
                let oneRMPrefix = oneRMString.prefix(3)
                ORMLabel.text = "Your One Rep Max is: \(oneRMPrefix) Kg"
                ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
            case "10": let oneRM = weight * 1.33
                let oneRMString = String(format: "%.2f", oneRM)
                let oneRMPrefix = oneRMString.prefix(3)
                ORMLabel.text = "Your One Rep Max is: \(oneRMPrefix) Kg"
                ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                
            default:
                ormReaction.text = "Rep count must be between 1 to 10"
                ormReaction.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                break
            }
        }
    }
    
    @objc func doneButtonTapped() {
        weight.resignFirstResponder()
        rep.resignFirstResponder()
    }
}
