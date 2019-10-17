//
//  PocViewController.swift
//  Poc
//
//  Created by Shreyashi Mishra on 30/09/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

class TMHomeViewController: UIViewController {
    
    //Mark:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    var dataModelArray = [TMGenericDataModel]()
    
    var serviceClass = TMServiceClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerSetUp()
        serviceClass.getDataDetails { (data) in
            self.dataModelArray.append(contentsOf: data!)
        }
        
    }
    
    //Mark: - Header Setup
    func headerSetUp() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        tableView.tableFooterView = UIView()
        registerTableViewCell()
    }
    
    
    func registerTableViewCell() {
        
        let cellNib = UINib(nibName: "TMGenericCustomCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "GenericCustomCell")
    }
    
    
}

//Mark: - TableView Delegates

extension TMHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenericCustomCell", for: indexPath) as? TMGenericCustomCell
        cell?.setDataModel(dataM: dataModelArray[indexPath.row])
        cell?.customImageView.circuler()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let taskDetailViewController = TMTaskViewController.taskDetailViewController()
        navigationController?.pushViewController(taskDetailViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.dataTableViewRowHeight
    }
    
    
}
