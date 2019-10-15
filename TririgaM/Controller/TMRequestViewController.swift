//
//  RequestViewController.swift
//  Poc
//
//  Created by Shreyashi Mishra on 01/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

class TMRequestViewController: UIViewController {

    
//Mark: IBOutlets
    
    @IBOutlet weak var createRequestTableVew: UITableView!
   
    var headerData = [TMHeaderCell]()
    var navtitle = ""
   
    var tag = 9
    override func viewDidLoad() {
        super.viewDidLoad()
        headerSetUP()
        headerData = getHeaderDetails()
        
        
    }
//Mark: - Header Setup
    
    func headerSetUP() {
        self.navigationItem.title = navtitle
        createRequestTableVew.tableFooterView = UIView()
    }
    
    
    func getHeaderDetails() -> [TMHeaderCell] {
        
        let headerdetails = TMHeaderCell.init(headerTextData:"Documents")
        return [headerdetails]
    }
    
    class func requestViewController() -> TMRequestViewController {
         guard let requestDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "serviceVC") as? TMRequestViewController
             else {
                 fatalError("Couldn't initialize contact detail View Controller")
         }
         return requestDetailVC
     }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "requestedFor"{
               let modalViewController = segue.destination as! TMModalViewController
               modalViewController.modalDelegate = self as? TMModalDelegate
              }
       }
    
    
//Mark: IBActions
    
    @IBAction func submitPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Request Alert", message: "Request Submitted Successfully", preferredStyle: .alert)


        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
         
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        
    }
    
}

//Mark: - TableView Delegates

extension TMRequestViewController: UITableViewDataSource, UITableViewDelegate {
    
      func numberOfSections(in tableView: UITableView) -> Int {
        return 2
       }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 1
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
           let cell = createRequestTableVew.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TMRequestTableViewCell
           cell?.requestCellDelegate = self
           return cell!
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
            header?.attachmentLabel.text = headerData[0].headerTextData
            return header
            }

        }

       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           
           let footerView = UIView()
           footerView.backgroundColor = UIColor.white
           return footerView
      }

      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return Constants.requestTableViewRowHeight
      }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return Constants.requestTableViewHeader
     }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
           return footerSectionHeight
    }

}

//Mark: - TMRequestTableViewCell Delegate
extension TMRequestViewController : TMRequestCellDelegate {

func textfieldButtonPressed(_ sender: UIButton) {
       tag = sender.tag
       performSegue(withIdentifier: "requestedFor", sender: sender)
       print(sender.tag)
   }

}


//Mark: - TMModalViewController Delegate
extension TMRequestViewController: TMModalDelegate {
    func loadModalData(message: String) {
         let  requestCell = createRequestTableVew.cellForRow(at: IndexPath(row:0 , section:0)) as? TMRequestTableViewCell
         
        switch tag {
        case 0:
            requestCell?.requestedTextField.text = message
        case 1:
            requestCell?.buildingTextField.text = message
        case 2:
            requestCell?.floorTextField.text = message
        case 3:
            requestCell?.roomTextField.text = message
        case 4:
            requestCell?.requestedClassTextField.text = message
        default:
            break
        }
        
    }

}
