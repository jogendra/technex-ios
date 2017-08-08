//
//  SideBarTableViewController.swift
//  Technex18
//
//  Created by JOGENDRA on 25/03/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit

protocol SideBarTableViewControllerDelegate {
    func SideBarControlDidSelectRow(_ indexPath: IndexPath)
}

class SideBarTableViewController: UITableViewController {

    var delegate:SideBarTableViewControllerDelegate?
    var tableData:Array<String> = []
    
    let icons = ["Developer_25","Feedback_25","AppleAppStore_25","Subscription_25","Developer_25","Website_25","Subscription_25","LogoutRoundedUpFilled_25"]
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?  = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            
            // Configure the cell...
            cell!.backgroundColor = UIColor.clear;
            cell!.textLabel?.textColor = UIColor.init(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0);
            cell?.layer.borderWidth = 0.25
            cell?.layer.borderColor = UIColor.gray.cgColor
            
            let selectedView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
            selectedView.backgroundColor = UIColor.black.withAlphaComponent(1.0)
            
            cell?.textLabel?.highlightedTextColor = UIColor.white
            
            cell!.selectedBackgroundView = selectedView;
            
            //adding left side images on cell
//            let itemImageView = UIImageView(frame: CGRect(x: -10, y: 0, width: 20, height: 20))
//            let itemImage = UIImage(named: "arrow-up.png")
//            itemImageView.image = itemImage;
//            cell?.addSubview(itemImageView);
        }
        
        cell?.imageView?.bounds = CGRect(x: 0, y: 0, width: 10, height: 10);

        cell?.imageView?.frame = CGRect(x: 0, y: 0, width: 10, height: 10);
        cell?.imageView?.contentMode = .scaleAspectFit
        cell?.imageView?.image = UIImage(named: icons[indexPath.row] )
        
        
        cell!.textLabel?.text = tableData[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.SideBarControlDidSelectRow(indexPath)
    }
    
}
