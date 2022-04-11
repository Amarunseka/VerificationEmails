//
//  Alerts.swift
//  VerificationEmails
//
//  Created by Миша on 05.04.2022.
//

import UIKit

struct Alert {
    
    // MARK: - Result
    private static func setupResultAlert(vc: UIViewController, title: String, message: String) {
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(ok)
        DispatchQueue.main.async {
            vc.present(alertController, animated: true)
        }
    }
    
    // MARK: - Change mail
    private static func setupChangeAlert(vc: UIViewController, title: String, message: String, completion: @escaping ()->()) {
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default) {_ in
            completion()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(ok)
        alertController.addAction(cancel)
        DispatchQueue.main.async {
            vc.present(alertController, animated: true)
        }
    }
    
    static func showResultAlert(vc: UIViewController, message: String) {
        setupResultAlert(vc: vc, title: "Result", message: message)
    }
    
    static func showErrorAlert(vc: UIViewController, message: String, completion: @escaping()->()) {
        setupChangeAlert(vc: vc, title: "Error", message: message, completion: completion)
    }
}
