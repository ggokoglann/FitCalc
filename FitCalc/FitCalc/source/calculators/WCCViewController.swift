//
//  WCCViewController.swift
//  FitCalc
//
//  Created by Gökhan Gökoğlan on 2.06.2023.
//

import UIKit

class WCCViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var duration: UITextField!
    @IBOutlet var bodyWeight: UITextField!
    @IBOutlet var walkReaction: UILabel!
    @IBOutlet var walkLabel: UILabel!
    
    var durationInput: Int?
    var bodyWeightInput: Int?
    var walkResult: Float = 0
    var activeTextField: UITextField?
    let toolbar = UIToolbar()
    var calorie: Float = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        
        toolbar.items = [flexibleSpace, nextButton]
        toolbar.sizeToFit()
        
        bodyWeight.inputAccessoryView = toolbar
        
        duration.delegate = self
        bodyWeight.delegate = self
        
        walkLabel.text = "Walking Calorie Calculator"
        walkLabel.font = UIFont(name: "HelveticaNeue-Light", size: 28)
        
        walkReaction.text = "The walking calorie calculator estimates the calories burned while walking based on your weight and duration. It helps you track your calorie expenditure during walking exercises, aiding in weight management and fitness goals."
        walkReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        walkReaction.numberOfLines = 0
        walkReaction.sizeToFit()
        
        duration.keyboardType = .numberPad
        bodyWeight.keyboardType = .numberPad
        
        duration.keyboardAppearance = .dark
        bodyWeight.keyboardAppearance = .dark
        
        let doneToolbar = UIToolbar()
        doneToolbar.items = [flexibleSpace, doneButton]
        doneToolbar.sizeToFit()
        duration.inputAccessoryView = doneToolbar
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == duration {
            if let input = textField.text, let number = Int(input) {
                durationInput = number
            } else {
                durationInput = nil
            }
            bodyWeight.becomeFirstResponder()
        } else if textField == bodyWeight {
            if let input = textField.text, let number = Int(input) {
                bodyWeightInput = number
            } else {
                bodyWeightInput = nil
            }
        }
        return true
    }
    
    func formula() {
        if let durationInput = duration.text, let bodyWeightInput = bodyWeight.text,
           let duration = Float(durationInput), let bodyWeight = Float(bodyWeightInput) {
            
            let walkCalorie = (duration * 12.5 * bodyWeight) / 200
            calorie = walkCalorie
        }
    }
    
    func reaction(_ calorie: Float) {
        let walkString = String(format: "%.2f", calorie)
        let walkPrefix = walkString.prefix(4)
                    
        walkReaction.text = "Your Burned \(walkPrefix) Calories"
        walkReaction.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        walkReaction.numberOfLines = 0
        walkReaction.sizeToFit()
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

    @IBAction func calculateWCC(_ sender: UIButton) {
        formula()                                       // Calculation
        reaction(calorie)                               // Reaction based on result
        animate(sender)                                 // Animation
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
        duration.becomeFirstResponder()
    }
    @objc func doneButtonTapped() {
        duration.resignFirstResponder()
    }       
}
