//
//  DataModel.swift
//  Poc
//
//  Created by Shreyashi Mishra on 04/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import Foundation
import UIKit

struct TMGenericDataModel {
    var genericImageData : UIImage
    var genericDataLabel : String
    
    init(imageD: UIImage, dataD: String) {
        self.genericImageData = imageD
        self.genericDataLabel = dataD
    }
}
