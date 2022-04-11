//
//  StackView.swift
//  VerificationEmails
//
//  Created by Миша on 01.04.2022.
//

import UIKit

extension UIStackView {
   
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
    }
}
