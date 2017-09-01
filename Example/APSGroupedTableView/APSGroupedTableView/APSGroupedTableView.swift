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

protocol APSGroupedTableViewOptionalDatasources:class {
    func numberOfSections(tableView:APSGroupedTableView) -> Int
}

protocol APSGroupedTableDelegte:class {
    func apsTableView(tableView:APSGroupedTableView, didTap index:[Int])
}

class APSGroupedTableView : UITableView,UITableViewDelegate,UITableViewDataSource,APSGroupedCellDelegate{
    
    var rowsCount = 5;
    weak var apsDataSource:APSGroupedTableDataSource?
    weak var apsDelegate:APSGroupedTableDelegte?
    weak var apsOptionalDelegate:APSGroupedTableViewOptionalDatasources?
    
    
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
        guard let numSections = apsOptionalDelegate?.numberOfSections(tableView: self) else{
            return 1
        }
        return numSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:APSGroupedTableViewCell = apsDataSource?.apstableview(tableView: self, cellForRowAt: indexPath) as? APSGroupedTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "DefaultCellIndentifier")
        }
        cell.tag = indexPath.section*100 + indexPath.row*10
        cell.delegate = self
        
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
    
    //MARK: - Cell Delegate
    func apsGroupedCellDidTapButton(buttonIndex: [Int]) {
        apsDelegate?.apsTableView(tableView: self, didTap: buttonIndex)
    }
}
