//
//  HomeTabViewController.swift
//  Technex18
//
//  Created by JOGENDRA on 26/06/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//


import UIKit
import LIHImageSlider
class HomeTabViewController: UIViewController {
    
    @IBOutlet weak var slider1Container: UIView!
    
    
    fileprivate var sliderVc1: LIHSliderViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Image slider configurations
        let scrollImages : [UIImage] = [UIImage(named: "handCoffeeBlur")!,UIImage(named: "path-grass-lawn-meadow")!,UIImage(named: "pexels-photo-30461")!,UIImage(named: "pexels-photo-46277")!,UIImage(named: "pexels-photo-87240")!]
        
        let slider1: LIHSlider = LIHSlider(images: scrollImages)
        slider1.customImageView?.contentMode = .scaleAspectFill
        slider1.sliderDescriptions = ["Image 1 description","Image 2 description","Image 3 description","Image 4 description","Image 5 description"]
        self.sliderVc1  = LIHSliderViewController(slider: slider1)
        sliderVc1.delegate = self as? LIHSliderDelegate
        //slider1.transitionStyle = .pageCurl
        self.addChildViewController(self.sliderVc1)
        self.view.addSubview(self.sliderVc1.view)
        self.sliderVc1.didMove(toParentViewController: self)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        self.sliderVc1!.view.frame = self.slider1Container.frame
    }
    
    
    func itemPressedAtIndex(index: Int) {
        
        print("index \(index) is pressed")
    }

    }
