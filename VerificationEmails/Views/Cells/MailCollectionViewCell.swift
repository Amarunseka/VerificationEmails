//
//  MailCollectionViewCell.swift
//  VerificationEmails
//
//  Created by Миша on 01.04.2022.
//

import UIKit

class MailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - initial elements
    let domainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        return label
    }()
    
    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods-actions
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.alpha = 0.5
        contentView.layer.cornerRadius = 10
        addSubview(domainLabel)
    }
    
    private func configure(emailName: String){
        domainLabel.text = emailName
    }
    
    // MARK: - public methods-actions
    public func setCellName(emailName: String) {
        configure(emailName: emailName)
    }
}

// MARK: - Setup Constraints
extension MailCollectionViewCell {
    
    private func setupConstraints() {
        let constraints = [
            domainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            domainLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
