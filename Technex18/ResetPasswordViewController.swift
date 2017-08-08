//
//  ResetPasswordViewController.swift
//  Technex18
//
//  Created by JOGENDRA on 31/03/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var resetEmailTextField: DesignableTextField!
    
    @IBOutlet weak var resetButton: DesignableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
        let userEmail = resetEmailTextField.text
        
        if(userEmail?.isEmpty)!{
            displayMyAlertMessage(userMessage: "Please enter email !");
            
        }else{
        Auth.auth().sendPasswordReset(withEmail: userEmail!, completion: { error in
            
            if error != nil{
            
                print(error)
            }
            else{
            
                self.displayMyAlertMessage(userMessage: "Password reset link has been sent to you.")
            }
        
        })
    }
    }

    @IBAction func cancleButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

}
