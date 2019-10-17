//
//  AttachmentModel.swift
//  Attachments
//
//  Created by Sharvari H V on 10/3/19.
//  Copyright © 2019 Sharvari H V. All rights reserved.
//

import Foundation

struct Attachments: Codable
{
    var resource,document: [AttachmentModel]
    var allAttachments : [AttachmentModel] {
        self.resource + self.document
    }
}

struct AttachmentModel: Codable {
    var name: String?
    var content : Data?
    var fileExtension : String?
    var url : URL?
    var fileName: String? {
        if let localFileName = name{
            return localFileName
        }else if let url = self.url{
            return url.lastPathComponent
        }else {
            return nil
        }
    }
    var delete_flag : Bool?
}
