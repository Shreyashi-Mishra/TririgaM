//
//  ServiceClass.swift
//  RequestHandler
//
//  Created by Sharvari H V on 7/24/19.
//  Copyright © 2019 Sharvari H V. All rights reserved.
//

import Foundation

public enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkResponse: String , Error {
    case success
    case authenticationError = "You need to be authenticated"
    case badRequest = "Bad Request"
    case failed = "Netwrok Request Failed"
}

final class ServiceClass {
    
    var request : URLRequest!
    
    init(url: URL, httpMethod: HTTPMethod) {
//        let url = URL(string: url)!
        request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
    }
    
    fileprivate func setHTTPHeaders(){
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    fileprivate func setHTTPBody(data: Data){
        request.httpBody = data
    }
    
    // make a request to fetch data
    func serviceRequest(completion:@escaping (Result<Data?, NetworkResponse>) -> ()){
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse =  response as? HTTPURLResponse else{
                print("Not a HTTP Response")
                return
            }
            switch httpResponse.statusCode {
            case 200...299:
                completion(.success(data))
            case 401...500:
                completion(.failure(.authenticationError))
            case 501...599:
                completion(.failure(.badRequest))
            default:
                completion(.failure(.failed))
                
            }
            
        }
        task.resume()
    }
    
    func downloadContent(completion:@escaping (Result<URL?, NetworkResponse>) -> ()) {
        
        let task = URLSession.shared.downloadTask(with: request) { (localURL, response, error) in
            guard let httpResponse =  response as? HTTPURLResponse else{
                print("Not a HTTP Response")
                return
            }
            switch httpResponse.statusCode {
            case 200...299:
                completion(.success(localURL))
            case 401...500:
                completion(.failure(.authenticationError))
            case 501...599:
                completion(.failure(.badRequest))
            default:
                completion(.failure(.failed))

            }
        }
        
        task.resume()
    }
    
    
    ///Prepare the request object
    func prepareHTTPRequest(data: Data?) {
        if let data = data {
              self.setHTTPBody(data: data)
        }
        self.setHTTPHeaders()
    }
    
}
