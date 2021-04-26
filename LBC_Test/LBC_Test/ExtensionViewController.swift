//
//  ExtensionViewController.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 23/04/2021.
//

import UIKit

extension UIViewController  {
    /// Show alert with custom message
    func showAlert(alert: AlertMessages) {
        let alertVC = UIAlertController(title: "Erreur", message: alert.rawValue , preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion:nil)
    }
    
    func textFieldShouldReturn(textField: UITextField)->Bool{
        textField.resignFirstResponder()
        return true
    }
}
