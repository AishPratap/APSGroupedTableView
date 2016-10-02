//
//  ViewController.swift
//  APSGroupedTableView
//
//  Created by Aishwarya Pratap Singh on 9/29/16.
//  Copyright © 2016 Aishwarya Pratap Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,APSGroupedTableDataSource {

    let category_bg = UIColor .init(colorLiteralRed: 22.0/255.0, green: 151.0/255.0, blue: 136.0/255.0, alpha: 1)
    let content_bg = UIColor .init(colorLiteralRed: 224.0/255.0, green: 226.0/255.0, blue: 196.0/255.0, alpha: 1)

    var tableData = [String:Array<String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let table = APSGroupedTableView(frame: self.view.bounds, style: .plain);
        table.rowsCount = 10
        table.apsDataSource = self
        table.showsVerticalScrollIndicator = false
        tableData = self.mockData()
        table.register(APSGroupedTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
        self.view.addSubview(table)
        self.navigationController?.navigationBar.barTintColor = category_bg
        self.view.backgroundColor = content_bg
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
        cell.selectionStyle = .none
        return cell;
    }
}

