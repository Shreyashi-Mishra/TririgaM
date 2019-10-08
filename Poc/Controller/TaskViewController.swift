//
//  TaskViewController.swift
//  Poc
//
//  Created by Shreyashi Mishra on 30/09/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    
    var dataModelArray11 = [DataModel]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Task"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        self.navigationController?.navigationBar.tintColor = UIColor.red
        taskTableView.tableFooterView = UIView()
        registerTableViewCell()
        dataModelArray11 = getDataDetails()
       
    }
    
    func getDataDetails() -> [DataModel] {
           
        guard let imageData = UIImage(named: "images") else { return []}
        var data = [DataModel]()
           
        let data1 = DataModel(imageD: imageData, dataD: "Create Service Requests")
        let data2 = DataModel(imageD: imageData, dataD: "Emergency Tasks")
        let data3 = DataModel(imageD: imageData, dataD: "Unassigned Work Tasks")
        let data4 = DataModel(imageD: imageData, dataD: "Corrective Work Tasks")
        let data5 = DataModel(imageD: imageData, dataD: "Preventive Work Tasks")
        let data6 = DataModel(imageD: imageData, dataD: "On Hold Work Task")
        let data7 = DataModel(imageD: imageData, dataD: "Completed Tasks")
        
        data.append(data1)
        data.append(data2)
        data.append(data3)
        data.append(data4)
        data.append(data5)
        data.append(data6)
        data.append(data7)
        
        return data
       }
       
    

    class func taskDetailViewController() -> TaskViewController {
        guard let taskDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "requestVC") as? TaskViewController
            else {
                fatalError("Couldn't initialize contact detail View Controller")
        }
        return taskDetailVC
    }
    
    func registerTableViewCell() {
          
          let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
          self.taskTableView.register(cellNib, forCellReuseIdentifier: "CustomTableViewCell")
      }
      

}


extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModelArray11.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell
        cell?.setDataModel(dataM: dataModelArray11[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let requestDetailViewController = RequestViewController.requestViewController()
         navigationController?.pushViewController(requestDetailViewController, animated: true)

    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    
}
