//
//  CreateRequestModel.swift
//  TririgaM
//
//  Created by Shreyashi Mishra on 10/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import Foundation
import UIKit

struct TMCreateRequestModel: Decodable {
    var first_name : String
    var last_name : String
    var age : Int
}
