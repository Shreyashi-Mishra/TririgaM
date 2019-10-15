//
//  TMServiceClass.swift
//  TririgaM
//
//  Created by Shreyashi Mishra on 09/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import Foundation
import UIKit

// Mark: - User Logins
enum UserLogins: String  {

    case Coordinator
    case Technician

}


//Mark: - Calls for Service

class TMServiceClass: UIViewController {
 

        
    func getDataDetails (completion: @escaping(_ data : [TMGenericDataModel]?) -> Void) {
    
    
        guard let imageData = UIImage(named: "images") else { return }
        var data = [TMGenericDataModel]()
        
        let data1 = TMGenericDataModel(imageD: imageData, dataD: "Maintenance services")
        
        data.append(data1)
        
        completion(data)
    }
    
    
    
        func getTaskDetails (completion: @escaping(_ data : [TMGenericDataModel]?) -> Void) {
            
            let loginUsers = UserLogins.Coordinator
            
            switch loginUsers {
            
            case .Coordinator:
                guard let imageData = UIImage(named: "images") else { return}
                var data = [TMGenericDataModel]()

                 let data1 = TMGenericDataModel(imageD: imageData, dataD: "Create Service Requests")

                 data.append(data1)
                 completion(data)
            
            case .Technician:
                guard let imageData = UIImage(named: "images") else { return}
                var data = [TMGenericDataModel]()

                let data1 = TMGenericDataModel(imageD: imageData, dataD: "Corrective Work Tasks")

                data.append(data1)
                completion(data)
                

            }
                
    }
    
    
    func fetchJsonData (completion: @escaping (Result<[TMCreateRequestModel]?, Error>) ->()) {
            let urlString = jsonURL
            guard let urlData = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: urlData) { (data, resp, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                do {
                let requestData = try JSONDecoder().decode([TMCreateRequestModel].self, from: data!)
                completion(.success(requestData))

                }catch let jsonError {
                   
                    completion(.failure(jsonError))

                }
                
            
            }.resume()
        }
    

}
