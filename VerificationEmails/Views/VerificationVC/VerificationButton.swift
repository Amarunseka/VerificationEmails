//
//  VerificationButton.swift
//  VerificationEmails
//
//  Created by Миша on 01.04.2022.
//

import UIKit

class VerificationButton: UIButton {
    
    var isValid = false {
        didSet {
            if isValid {
                mailIsValid()
            } else {
                mailIsNotValid()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9333333333, blue: 0.862745098, alpha: 1)
        setTitle("Verification Button", for: .normal)
        let color  = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
        setTitleColor(color, for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = UIFont(name: "Avenir Book", size: 17)
        isEnabled = false
        alpha = 0.5
    }
    
    private func mailIsNotValid(){
        isEnabled = false
        alpha = 0.5
    }
    
    private func mailIsValid(){
        isEnabled = true
        alpha = 1
    }

    public func setDefaultSettings(){
        configure()
    }
}
