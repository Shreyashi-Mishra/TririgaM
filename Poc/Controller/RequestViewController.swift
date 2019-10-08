//
//  RequestViewController.swift
//  Poc
//
//  Created by Shreyashi Mishra on 01/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {

    @IBOutlet weak var createRequestTableVew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class func requestViewController() -> RequestViewController {
         guard let requestDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "serviceVC") as? RequestViewController
             else {
                 fatalError("Couldn't initialize contact detail View Controller")
         }
         return requestDetailVC
     }

}



