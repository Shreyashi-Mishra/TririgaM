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
    
    let attachment = AttachmentHelper()
    var attachmentCollection = [AttachmentModel]()
    var headerData = [TMHeaderCell]()
    
    var navtitle = ""
    
    var tag = 9
    override func viewDidLoad() {
        super.viewDidLoad()
        headerSetUP()
        headerData = getHeaderDetails()
        
        registerTableViewCell()
        attachment.delegate = self
        fetchAttachments(fetchAttachment)
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
    
    func registerTableViewCell() {
        let nib = UINib(nibName: "TMAttachmentTableViewCell", bundle: nil)
        createRequestTableVew.register(nib, forCellReuseIdentifier: "TMAttachmentTableViewCell")
    }
    
    func fetchAttachments(_ isViewRequest : Bool) {
        if isViewRequest {
            let url = URL(string: testURL)!
            let request = ServiceClass.init(url: url, httpMethod: .get)
            request.prepareHTTPRequest(data: nil)
            request.serviceRequest { (serviceResponse) in
                switch serviceResponse{
                case .success( _) :
                    if let path = Bundle.main.path(forResource: "AttachmentJSON", ofType: "json") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                            let decoder = JSONDecoder()
                            let attachmentreceived = try decoder.decode(Attachments.self, from: data)
                            self.attachmentCollection = attachmentreceived.allAttachments
                            
                            DispatchQueue.main.async {
                                self.attachment.viewController = self
                                self.createRequestTableVew.reloadData()
                            }
                        } catch let error {
                            print(error.localizedDescription)
                        }
                        
                    }
                    
                case .failure(let error) :
                    UIAlertController.createAlert(title: "Error", message: error.rawValue, viewController: self)
                    
                }
            }
        }
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

extension TMRequestViewController: UITableViewDataSource, UITableViewDelegate, AttachmentCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return attachmentCollection.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = createRequestTableVew.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TMRequestTableViewCell
            cell?.requestCellDelegate = self
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TMAttachmentTableViewCell", for: indexPath) as! TMAttachmentTableViewCell
            
            cell.setViewDetails(attachmentCollection[indexPath.row])
            cell.deleteButton.tag = indexPath.row
            cell.cellDelegate = self
            
            return cell
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
            header?.delegate = self
            return header
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        footerView.backgroundColor = UIColor.white
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return Constants.requestTableViewRowHeight
        }
        else {
            return Constants.requestTableViewAttachmentRowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.requestTableViewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerSectionHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if attachmentCollection.count > indexPath.row {
            let model = attachmentCollection[indexPath.row]
            attachment.presentAttachment(model)
            
        }
    }
    
    // Mark : cell delegate function
    func deleteButton(cell : UITableViewCell) {
        
        if let deletionIndexPath = createRequestTableVew.indexPath(for: cell) {
            attachmentCollection.remove(at: deletionIndexPath.row)
            createRequestTableVew.deleteRows(at: [deletionIndexPath], with: .automatic)
        }
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
            
            if(requestCell?.buildingTextField.text == "") {
                requestCell?.floorTextField.text = ""
            } else {
                requestCell?.floorTextField.text = message
            }
            
        case 3:
            
            if(requestCell?.floorTextField.text == "") {
                requestCell?.roomTextField.text = ""
            }else {
                requestCell?.roomTextField.text = message
            }
        case 4:
            
            requestCell?.requestedClassTextField.text = message
        default:
            break
        }
        
    }
    
}


extension TMRequestViewController: AttachmentHeaderCellDelegate{
    func attachmentTapped(){
        attachment.selectAttachmentTapped(viewController: self)
    }
}

extension TMRequestViewController : AttachmentDelegate {
    func updateAttachment(attachment: AttachmentModel) {
        var addedAttachment = attachment
        addedAttachment.delete_flag = false
        self.attachmentCollection.append(addedAttachment)
        self.createRequestTableVew.reloadData()
    }
}
