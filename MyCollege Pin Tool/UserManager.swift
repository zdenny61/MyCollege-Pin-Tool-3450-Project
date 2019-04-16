//
//  UserManager.swift
//  MyCollege Pin Tool
//
//  Created by Apple Developer on 3/29/19.
//  Copyright © 2019 Denny Homes. All rights reserved.
//

import Foundation


class UserManager {
    
    static let shared = UserManager()
    
    var CurrentUser = UserStruct(User_ID: "", Username: "", Password: "", User_Email: "", First_Name: "", Last_Name: "", University_Name: "", University_ID: "")
    
    //resets the current user as a logout
    func Logout() {
        
        //set user defaults to emply for logout
        UserDefaults.standard.set(nil, forKey: Keys().SAVED_USERNAME)
        UserDefaults.standard.set(nil, forKey: Keys().SAVED_PASSWORD)
        UserDefaults.standard.set(nil, forKey: Keys().SAVED_UNIVERSITY_ID)
        UserDefaults.standard.set(nil, forKey: Keys().SAVED_EMAIL)
        UserDefaults.standard.set(nil, forKey: Keys().SAVED_LAST_NAME)
        UserDefaults.standard.set(nil, forKey: Keys().SAVED_FIRST_NAME)
        UserDefaults.standard.set(nil, forKey: Keys().SAVED_UNIVERSITY_NAME)
        UserDefaults.standard.set(nil, forKey: Keys().SAVED_USER_ID)
        
        
        //set usermanager back to empty
        UserManager.shared.CurrentUser = UserStruct(User_ID: "", Username: "", Password: "", User_Email: "", First_Name: "", Last_Name: "", University_Name: "", University_ID: "")
        
    }
    
    func LoadSavedUser(){
        
        //load usermanagers current user data from userdefaults
        UserManager.shared.CurrentUser = UserStruct(User_ID: UserDefaults.standard.string(forKey: Keys().SAVED_USER_ID)!, Username: UserDefaults.standard.string(forKey: Keys().SAVED_USERNAME)!, Password: UserDefaults.standard.string(forKey: Keys().SAVED_PASSWORD)!, User_Email: UserDefaults.standard.string(forKey: Keys().SAVED_EMAIL)!, First_Name: UserDefaults.standard.string(forKey: Keys().SAVED_FIRST_NAME)!, Last_Name: UserDefaults.standard.string(forKey: Keys().SAVED_LAST_NAME)!, University_Name: UserDefaults.standard.string(forKey: Keys().SAVED_UNIVERSITY_NAME)!, University_ID: UserDefaults.standard.string(forKey: Keys().SAVED_UNIVERSITY_ID)!)
        
        
    }
    
    
    
    
    
    
    
    
}
