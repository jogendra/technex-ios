//
//  HomeTabTableViewController.swift
//  Technex18
//
//  Created by JOGENDRA on 24/06/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit
import CRRefresh

class HomeTabTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self;
        tableView.dataSource = self
        
        //Refresh table view
        tableView.cr.addHeadRefresh(animator: NormalHeaderAnimator()) { [weak self] in
            /// start refresh
            /// Do anything you want...
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                /// Stop refresh when your job finished, it will reset refresh footer if completion is true
                self?.tableView.cr.endHeaderRefresh()
            })
        }
        /// manual refresh
        tableView.cr.beginHeaderRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.separatorInset.left = 0.0
        cell.separatorInset.right = 0.0
        cell.separatorInset.top = 5.0
        cell.separatorInset.bottom = 5.0
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 0.0
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.backgroundColor = UIColor.black.cgColor
        cell.backgroundColor = UIColor.black

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //cell.setBackgroundColor = UIColor.black
    }
    
    
}
