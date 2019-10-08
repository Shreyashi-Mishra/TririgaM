//
//  PocViewController.swift
//  Poc
//
//  Created by Shreyashi Mishra on 30/09/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

class PocViewController: UIViewController {

    var dataModelArray = [DataModel]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        tableView.tableFooterView = UIView()
        registerTableViewCell()
        
        dataModelArray = getDataDetails()
        
    }
    
    func getDataDetails() -> [DataModel] {
        
        guard let imageData = UIImage(named: "images") else { return []}
        
        let data = DataModel(imageD: imageData, dataD: "Maintenance services")
        
        return [data]
    }
    
    func registerTableViewCell() {
          
          let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
          self.tableView.register(cellNib, forCellReuseIdentifier: "CustomTableViewCell")
      }
      
    
}

extension PocViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell
//        cell?.customLabel.text =
        cell?.setDataModel(dataM: dataModelArray[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskDetailViewController = TaskViewController.taskDetailViewController()
         navigationController?.pushViewController(taskDetailViewController, animated: true)
        
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    

}
