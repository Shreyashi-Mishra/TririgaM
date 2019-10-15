//
//  TaskViewController.swift
//  Poc
//
//  Created by Shreyashi Mishra on 30/09/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

class TMTaskViewController: UIViewController {

//Mark: - IBoutlets
    @IBOutlet weak var taskTableView: UITableView!
    
    var dataArray = [TMGenericDataModel]()
    var serviceClass = TMServiceClass()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        headerSetup()
        registerTableViewCell()
        serviceClass.getTaskDetails(completion: { (data) in
        self.dataArray.append(contentsOf: data!)
        })
       
    }

//Mark: - Header setup
    func headerSetup() {
        
        self.navigationItem.title = "Task"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        self.navigationController?.navigationBar.tintColor = UIColor.red
        taskTableView.tableFooterView = UIView()

    }
    
    
    class func taskDetailViewController() -> TMTaskViewController {
        guard let taskDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "requestVC") as? TMTaskViewController
            else {
                fatalError("Couldn't initialize contact detail View Controller")
        }
        return taskDetailVC
    }
    
    func registerTableViewCell() {
          
          let cellNib = UINib(nibName: "TMGenericCustomCell", bundle: nil)
          self.taskTableView.register(cellNib, forCellReuseIdentifier: "GenericCustomCell")
      }
      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "requestController"{
            let requestViewController = segue.destination as! TMRequestViewController
            requestViewController.navtitle = dataArray[sender as! Int].genericDataLabel
           }
    }

}


//Mark: - Tableview Delegates

extension TMTaskViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "GenericCustomCell", for: indexPath) as? TMGenericCustomCell
        cell?.setDataModel(dataM: dataArray[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
         performSegue(withIdentifier: "requestController", sender: indexPath.row)

    }
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.dataTableViewRowHeight
    }
    
    
}
