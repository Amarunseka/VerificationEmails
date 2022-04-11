//
//  StatusLabel.swift
//  VerificationEmails
//
//  Created by Миша on 01.04.2022.
//

import UIKit

class StatusLabel: UILabel {
    
    // MARK: - initial elements
    public var isValid = false {
        didSet {
            if isValid {
                mailIsValid()
            } else {
                mailIsNotValid()
            }
        }
    }
    
    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods-actions
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        text = "Check your email"
        textColor = #colorLiteral(red: 0.9450980392, green: 0.9333333333, blue: 0.862745098, alpha: 1)
        font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        adjustsFontSizeToFitWidth = true
    }
    
    private func mailIsNotValid(){
        text = "Mail is not valid. Example: steave@apple.com"
        textColor = #colorLiteral(red: 0.5215686275, green: 0.1098039216, blue: 0.05098039216, alpha: 1)
    }

    private func mailIsValid(){
        text = "Mail is valid."
        textColor = #colorLiteral(red: 0.1960784314, green: 0.3411764706, blue: 0.1019607843, alpha: 1)
    }
    
    // MARK: - public methods-actions
    public func setDefaultSettings(){
        configure()
    }
}
