//
//  AboutUsViewController.swift
//  Technex18
//
//  Created by JOGENDRA on 20/05/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit
import MessageUI

class AboutUsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rateUsButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Rate Us!", message: "\nAre you enjoying our app? Please rate us in the App Store!\n\nElse if you know of ways we can make our app better, please send us feedback so we can improve the experience for you!\n\nThanks!\n\nTech Team Technex '18", preferredStyle: .alert)
        let ituneAction = UIAlertAction(title: "Rate on iTunes", style: .default, handler: nil)
        
        alertController.addAction(ituneAction)
        
        alertController.addAction(UIAlertAction(title: "Send Us Feedback", style: .default, handler: { (action: UIAlertAction) in
            let mailComposeViewController = self.configureMailComposeViewController()
            if MFMailComposeViewController.canSendMail(){
                
                self.present(mailComposeViewController, animated: true, completion: nil)
            }
            else{
                
                self.showSendMailErrorAlert()
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancle", style: .default, handler: nil))
        
        present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func sendFeedbackButtonTapped(_ sender: Any) {
        
        let mailComposeViewController = configureMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail(){
            
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
        else{
            
            showSendMailErrorAlert()
        }
    }

    
    
    func configureMailComposeViewController() -> MFMailComposeViewController{
        
        let mailComposeVC = MFMailComposeViewController()
        
        mailComposeVC.mailComposeDelegate = self
        
        
        mailComposeVC.setToRecipients(["jogendra.kumar.phy15@iitbhu.ac.in"])
        mailComposeVC.setSubject("Technex '18 iOS App Feedback")
        mailComposeVC.setMessageBody("Hi Jogendra!\n\nI would like to share the following feedback:\n\n", isHTML: false)
        
        return mailComposeVC
    }
    
    func showSendMailErrorAlert(){
        
        let sendMailErrorAlert = UIAlertController(title: "Could Not Sent Mail", message: "Your device could not send e-mail. Please check e-mail configuration and try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        sendMailErrorAlert.addAction(okAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    @IBAction func backToSeenButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


}
