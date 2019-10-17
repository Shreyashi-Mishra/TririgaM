//
//  TMModalViewController.swift
//  TririgaM
//
//  Created by Shreyashi Mishra on 10/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

//Mark: - Delegate to load Service Request Details

protocol TMModalDelegate : NSObjectProtocol {
    func loadModalData(message: String)
}

class TMModalViewController: UIViewController, UISearchControllerDelegate {
    
    @IBOutlet weak var modalTableView: UITableView!
    @IBOutlet var modalView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var serviceClass = TMServiceClass()
    weak var modalDelegate : TMModalDelegate?
    
    var arrayData =  [TMCreateRequestModel]()
    
    var searchArray = [TMCreateRequestModel]()
    var isSearching = false
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        getServiceData()
        
    }
    
    
    
    //Mark: - Service Call
    
    func getServiceData() {
        
        serviceClass.fetchJsonData { (response) in
            switch response {
            case .success(let requestData):
                requestData?.forEach({ (dataLog) in
                    print(dataLog.first_name)
                    self.arrayData.append(dataLog)
                })
                DispatchQueue.main.async {
                    self.modalTableView.reloadData()
                }
                
            case .failure(let error):
                print("Failed to Fetch Json Data \(error.localizedDescription)")
                
            }
            
        }
        
        
    }
    
    class func modelDetailViewController() -> TMModalViewController {
        guard let modalDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "modalVC") as? TMModalViewController
            else {
                fatalError("Couldn't initialize contact detail View Controller")
        }
        return modalDetailVC
    }
    
    //Mark: - IBActions
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


//Mark: - Tableview Delegates
extension TMModalViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return searchArray.count
        }
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = modalTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TMModalViewCell
        if isSearching {
            cell?.modalLabel.text = searchArray[indexPath.row].first_name
        } else {
            cell?.modalLabel.text = arrayData[indexPath.row].first_name
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearching {
            modalDelegate?.loadModalData(message: searchArray[indexPath.row].first_name )
        } else {
            modalDelegate?.loadModalData(message: arrayData[indexPath.row].first_name )
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}


//Mark:- SearchBar Delegates
extension TMModalViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchArray = arrayData.filter({$0.first_name.prefix(searchText.count) == searchText})
        isSearching = true
        modalTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        isSearching = false
        searchBar.text = ""
        modalTableView.reloadData()
        searchBar.resignFirstResponder()
    }
}


