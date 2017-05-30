//
//  APSGroupedTableViewCell.swift
//  APSGroupedTableView
//
//  Created by Aishwarya Pratap Singh on 10/1/16.
//  Copyright © 2016 Aishwarya Pratap Singh. All rights reserved.
//

import UIKit

protocol APSGroupedCellDelegate: class {
    func apsGroupedCellDidTapButton(buttonIndex:[Int]);
}

class APSGroupedTableViewCell: UITableViewCell {

    weak var delegate:APSGroupedCellDelegate?
    let categoryWidth:CGFloat = 100.0
    let cellPadding:CGFloat = 10.0
    let corenerRadius = 2.0
    let categoryHeight = 50
    
    var categoryImage:UIImage = UIImage()
    var cellItems:Array<String> = []
    var cellCategoryName:String = ""
    
    var category_bg:UIColor = UIColor.red
    var separatorColor:UIColor = UIColor.black
    var content_bg:UIColor = UIColor.white
    var categoryTitleColor:UIColor = UIColor.white
    var customtextColor = UIColor.lightGray
    
    var shadowEnabled:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customViewForCell(cellIndex:Int) -> UIView {
        
        let objectCount = cellItems.count
        let customCellView = UIView(frame:CGRect(x: cellPadding, y: 5, width: self.frame.size.width - 2*cellPadding, height: CGFloat(objectCount*categoryHeight)))
        let timeParentView = UIView(frame:CGRect(x:0, y:0, width:categoryWidth, height:CGFloat(objectCount*categoryHeight)))
        timeParentView.backgroundColor = category_bg
        
        let timerView = self.viewForCategory(category: cellCategoryName)
        
        let timeSeparatorView = UILabel(frame: CGRect(x:categoryWidth-1, y:0, width:1, height:CGFloat(objectCount*categoryHeight)))
        let timeHoriSeparatorView = UILabel(frame: CGRect(x:0, y:(timeParentView.frame.size.height - 1), width:categoryWidth, height:1))
        timeSeparatorView.backgroundColor = separatorColor
        timeHoriSeparatorView.backgroundColor = separatorColor
        
        timeParentView .addSubview(timeHoriSeparatorView)
        timeParentView .addSubview(timeSeparatorView)
        timeParentView .addSubview(timerView)
        customCellView .addSubview(timeParentView)
        
        timerView.center = timeParentView.center
        
        for i in 0...(objectCount-1) {
            
            let ySpace = CGFloat(i*categoryHeight)
            
            let medButtonView = UIButton(frame:CGRect(x:categoryWidth, y:ySpace, width:self.frame.size.width - (categoryWidth + cellPadding), height:CGFloat(categoryHeight)))
            medButtonView.tag = cellIndex + i
            medButtonView.setTitle(cellItems[i], for: .normal)
            medButtonView.setTitleColor(customtextColor, for: .normal)
            medButtonView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            medButtonView.contentHorizontalAlignment = .left
            medButtonView.addTarget(self, action: #selector(self.cellTapped(sender:)), for: .touchUpInside)
            
            let medSeparatorLabel = UILabel(frame:CGRect(x:categoryWidth, y:ySpace + CGFloat(categoryHeight), width:self.frame.size.width - (categoryWidth + 2*cellPadding), height:1))
            medSeparatorLabel.backgroundColor = separatorColor
            
            customCellView.clipsToBounds = true
            customCellView .addSubview(medButtonView)
            customCellView .addSubview(medSeparatorLabel)
        }
        
        customCellView.backgroundColor = content_bg
        customCellView.layer.cornerRadius = CGFloat(corenerRadius)
        customCellView.layer.borderColor = separatorColor.cgColor
        customCellView.layer.borderWidth = 0.5
        
        if shadowEnabled {
            customCellView.layer.shadowColor = UIColor.lightGray.cgColor
            customCellView.layer.shadowRadius = 1
            customCellView.layer.shadowOpacity = 0.5
            customCellView.layer.masksToBounds = false
            customCellView.layer.shadowOffset = CGSize(width: 2, height: 2)
        }
        
        customCellView.tag = 101
        return customCellView
    }

    func viewForCategory(category:String) -> UIView {
        
        let categoryParentView = UIView(frame: CGRect(x:0, y:0, width:categoryWidth, height:30))
        
        let categoryParentImageView = UIImageView(frame: CGRect(x:5, y:8, width:15, height:15))
        let categoryLabelView = UILabel(frame: CGRect(x:30, y:5, width:categoryWidth, height:20))
        
        categoryParentImageView.image = categoryImage
        
        categoryLabelView.textColor = categoryTitleColor
        categoryLabelView.text = category
        categoryLabelView.font = UIFont .systemFont(ofSize: 14.0)
        categoryLabelView.textAlignment = .left
        
        categoryParentView .addSubview(categoryParentImageView)
        categoryParentView .addSubview(categoryLabelView)
        return categoryParentView
    }

    override func layoutSubviews() {
        self.contentView.subviews.forEach{$0.removeFromSuperview()}
        self.contentView.addSubview(customViewForCell(cellIndex: self.tag))
        super.layoutSubviews()
        
    }
    
    func cellTapped(sender : AnyObject) {
        
        let button = sender as! UIButton
        
        let section = button.tag/100
        let row = (button.tag%100)/10
        let buttonIndex = (button.tag%100)%10
        
        delegate?.apsGroupedCellDidTapButton(buttonIndex: [section,row,buttonIndex])
        
    }
}
