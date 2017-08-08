//
//  UserTabViewController.swift
//  Technex18
//
//  Created by JOGENDRA on 12/05/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

class UserTabViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SideBarDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var uploadButtonOutlet: DesignableButton!
    
    @IBOutlet weak var userName: UILabel!
    //    import sidebar class
    var sidebar:SideBar = SideBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //status bar color
        UIApplication.shared.statusBarStyle = .default
        
        //sidebar
        sidebar = SideBar(sourceView: self.view, menuItems: ["About Us", "Send Feedback", "Rate Us", "ITEM4", "ITEM5", "Visit Website", "Subscribe", "Logout",]);

        sidebar.delegate = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func userInfo(){
    
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
            
                self.userName.text = dictionary["name"] as? String
            }
        })
    }

    @IBAction func userLogout(_ sender: Any) {
        
        
        do{
            try Auth.auth().signOut()
        } catch let logoutError{
            print(logoutError)
        }
        
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn");
        UserDefaults.standard.synchronize();
        self.performSegue(withIdentifier: "backToLogin", sender: self);
        
    }
    
    @IBAction func userImageButton(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                self.displayMyAlertMessage(userMessage: "Camera not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler:nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image;
        picker.dismiss(animated: true, completion: nil);
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func displayMyAlertMessage(userMessage: String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
        
    }
    
//    Side bar functions
    @IBAction func toggleMenu(_ sender: Any) {
        
        sidebar.showSideBar(!sidebar.isSideBarOpen);
    }
    
    func SideBarDidSelectButtonAtIndex(_ index: Int) {
        
        switch index{
        
        case 0:
            self.performSegue(withIdentifier: "aboutUs", sender: self)
            break
        case 1:
            let mailComposeViewController = configureMailComposeViewController()
            
            if MFMailComposeViewController.canSendMail(){
                
                self.present(mailComposeViewController, animated: true, completion: nil)
            }
            else{
                
                showSendMailErrorAlert()
            }
            break
        case 2:
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

            break
            
        case 6:
            let subscribeAlert = UIAlertController(title: "Subscribe here", message: "Subscribe here we will send you new update and features", preferredStyle: .alert)
            subscribeAlert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "Enter your email"
                textField.borderStyle = .roundedRect
                textField.clearButtonMode = .always
            })
            subscribeAlert.addAction(UIAlertAction(title: "Subscribe", style: .default, handler: nil))
            subscribeAlert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
            self.present(subscribeAlert, animated: true, completion: nil)
            break
            
        case 7:
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn");
            UserDefaults.standard.synchronize();
            self.performSegue(withIdentifier: "backToLogin", sender: self);
            break
            
        default:
            break
            
        }
        
    }
    
//    functions for mail composer controller - send us feedback
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

}
