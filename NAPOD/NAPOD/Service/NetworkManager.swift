//
//  NetworkManager.swift
//  NAPOD
//
//  Created by Bandish Kumar on 13/02/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchApodDetails(date: String, completion handler: @escaping (Result<ApodResult, NetworkError>) -> Void) {
       
        let apiEndPoint = "\(APIConstant.baseEndPoint)?api_key=\(APIConstant.apiKey)&date=\(date)"
        let url = URL(string: apiEndPoint)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                handler(.failure(.dataError))
                return
            }
            if let httpResponse = response as? HTTPURLResponse, !httpResponse.isResponseOK()  {
                handler(.failure(.errorMessage))
             }
            do {
                let jsonData = try JSONDecoder().decode(ApodResult.self, from: data)
                handler(.success(jsonData))
            } catch {
                handler(.failure(.badURL))
            }
            
        }.resume()
    }
    
}


enum NetworkError: Error {
    case badURL
    case dataError
    case errorMessage
}

extension HTTPURLResponse {
     func isResponseOK() -> Bool {
      return (200...299).contains(self.statusCode)
     }
}
