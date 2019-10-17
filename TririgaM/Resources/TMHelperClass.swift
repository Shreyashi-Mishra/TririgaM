//
//  HelperClass.swift
//  Attachments
//
//  Created by Sharvari H V on 10/4/19.
//  Copyright © 2019 Sharvari H V. All rights reserved.
//

import UIKit

final class HelperClass {
    class func getDateTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss.SSS"
        return #" (\#(dateFormatter.string(from: date)))"#
        
    }
}

extension UIAlertController{
    static func createAlert(title: String, message: String, viewController : UIViewController) {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

enum Extensions: String{
    case Image
    case Video
}

enum Image {
    case jpg,png,svg,jpeg
}

enum Video {
    case mov, mp4
}
