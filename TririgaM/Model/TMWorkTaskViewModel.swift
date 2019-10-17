//
//  ServiceDetailsVM.swift
//  POC
//
//  Created by Kondaiah Veeraboyina on 08/10/19.
//  Copyright © 2019 Kondaiah Veeraboyina. All rights reserved.
//

import UIKit
import Foundation

class TMWorkTaskViewModel: NSObject {

    var headers: [TMWorkTaskHeaderModel] = []
   
    override init() {
        super.init()
        getPrepareInformationModels()
    }
}

extension TMWorkTaskViewModel {
    
    func getPrepareInformationModels() -> Void {
        
        // service preparing...
        var service: [TMWorkTaskModel] = []
        service.append(TMWorkTaskModel.init(title: "Take Name", description: "CM-Plumbing"))
        service.append(TMWorkTaskModel.init(title: "Description", description: "Urgent request. There is a pipe on the first of Tantanu that keeps rattling and looks like it may burst"))
        service.append(TMWorkTaskModel.init(title: "Status", description: "Active"))
        service.append(TMWorkTaskModel.init(title: "Priority", description: "High"))
        
        service.append(TMWorkTaskModel.init(title: "Request Class", description: "Pluming"))
        service.append(TMWorkTaskModel.init(title: "Building", description: "Tantanu 7B, First Floor, 1001-1", map_flag: true))
        service.append(TMWorkTaskModel.init(title: "Created Date", description: "09/10/2018 15:21"))
        service.append(TMWorkTaskModel.init(title: "Requested For", description: "Kelly Nicodemo"))
        
        service.append(TMWorkTaskModel.init(title: "Resp. Org.", description: "Apple Maintenance Technicians"))
        service.append(TMWorkTaskModel.init(title: "Resp. Person", description: "Josh Welter", phone_flag: true, message_flag: true, map_flag: true))
        service.append(TMWorkTaskModel.init(title: "Resp. Coord.", description: "Scott Kindlund", phone_flag: true, message_flag: true))
        headers.append(TMWorkTaskHeaderModel(name: "SR-1117231", image: "ic_camera", info: service))
        
        
        // documents...
        var documents: [TMWorkTaskDocumentModel] = []
        documents.append(TMWorkTaskDocumentModel.init(name: "image.png", path: "", type: "image"))
        documents.append(TMWorkTaskDocumentModel.init(name: "video.mp4", path: "", type: "video"))
        documents.append(TMWorkTaskDocumentModel.init(name: "audio.mp4", path: "", type: "audio"))
        headers.append(TMWorkTaskHeaderModel(name: "Documents", image: "ic_camera", info: documents))
        
        
        // Resources...
        var resources: [TMWorkTaskResourcesModel] = []
        resources.append(TMWorkTaskResourcesModel.init(name: "Jsoh Welter", status: "Active"))
        resources.append(TMWorkTaskResourcesModel.init(name: "Morgan Freeman", status: "Active"))
        resources.append(TMWorkTaskResourcesModel.init(name: "Anthony Hopkins", status: "Active"))
        headers.append(TMWorkTaskHeaderModel(name: "Resources", image: "ic_plus", info: resources))
        
        
        // communications...
        var communications: [TMWorkTaskCommunicationModel] = []
        communications.append(TMWorkTaskCommunicationModel.init(name: "Scott Kindlund", description: "Hi Josh can you take care of this."))
        communications.append(TMWorkTaskCommunicationModel.init(name: "Scott Kindlund", description: "Hi Eric can you take care of this."))
        communications.append(TMWorkTaskCommunicationModel.init(name: "Scott Kindlund", description: "Hi Jeff can you take care of this."))
        headers.append(TMWorkTaskHeaderModel(name: "Communications", image: "ic_plus", info:  communications))
        
        //headers.append(TMWorkTaskHeaderModel(name: "Time Entry", image: "ic_plus", info: ""))
    }
}
