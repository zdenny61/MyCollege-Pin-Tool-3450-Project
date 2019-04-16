//
//  LoginViewController.swift
//  MyCollege Pin Tool
//
//  Created by Apple Developer on 3/29/19.
//  Copyright © 2019 Denny Homes. All rights reserved.
//

import UIKit
import Foundation



class LoginViewController: UIViewController{
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check if user has saved login and then request login or go to pin tool
        
        if (UserDefaults.standard.string(forKey: Keys().SAVED_USERNAME) != nil){
            
            //load the saved user data from userdefault into our user class
            UserManager.shared.LoadSavedUser()
            
            //go to other pin tool
            //perform suge
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: ViewIdentifier().PIN_MAIN, sender: self)
            }
            
            
            
            
        }
        
        
        
        
        
        
        let boarderColor = UIColor.white
        
        //set up textboxs/login button looks
        txtUsername.layer.cornerRadius = 15.0
        txtUsername.layer.borderWidth = 0.9
        txtUsername.layer.borderColor = boarderColor.cgColor
        txtUsername.attributedPlaceholder = NSAttributedString(string: "Username",attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
        
        txtPassword.layer.cornerRadius = 15.0
        txtPassword.layer.borderWidth = 0.9
        txtPassword.layer.borderColor = boarderColor.cgColor
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password",attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        
        btnLogin.layer.cornerRadius = 15.0
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    
    
    
    @IBAction func btnLogin_Click(_ sender: Any) {
        
        //check if they both textboxs have text in them and that the text is not blank
        if(txtUsername.text != nil && txtPassword.text != nil && txtUsername.text != "" && txtPassword.text != ""){
           
            //check users crid and maybe to lowercase and uppercase check for username?
            UserFeedModel.shared.downloadItems(passedUsername: txtUsername.text!, passedPassword: txtPassword.text!)
            
            
            
//            DispatchQueue.main.async {
//                performSegue(withIdentifier: ViewIdentifier().PIN_MAIN, sender: sender)
//            }
            //check for login before going to pin tool
            if (UserManager.shared.CurrentUser.Username != ""){
                
                //Save password and username to user defaults when they are logged in
                UserDefaults.standard.set(UserManager.shared.CurrentUser.Username, forKey: Keys().SAVED_USERNAME)
                UserDefaults.standard.set(UserManager.shared.CurrentUser.Password, forKey: Keys().SAVED_PASSWORD)
                UserDefaults.standard.set(UserManager.shared.CurrentUser.University_ID, forKey: Keys().SAVED_UNIVERSITY_ID)
                UserDefaults.standard.set(UserManager.shared.CurrentUser.User_Email, forKey: Keys().SAVED_EMAIL)
                UserDefaults.standard.set(UserManager.shared.CurrentUser.Last_Name, forKey: Keys().SAVED_LAST_NAME)
                UserDefaults.standard.set(UserManager.shared.CurrentUser.First_Name, forKey: Keys().SAVED_FIRST_NAME)
                UserDefaults.standard.set(UserManager.shared.CurrentUser.University_Name, forKey: Keys().SAVED_UNIVERSITY_NAME)
                UserDefaults.standard.set(UserManager.shared.CurrentUser.User_ID, forKey: Keys().SAVED_USER_ID)
                
                print("Logged In!")
                
                //Go to pin tool
                performSegue(withIdentifier: ViewIdentifier().PIN_MAIN, sender: self)
                
                
                
            }
            
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
}
