//
//  RequestViewController.swift
//  Poc
//
//  Created by Shreyashi Mishra on 01/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

class TMRequestViewController: UIViewController {

    @IBOutlet weak var createRequestTableVew: UITableView!
    
    var headerData = [TMHeaderCell]()
    override func viewDidLoad() {
        super.viewDidLoad()
        createRequestTableVew.tableFooterView = UIView()
        headerData = getHeaderDetails()
    }
    
    func getHeaderDetails() -> [TMHeaderCell] {
        
        let headerdetails = TMHeaderCell.init(textdata:"Documents")
        return [headerdetails]
    }
    
    class func requestViewController() -> TMRequestViewController {
         guard let requestDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "serviceVC") as? TMRequestViewController
             else {
                 fatalError("Couldn't initialize contact detail View Controller")
         }
         return requestDetailVC
     }

}

extension TMRequestViewController: UITableViewDataSource, UITableViewDelegate {
    
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
            let header = Bundle.main.loadNibNamed("TMAttachmentCell", owner: self, options: nil)?.first as? TMAttachmentCell
            header?.backgroundColor = UIColor.lightGray
            header?.attachmentLabel.text = headerData[0].textdata
            return header
            }

        }
    
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.requestTableViewRowHeight
      }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.requestTableViewHeader
    }

}




