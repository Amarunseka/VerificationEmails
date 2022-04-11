//
//  VerificationModel.swift
//  VerificationEmails
//
//  Created by Миша on 04.04.2022.
//

import Foundation

class VerificationModel {
    
    // MARK: - initial elements
    private let emailsArray = [
        "@gmail.com",
        "@yahoo.com",
        "@apple.com",
        "@yandex.com",
        "@mail.ru",
        "@rambler.ru"
    ]
    public var nameMail = String()
    public var filteredEmailsArray: [String] = []
    
    // MARK: - Private methods-actions
    
    private func filterEmails(text: String){
        var enteredDomainEmail: String
        filteredEmailsArray = []
        guard let firstIndex = text.firstIndex(of: "@") else {return}
        
        let endIndex = text.index(before: text.endIndex)
        let domain = text[firstIndex...endIndex]
        enteredDomainEmail = String(domain)
        
        emailsArray.forEach { existEmail in
            if existEmail.contains(enteredDomainEmail) {
                if !filteredEmailsArray.contains(existEmail) {
                    filteredEmailsArray.append(existEmail)
                }
                if enteredDomainEmail == filteredEmailsArray[0] {
                    filteredEmailsArray = []
                }
            }
        }
    }

    private func deriveNameOfEmail(text: String){
        guard let atSymbolIndex = text.firstIndex(of: "@") else {return}
        
        let endIndex = text.index(before: atSymbolIndex)
        let firstIndex = text.startIndex
        let name = text[firstIndex...endIndex]
        nameMail = String(name)
    }
    
    // MARK: - Public methods
    public func getFilteredEmail(text: String){
        filterEmails(text: text)
    }
    
    public func getMailName(text: String) {
        deriveNameOfEmail(text: text)
    }
}
