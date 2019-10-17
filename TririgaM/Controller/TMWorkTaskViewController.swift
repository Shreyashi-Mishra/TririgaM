//
//  TMWorkTaskViewController.swift
//  TririgaM
//
//  Created by Ratnadeep Govande on 17/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

class TMWorkTaskViewController: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var workTaskTableView: UITableView!
    
    // Variables...
    var serviceD_vm = TMWorkTaskViewModel()
    
    // MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // delegates...
        registerTableViewCell()
        workTaskTableView.delegate = self
        workTaskTableView.dataSource = self
        workTaskTableView.estimatedRowHeight = 50
        workTaskTableView.rowHeight = UITableView.automaticDimension
    }
    
    func registerTableViewCell() {
        
        let communication_cellNib = UINib.init(nibName: "TMWorkTaskCommunicationCell", bundle: nil)
        workTaskTableView.register(communication_cellNib, forCellReuseIdentifier: "WorkTaskCommunicationCell")
        
        let document_cellNib = UINib.init(nibName: "TMWorkTaskDocumentCell", bundle: nil)
        workTaskTableView.register(document_cellNib, forCellReuseIdentifier: "WorkTaskDocumentCell")
        
        let resource_cellNib = UINib.init(nibName: "TMWorkTaskResourceCell", bundle: nil)
        workTaskTableView.register(resource_cellNib, forCellReuseIdentifier: "WorkTaskResourceCell")
        
        let worktask_cellNib = UINib.init(nibName: "TMWorkTaskCell", bundle: nil)
        workTaskTableView.register(worktask_cellNib, forCellReuseIdentifier: "WorkTaskCell")
        
        let entry_cellNib = UINib.init(nibName: "TMWorkTaskTimeEntryCell", bundle: nil)
        workTaskTableView.register(entry_cellNib, forCellReuseIdentifier: "WorkTaskTimeEntryCell")
    }
    
    
    // MARK:- ButtonAction
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func completeButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func onHolderButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TMWorkTaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return serviceD_vm.headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            
            if let array = serviceD_vm.headers[section].info as? [Any] {
                return array.count
            }
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if serviceD_vm.headers[indexPath.section].name == "Documents" {
            
            // display information...
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkTaskDocumentCell", for: indexPath) as? TMWorkTaskDocumentCell
            if let doc_array = serviceD_vm.headers[indexPath.section].info as? [TMWorkTaskDocumentModel] {
                cell?.displayInformation(model: doc_array[indexPath.row])
            }
            return cell!
        }
        else if serviceD_vm.headers[indexPath.section].name == "Resources" {
            
            // display information...
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkTaskResourceCell", for: indexPath) as? TMWorkTaskResourceCell
            if let res_array = serviceD_vm.headers[indexPath.section].info as? [TMWorkTaskResourcesModel] {
                cell?.displayInformation(model: res_array[indexPath.row])
            }
            return cell!
        }
        else if serviceD_vm.headers[indexPath.section].name == "Communications" {
            
            // display information...
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkTaskCommunicationCell", for: indexPath) as? TMWorkTaskCommunicationCell
            if let com_array = serviceD_vm.headers[indexPath.section].info as? [TMWorkTaskCommunicationModel] {
                cell?.displayInformation(model: com_array[indexPath.row])
            }
            return cell!
        }
        else if serviceD_vm.headers[indexPath.section].name == "Time Entry" {
            
            // display information...
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkTaskCommunicationCell", for: indexPath) as? TMWorkTaskTimeEntryCell
            return cell!
        }
        else {
            
            // display information...
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkTaskCell", for: indexPath) as? TMWorkTaskCell
            if let ser_array = serviceD_vm.headers[indexPath.section].info as? [TMWorkTaskModel] {
                cell?.displayInformation(models_array: ser_array)
            }
            return cell!
        }
    }
    
    // MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // cell creation...
        var cell = tableView.dequeueReusableCell(withIdentifier: "WorkTaskHeaderCell") as? TMWorkTaskHeaderCell
        if cell == nil {
            tableView.register(UINib.init(nibName: "TMWorkTaskHeaderCell", bundle: nil), forCellReuseIdentifier: "WorkTaskHeaderCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "WorkTaskHeaderCell") as? TMWorkTaskHeaderCell
        }
    
        // left side add button hidden
        cell?.img_view.isHidden = true
        if serviceD_vm.headers[section].name == "Documents" || serviceD_vm.headers[section].name == "Communications" {
             cell?.img_view.isHidden = false
        }
        
        // display information...
        cell?.displayInformation(model: serviceD_vm.headers[section], section: section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = serviceD_vm.headers[indexPath.section].info
        print(obj as Any)
    }
}
