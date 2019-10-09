//
//  TMServiceClass.swift
//  TririgaM
//
//  Created by Shreyashi Mishra on 09/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import Foundation
import UIKit

class TMServiceClass: UIViewController {

    
    func getDataDetails() -> [TMGenericDataModel] {
        
        guard let imageData = UIImage(named: "images") else { return []}
        
        let data = TMGenericDataModel(imageD: imageData, dataD: "Maintenance services")
        
        return [data]
    }
 
    
   func getTaskDetails() -> [TMGenericDataModel] {
           
        guard let imageData = UIImage(named: "images") else { return []}
        var data = [TMGenericDataModel]()
           
        let data1 = TMGenericDataModel(imageD: imageData, dataD: "Create Service Requests")
        let data2 = TMGenericDataModel(imageD: imageData, dataD: "Emergency Tasks")
        let data3 = TMGenericDataModel(imageD: imageData, dataD: "Unassigned Work Tasks")
        let data4 = TMGenericDataModel(imageD: imageData, dataD: "Corrective Work Tasks")
        let data5 = TMGenericDataModel(imageD: imageData, dataD: "Preventive Work Tasks")
        let data6 = TMGenericDataModel(imageD: imageData, dataD: "On Hold Work Task")
        let data7 = TMGenericDataModel(imageD: imageData, dataD: "Completed Tasks")
        
        data.append(data1)
        data.append(data2)
        data.append(data3)
        data.append(data4)
        data.append(data5)
        data.append(data6)
        data.append(data7)
        
        return data
       }
    
}

