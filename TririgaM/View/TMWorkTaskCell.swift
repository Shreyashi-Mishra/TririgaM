//
//  TMWorkTaskCell.swift
//  POC
//
//  Created by Kondaiah Veeraboyina on 08/10/19.
//  Copyright © 2019 Kondaiah Veeraboyina. All rights reserved.
//

import UIKit

class TMWorkTaskCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet weak var tbl_service: UITableView!
    @IBOutlet weak var tbl_HConstraint: NSLayoutConstraint!
    
    // variables...
    private var serice_array: [TMWorkTaskModel] = []
    
    
    // MARK:-
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    deinit {
        tbl_service.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    // MARK:-
    func displayInformation(models_array: [TMWorkTaskModel]) -> Void {
        
        serice_array = models_array
        
        // table delegates...
        registerTableViewCell()
        tbl_service.delegate = self
        tbl_service.dataSource = self
        tbl_service.estimatedRowHeight = 40
        tbl_service.rowHeight = UITableView.automaticDimension
        tbl_service.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    func registerTableViewCell() {
        let cellNib = UINib(nibName: "TMWorkTaskSubCell", bundle: nil)
        tbl_service.register(cellNib, forCellReuseIdentifier: "WorkTaskSubCell")
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == tbl_service, keyPath == "contentSize", let contentSize = change?[NSKeyValueChangeKey.newKey] as? CGSize {
                
                print("contentSize:", tbl_service.contentSize)
                tbl_service.setNeedsUpdateConstraints()
                tbl_service.layoutIfNeeded()
                tbl_HConstraint.constant = contentSize.height
            }
        }
    }
}


extension TMWorkTaskCell: UITableViewDelegate, UITableViewDataSource {
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serice_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        // display information...
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkTaskSubCell", for: indexPath) as? TMWorkTaskSubCell
        cell?.displayInformation(model: serice_array[indexPath.row])
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
