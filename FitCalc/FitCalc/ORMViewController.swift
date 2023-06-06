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
    var activeTextField: UITextField?
    let toolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        
        toolbar.items = [flexibleSpace, nextButton]
        toolbar.sizeToFit()
        
        weight.inputAccessoryView = toolbar
        
        weight.delegate = self
        rep.delegate = self
        
        ORMLabel.text = "One Rep Max Calculator"
        ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 28)
        
        ormReaction.text = "The One Rep Max (ORM) Calculator is a tool used to estimate the maximum weight you can lift for a given exercise. It helps determine your strength and is commonly used in strength training programs. By inputting the weight you lifted and the number of repetitions performed, the calculator provides an estimate of your maximum lifting capacity. This information is useful for tracking progress, setting training goals, and optimizing your workout routine."
        ormReaction.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        ormReaction.numberOfLines = 0
        ormReaction.sizeToFit()
        
        weight.keyboardType = .numberPad
        rep.keyboardType = .numberPad
        
        weight.keyboardAppearance = .dark
        rep.keyboardAppearance = .dark
        
        let doneToolbar = UIToolbar()
        doneToolbar.items = [flexibleSpace, doneButton]
        doneToolbar.sizeToFit()
        rep.inputAccessoryView = doneToolbar
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    func formula(_ leverage: Float) {
        if let weightInput = weight.text, let weight = Float(weightInput) {
            let oneRM = weight * leverage
            let oneRMString = String(format: "%.2f", oneRM)
            let oneRMPrefix = oneRMString.prefix(3)
            ORMLabel.text = "Your One Rep Max is: \(oneRMPrefix) Kg"
            ORMLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        }
    }

    @IBAction func calculateORM(_ sender: UIButton) {
        if let repInput = rep.text {
            switch repInput {
            case "1":
                formula(1)
                animate(sender)
            case "2":
                formula(1.03)
                animate(sender)
            case "3":
                formula(1.06)
                animate(sender)
            case "4":
                formula(1.09)
                animate(sender)
            case "5":
                formula(1.13)
                animate(sender)
            case "6":
                formula(1.16)
                animate(sender)
            case "7":
                formula(1.20)
                animate(sender)
            case "8":
                formula(1.24)
                animate(sender)
            case "9":
                formula(1.29)
                animate(sender)
            case "10":
                formula(1.33)
                animate(sender)
            default:
                ormReaction.text = "Rep count must be between 1 to 10"
                ormReaction.font = UIFont(name: "HelveticaNeue-Light", size: 26)
                animate(sender)
                break
            }
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
        rep.becomeFirstResponder()
    }    
    @objc func doneButtonTapped() {
        rep.resignFirstResponder()
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
