//
//  SideBar.swift
//  Technex18
//
//  Created by JOGENDRA on 25/03/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit

@objc protocol SideBarDelegate {
    func SideBarDidSelectButtonAtIndex(_ index:Int)
    @objc optional func SideBarWillClose()
    @objc optional func SideBarWillOpen()
}

class SideBar: NSObject, SideBarTableViewControllerDelegate {
    
    let barWidth:CGFloat = 200.0
    let sideBarTableViewTopInset:CGFloat = 64.0
    let sideBarContainerView:UIView = UIView()
    let sideBarTableViewController : SideBarTableViewController = SideBarTableViewController()
    
    var originView:UIView?
    var animator:UIDynamicAnimator?
    var delegate:SideBarDelegate?
    var isSideBarOpen:Bool = false
    
    override init() {
        super.init()
    }
    
    init(sourceView:UIView, menuItems:Array<String>) {
        super.init()
        
        originView = sourceView
        sideBarTableViewController.tableData = menuItems
        animator = UIDynamicAnimator(referenceView: originView!)
        
        setupSideBar()
        
        let showGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SideBar.handleSwipe(_:)))
        showGestureRecognizer.direction = UISwipeGestureRecognizerDirection.right
        originView!.addGestureRecognizer(showGestureRecognizer)
        
        let hideGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SideBar.handleSwipe(_:)))
        hideGestureRecognizer.direction = UISwipeGestureRecognizerDirection.left
        originView!.addGestureRecognizer(hideGestureRecognizer)
    }
    
    func setupSideBar() {
        sideBarContainerView.frame = CGRect(x: -barWidth - 1, y: originView!.frame.origin.y, width: barWidth, height: originView!.frame.size.height)
        sideBarContainerView.backgroundColor = UIColor.white.withAlphaComponent(0.06)
        sideBarContainerView.clipsToBounds = false
        sideBarContainerView.layer.borderWidth = 0.4
        sideBarContainerView.layer.borderColor = UIColor.brown.cgColor
        
        originView!.addSubview(sideBarContainerView)
        
        let blurryView:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        blurryView.frame = sideBarContainerView.bounds
        sideBarContainerView.addSubview(blurryView)
        
        sideBarTableViewController.delegate = self
        sideBarTableViewController.tableView.frame = sideBarContainerView.bounds
        sideBarTableViewController.tableView.clipsToBounds = false
        sideBarTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        sideBarTableViewController.tableView.backgroundColor = UIColor.clear
        sideBarTableViewController.tableView.scrollsToTop = false
        sideBarTableViewController.tableView.contentInset = UIEdgeInsetsMake(sideBarTableViewTopInset, 0, 0, 0)
        sideBarTableViewController.tableView.delegate = sideBarTableViewController
        sideBarTableViewController.tableView.reloadData()
        sideBarContainerView.addSubview(sideBarTableViewController.tableView)
    }
    
    func handleSwipe(_ recognizer:UISwipeGestureRecognizer) {
        if recognizer.direction == UISwipeGestureRecognizerDirection.left {
            showSideBar(false)
            delegate?.SideBarWillClose?()
        } else {
            showSideBar(true)
        }
    }
    
    func showSideBar(_ shouldOpen:Bool) {
        animator!.removeAllBehaviors()
        isSideBarOpen = shouldOpen
        
        let gravityX:CGFloat = (shouldOpen) ? 0.5 : -0.5
        let magnitude:CGFloat = (shouldOpen) ? 20 : -20
        let boundaryX:CGFloat = (shouldOpen) ? barWidth : -barWidth - 1
        
        let gravityBehavior:UIGravityBehavior = UIGravityBehavior(items: [sideBarContainerView])
        gravityBehavior.gravityDirection = CGVector(dx: gravityX, dy: 0)
        animator!.addBehavior(gravityBehavior)
        
        let collisionBehavior:UICollisionBehavior = UICollisionBehavior(items: [sideBarContainerView])
        collisionBehavior.addBoundary(withIdentifier: "SideBarBoundary" as NSCopying, from: CGPoint(x: boundaryX, y: 20), to: CGPoint(x: boundaryX, y: originView!.frame.size.height))
        animator!.addBehavior(collisionBehavior)
        
        let pushBehavior:UIPushBehavior = UIPushBehavior(items: [sideBarContainerView], mode: UIPushBehaviorMode.instantaneous)
        pushBehavior.magnitude = magnitude
        animator!.addBehavior(pushBehavior)
        
        let SideBarBehavior:UIDynamicItemBehavior = UIDynamicItemBehavior(items: [sideBarContainerView])
        SideBarBehavior.elasticity = 0.3
        animator!.addBehavior(SideBarBehavior)
    }
    
    func SideBarControlDidSelectRow(_ indexPath: IndexPath) {
        delegate?.SideBarDidSelectButtonAtIndex(indexPath.row)
    }


}
