//
//  ServiceTitleModel.swift
//  POC
//
//  Created by Kondaiah Veeraboyina on 08/10/19.
//  Copyright © 2019 Kondaiah Veeraboyina. All rights reserved.
//

import Foundation


struct TMWorkTaskHeaderModel {
    
    var name: String?
    var image: String?
    var info: Any?
}

struct TMWorkTaskModel {
    
    var title: String?
    var description: String?
    
    var email: String?
    var phone: String?
    var latitude: String?
    var longitude: String?
    
    var phone_flag: Bool = false
    var message_flag: Bool = false
    var email_flag: Bool = false
    var map_flag: Bool = false
}


struct TMWorkTaskDocumentModel {
    
    var name: String?
    var path: String?
    var type: String?
}

struct TMWorkTaskResourcesModel {
    
    var name: String?
    var status: String?
}

struct TMWorkTaskCommunicationModel {
    
    var name: String?
    var description: String?
}
