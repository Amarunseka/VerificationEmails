//
//  NetworkRequest.swift
//  VerificationEmails
//
//  Created by Миша on 05.04.2022.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    private init() {}

    func requestData(verifiableEmail:String, completion: @escaping(Result<Data, Error>) -> ()) {
        
        let urlString = "https://api.kickbox.com/v2/verify?email=\(verifiableEmail)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                completion(.success(data))
            }
        }.resume()
    }
}
