//
//  HomePageViewController.swift
//  Technex18
//
//  Created by JOGENDRA on 22/03/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, SideBarDelegate {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var sidebar:SideBar = SideBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //sidebar
        sidebar = SideBar(sourceView: self.view, menuItems: ["ITEM1", "ITEM2", "ITEM3", "ITEM4", "ITEM5", "ITEM6", "ITEM7", "ITEM8",]);
        sidebar.delegate = self;
        
        //parallax effect
        parallaxEffect()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
        
        if (!isUserLoggedIn){
            self.performSegue(withIdentifier: "loginView", sender: self);
            
        }
        else{
        
            self.performSegue(withIdentifier: "mainPage", sender: self);
        }
    }

    @IBAction func toggleMenu(_ sender: Any) {
        
        sidebar.showSideBar(!sidebar.isSideBarOpen);
    }
    //
    func SideBarDidSelectButtonAtIndex(_ index: Int) {
        
    }

    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn");
        UserDefaults.standard.synchronize();
        self.performSegue(withIdentifier: "loginView", sender: self);
    }
    
    //parallax effect
    func parallaxEffect(){
    
        let min = CGFloat(-50.0)
        let max = CGFloat(50.0)
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = min
        xMotion.maximumRelativeValue = max
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion, yMotion]
        
        backgroundImageView.addMotionEffect(motionEffectGroup)
    }
    
    
}
