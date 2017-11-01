//
//  RegisterPageViewController.swift
//  Technex18
//
//  Created by JOGENDRA on 22/03/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit
import Firebase

class RegisterPageViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var userEmailIdTextField: UITextField!
    
    @IBOutlet weak var userCollegeTextField: UITextField!
    
    @IBOutlet weak var userYearTextField: UITextField!
    
    @IBOutlet weak var registerPasswordTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var toggleMenuButton: UIButton!
    
    
    @IBOutlet weak var fbButton: UIButton!
    
    @IBOutlet weak var googleButton: UIButton!
    
    @IBOutlet weak var twitterButton: UIButton!
    
    @IBOutlet weak var instaButton: UIButton!
    
    @IBOutlet weak var registerHereLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textfield return key delegate
        
        
        //change color of placeholder
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "FULL NAME", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray] );
        userEmailIdTextField.attributedPlaceholder = NSAttributedString(string: "YOUR EMAIL ID", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray] );
        userCollegeTextField.attributedPlaceholder = NSAttributedString(string: "COLLEGE NAME", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray] );
        userYearTextField.attributedPlaceholder = NSAttributedString(string: "YEAR", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray] );
        registerPasswordTextField.attributedPlaceholder = NSAttributedString(string: "CREATE PASSWORD", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray] );
        repeatPasswordTextField.attributedPlaceholder = NSAttributedString(string: "REPEAT PASSWORD", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray] );
        
        registerButton.layer.cornerRadius = 5.0
        
        //set rounded button for up arrow
        buttonView.layer.cornerRadius = 22.0
        
        
                
        
        //hide social buttons initially
        fbButton.alpha = 0
        googleButton.alpha = 0
        twitterButton.alpha = 0
        instaButton.alpha = 0
        
        registerButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        
        
    }
    
    @objc func handleRegistration(){
    
        guard let userName = userNameTextField.text, let userEmail = userEmailIdTextField.text,let
            userPassword = registerPasswordTextField.text
            else{
        
                print("Form is invalid!")
                return
            }
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword, completion: {(user: User?, error) in
            
            if let error = error{
                
                print(error)
                return
            }
            
            guard let uid = user?.uid else{return}
            
            //successfully login
            let ref = Database.database().reference(fromURL: "https://technex-ios.firebaseio.com/")
            let userReference = ref.child("users").child(uid)
            let values = ["name":userName, "email":userEmail]
            userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
                
                if let err = err {
                
                    print(err)
                    return
                }
                print("user saved into database")
            
            })
        
        });
        
        if(userPassword.characters.count<6){
        
            displayMyAlertMessage(userMessage: "Password should be at least 6 characters")
        }
        
        //Display alert message with confirmation
                let myAlert = UIAlertController(title: "Alert", message: "Registration is successfull. Thank You!", preferredStyle: UIAlertControllerStyle.alert);
        
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ action in
                    self.dismiss(animated: true, completion: nil);
                }
        
                myAlert.addAction(okAction);
                self.present(myAlert, animated: true, completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        
        if buttonView.transform == CGAffineTransform.identity{
            UIView.animate(withDuration: 1, animations: {
                self.buttonView.transform = CGAffineTransform(scaleX: 11, y: 11);
                self.menuView.transform = CGAffineTransform(translationX: 0, y: -73);
                self.toggleMenuButton.transform = CGAffineTransform(rotationAngle: self.radians(180));
            }) { (true) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.toggleSharedButtons();
                })
            }
        } else {
            UIView.animate(withDuration: 1, animations: {
                self.buttonView.transform = .identity
                self.menuView.transform = .identity
                self.toggleMenuButton.transform = .identity
                self.toggleSharedButtons();
            })
        }
    }
    
    func toggleSharedButtons(){
        let alpha = CGFloat(fbButton.alpha == 0 ? 1 : 0);
        
        fbButton.alpha = alpha
        googleButton.alpha = alpha
        twitterButton.alpha = alpha
        instaButton.alpha = alpha
        
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
//        let userName = userNameTextField.text;
//        let userEmail = userEmailIdTextField.text;
//        let userPassword = registerPasswordTextField.text;
//        let userRepeatPassword = repeatPasswordTextField.text;
//        let userCollege = userCollegeTextField.text;
//        let userYear = userYearTextField.text;
        
        
        //Firebase authantication handle
//        Auth.auth().createUser(withEmail: userEmail!, password: userPassword!, completion: {(user: User?, error) in
//            
//            if error != nil{
//            
//                print(error)
//                return
//            }
//            
//            //successfully login
//            let ref = Database.database().reference(fromURL: "https://technex-ios.firebaseio.com/")
//            let values = ["name":userName, "email":userEmail]
//            ref.updateChildValues(values)
        
            
        
        //});
        
        //Local data storage method
        //check for empty fields
        
//        if ((userName?.isEmpty)! || (userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)! || (userCollege?.isEmpty)! || (userYear?.isEmpty)!)
//        {
//            //Dispaly altert message
//            displayMyAlertMessage(userMessage: "All fields are required!");
//            return;
//        }
//        
//        //check if user enter correct year
//        if (Int(userYear!)! > 5){
//            displayMyAlertMessage(userMessage: "Enter correct year!");
//            return;
//        }
//        
//        //check if password match
//        if (userPassword != userRepeatPassword)
//        {
//            //display an alert message
//            displayMyAlertMessage(userMessage: "Password do not match");
//            return;
//        }
//        
//        //store data
//        UserDefaults.standard.set(userEmail, forKey:"userEmail");
//        UserDefaults.standard.set(userPassword, forKey:"userPassword");
//        UserDefaults.standard.set(userName, forKey:"userName");
//        UserDefaults.standard.synchronize();
//        
//        //Display alert message with confirmation
//        let myAlert = UIAlertController(title: "Alert", message: "Registration is successfull. Thank You!", preferredStyle: UIAlertControllerStyle.alert);
//        
//        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ action in
//            self.dismiss(animated: true, completion: nil);
//        }
//        
//        myAlert.addAction(okAction);
//        self.present(myAlert, animated: true, completion: nil);
        
    }
    
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

    
    @IBAction func alreadyRegisteredButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil);
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
    //function to change radians to degrees
    func radians(_ degrees : Double) -> CGFloat{
        return CGFloat(degrees * .pi / degrees)
    }
    
}
