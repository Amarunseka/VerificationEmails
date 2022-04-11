//
//  NetworkDataFetch.swift
//  VerificationEmails
//
//  Created by Миша on 05.04.2022.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fetchEmail(verifiableEmail: String, response: @escaping (MailResponseModel?, Error?) -> ()){
        
        NetworkRequest.shared.requestData(verifiableEmail: verifiableEmail) { result in
            switch result {
            case .success(let receivedData):
                do {
                    let receivedEmail = try JSONDecoder().decode(MailResponseModel.self, from: receivedData)
                    response(receivedEmail, nil)
                } catch let jsonError {
                    print(jsonError)
                }
            case .failure(let error):
                print("Error receive requesting data: \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }
}
