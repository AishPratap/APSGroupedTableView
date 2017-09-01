//
//  ViewController.swift
//  APSGroupedTableView
//
//  Created by Aishwarya Pratap Singh on 9/29/16.
//  Copyright © 2016 Aishwarya Pratap Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,APSGroupedTableDataSource,APSGroupedTableDelegte {
    
    let category_bg = UIColor .init(red: 231/255.0, green: 76/255.0, blue: 60/255.0, alpha: 1)
    let content_bg = UIColor.white
    
    var tableData = [String:Array<String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let table = APSGroupedTableView(frame: self.view.bounds, style: .plain);
        table.rowsCount = 10
        table.apsDataSource = self
        table.apsDelegate = self
        table.showsVerticalScrollIndicator = false
        tableData = self.mockData()
        table.register(APSGroupedTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
        self.view.addSubview(table)
        self.navigationController?.navigationBar.barTintColor = category_bg
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.view.backgroundColor = UIColor.white
        table.backgroundColor = UIColor.white

        self.title = "Demo"
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func mockData() -> [String:Array<String>] {
        var dataset = [String:Array<String>]()
        
        let arrayFirst = ["Data 1"]
        let arraySecond = ["Data 1", "Data 2"]
        let arrayThird = ["Data 1", "Data 2", "Data 3"]
        let arrayFourth = ["Data 1", "Data 2", "Data 3", "Data 4"]
        let arrayFifth = ["Data 1", "Data 2", "Data 3", "Data 4", "Data 5"]
        let arraySixth = ["Data 1", "Data 2", "Data 3", "Data 4", "Data 5", "Data 6"]
        
        dataset["One"] = arrayFirst
        dataset["Two"] = arraySecond
        dataset["Three"] = arrayThird
        dataset["Four"] = arrayFourth
        dataset["Five"] = arrayFifth
        dataset["Six"] = arraySixth
        
        return dataset
    }
    
    func apstableview(_ tableView: APSGroupedTableView, numberOfRowsIn section: Int) -> Int {
        
        return tableData.count
    }
    
    func apstableview(_ tableView: APSGroupedTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let keys = Array(tableData.keys)
        let objectCount = tableData[keys[indexPath.row]]?.count
        return CGFloat(objectCount! * 50 + 20)
    }
    
    func apstableview(tableView:APSGroupedTableView , cellForRowAt indexPath:IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! APSGroupedTableViewCell
        let keys = Array(tableData.keys)
        cell.cellCategoryName = keys[indexPath.row]
        cell.cellItems = tableData[keys[indexPath.row]]!
        cell.backgroundColor = content_bg
        
        cell.category_bg = category_bg
        cell.separatorColor = UIColor.darkGray
        cell.content_bg = content_bg
        cell.categoryTitleColor = UIColor.white
        cell.customtextColor = UIColor.lightGray
        cell.shadowEnabled = true
        
        cell.selectionStyle = .none
        return cell;
    }
    
    //MARK: - APSTableView Delegate
    func apsTableView(tableView:APSGroupedTableView, didTap index:[Int]){
        print(index);
    }
}

