//
//  APSGroupedTableView.swift
//  APSGroupedTableView
//
//  Created by Aishwarya Pratap Singh on 9/29/16.
//  Copyright © 2016 Aishwarya Pratap Singh. All rights reserved.
//

import Foundation
import UIKit

protocol APSGroupedTableDataSource:class {
    func apstableview(tableView:APSGroupedTableView , cellForRowAt indexPath:IndexPath) -> UITableViewCell
    func apstableview(_ tableView: APSGroupedTableView, numberOfRowsIn section:Int) -> Int
    func apstableview(_ tableView: APSGroupedTableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}

protocol APSGroupedTableDelegte:class {
    func numberOfSections(in aps_tableView: APSGroupedTableView) -> Int
}

class APSGroupedTableView : UITableView,UITableViewDelegate,UITableViewDataSource{
    
    var rowsCount = 5;
    weak var apsDataSource:APSGroupedTableDataSource?
    weak var apsdelegate:APSGroupedTableDelegte?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style);
        self.separatorStyle = .none
        self.setDelegatesAndDataSource()
    }
    
    func setDelegatesAndDataSource() {
        self.delegate = self
        self.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numRows = apsDataSource?.apstableview(self, numberOfRowsIn: section) else{
            return 1
        }
        return numRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let numSections = apsdelegate?.numberOfSections(in: self) else{
            return 1
        }
        return numSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = apsDataSource?.apstableview(tableView: self, cellForRowAt: indexPath) else {
            return UITableViewCell(style: .default, reuseIdentifier: "DefaultCellIndentifier")
        }
        cell.tag = indexPath.section*100 + indexPath.row*10
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let height = apsDataSource?.apstableview(self, heightForRowAt: indexPath) else {
            return self.rowHeight
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func cellTapped(sender : AnyObject) {
        
        let button = sender as! UIButton
        
        let section = button.tag/100
        let row = (button.tag%100)/10
        let buttonIndex = (button.tag%100)%10
        
    }
}
