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
    
    var headerData = [HeaderModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        createRequestTableVew.tableFooterView = UIView()
        headerData = getHeaderDetails()
    }
    
    func getHeaderDetails() -> [HeaderModel] {
        
        let headerdetails = HeaderModel.init(textdata:"Documents")
        return [headerdetails]
    }
    
    class func requestViewController() -> RequestViewController {
         guard let requestDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "serviceVC") as? RequestViewController
             else {
                 fatalError("Couldn't initialize contact detail View Controller")
         }
         return requestDetailVC
     }

}

extension RequestViewController: UITableViewDataSource, UITableViewDelegate {
    
      func numberOfSections(in tableView: UITableView) -> Int {
        return 2
       }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 1
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
          let cell = createRequestTableVew.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        } else {
            let dataCell =  createRequestTableVew.dequeueReusableCell(withIdentifier: "attachementCell", for: indexPath)
            return dataCell
        }
          
      }
      
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
        let label = UILabel()
        label.text = "Service Request"
        label.backgroundColor = UIColor.lightGray
        label.textAlignment = .center
        return label
        }else
        {
            let header = Bundle.main.loadNibNamed("AttachmentTableViewCell", owner: self, options: nil)?.first as? AttachmentTableViewCell
            header?.backgroundColor = UIColor.lightGray
            header?.attachmentLabel.text = headerData[0].textdata
            return header
            }

        }
    
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 400.0
      }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

}




