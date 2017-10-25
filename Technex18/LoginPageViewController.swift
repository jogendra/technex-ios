//
//  LoginPageViewController.swift
//  Technex18
//
//  Created by JOGENDRA on 22/03/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit
import Firebase

class LoginPageViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var userEmailTextField: UITextField!

    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //return key delegates
        self.userEmailTextField.delegate = self
        self.userPasswordTextField.delegate = self

        //border radius on text fields
        userEmailTextField.layer.cornerRadius = 5.0;
        userPasswordTextField.layer.cornerRadius = 5.0;
        
        //change color of placeholder
        userEmailTextField.attributedPlaceholder = NSAttributedString(string: "USERNAME OR EMAIL", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray] );
        userPasswordTextField.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray] );
        
        //textfield left icon and padding
//        userEmailTextField.leftViewMode = UITextFieldViewMode.always
//        let emailView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40));
//        userEmailTextField.leftView = emailView;
//        
//        userPasswordTextField.leftViewMode = UITextFieldViewMode.always
//        let passwordView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40));
//        userPasswordTextField.leftView = passwordView;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let userEmail = userEmailTextField.text,let
            userPassword = userPasswordTextField.text
            else{
                
                print("Form is invalid!")
                return
        }
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword, completion: {(user,error) in
            if let error = error {
                print(error)
                return
            }
        });
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn");
        UserDefaults.standard.synchronize();
        self.dismiss(animated: true, completion: nil)
        
        
        
//        let userEmail = userEmailTextField.text;
//        let userPassword = userPasswordTextField.text;
//        let userEmailStored = UserDefaults.standard.string(forKey: "userEmail");
//        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword");
//        
//        if ((userEmail?.isEmpty)! || (userPassword?.isEmpty)!){
//            displayMyAlertMessage(userMessage: "All fields are required!");
//            return;
//        }
//        
//        if (userEmailStored == userEmail){
//            if (userPasswordStored == userPassword){
//                //Login is successfull
//                UserDefaults.standard.set(true, forKey: "isUserLoggedIn");
//                UserDefaults.standard.synchronize();
//                
//                self.dismiss(animated: true, completion: nil);
//            }
//        }
//        if ((userEmailStored != userEmail) || (userPasswordStored != userPassword)){
//            
//            displayMyAlertMessage(userMessage: "Incorrect username or password!");
//            return;
//        }
    }
    
    //Alert message
    func displayMyAlertMessage(userMessage: String){
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.view.frame
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { ACTION in
            visualEffectView.removeFromSuperview()
        });
        
        myAlert.addAction(okAction);
        self.view.addSubview(visualEffectView)
        
        self.present(myAlert, animated: true, completion: nil);
        
    }

    //touch function - hide keyboard when tap on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    //UIText field delegate - hide keyboard when tap 'return' key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder();
        return true
    }
    
    @IBAction func fbButtonPressed(_ sender: Any) {
        let fbURLWeb = URL(string: "https://www.facebook.com/jogendra.singh24")
        let fbURLId = URL(string: "fb://profile/837267429744452")
        
        openApplication(fbURLId!,fbURLWeb!)
    }
    
    func openApplication(_ URLId: URL, _ URLWeb:URL ){
        if(UIApplication.shared.canOpenURL(URLId)){
            
            UIApplication.shared.open(URLId, options: [:], completionHandler: nil)
        }
        else{
            
            UIApplication.shared.open(URLWeb, options: [:], completionHandler: nil)
        }
    }

}
