//
//  DataModel.swift
//  Poc
//
//  Created by Shreyashi Mishra on 04/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import Foundation
import UIKit

struct DataModel {
    var imageData : UIImage
    var dataLabel : String
    
    init(imageD: UIImage, dataD: String) {
        self.imageData = imageD
        self.dataLabel = dataD
    }
}
