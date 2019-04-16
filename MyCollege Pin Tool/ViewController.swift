//
//  ViewController.swift
//  MyCollege Pin Tool
//
//  Created by Apple Developer on 3/15/19.
//  Copyright © 2019 Denny Homes. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var lblLatCord: UILabel!
    @IBOutlet weak var lblLongCord: UILabel!
    @IBOutlet weak var txtNameBox: UITextField!
    @IBOutlet weak var txtPinDiscription: UITextView!
    
    @IBOutlet weak var uploadSpinner: UIActivityIndicatorView!
    
    @IBOutlet weak var btnAddPin: UIButton!
    
    //Used for managing location
    let locationManager = CLLocationManager()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        uploadSpinner.isHidden = true
        txtNameBox.delegate = self as UITextFieldDelegate
        //txtPinDiscription.delegate = (self as UITextFieldDelegate as! UITextViewDelegate)
        
        //check if there are saved pins, if not set default text and save
        if (UserDefaults.standard.string(forKey: Keys().SAVED_SESSION_NAME) == nil || UserDefaults.standard.string(forKey: Keys().SAVED_SESSION_NAME) == ""){
            //do nothing
           
        }else{
           //retrived saved session values and set back to nil
            txtNameBox.text = UserDefaults.standard.string(forKey: Keys().SAVED_SESSION_NAME)
            txtPinDiscription.text = UserDefaults.standard.string(forKey: Keys().SAVED_SESSION_DESCRIPTION)
            
            //restore to nil
            UserDefaults.standard.set(nil, forKey: Keys().SAVED_SESSION_NAME)
            UserDefaults.standard.set(nil, forKey: Keys().SAVED_SESSION_DESCRIPTION)
        }
       
        
        
        
        //enable location and authorize
        enableLocationServices();
        
        
    
        
    
    }
    
    // Called on 'Return' pressed. Return false to ignore.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //Check and enable location services
    func enableLocationServices() {
        locationManager.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
            
            
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
            
        }
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
    
    //Method updates coord. when location chamges
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        //update the labels with the current long and lat
        lblLatCord.text = locValue.latitude.description
        lblLongCord.text = locValue.longitude.description
        
    }
    
    
    
    
    //button click to add pin
    @IBAction func addPin(_ sender: Any) {
        
        
        //check that all user inputs have been filled out
        if(txtNameBox.text != "" && txtPinDiscription.text != ""){
            //user has filled out all inputs
            
            
            //check if pictures were selected or not
            if(PictureManager.shared.currentSet.Picture_Spring != "" && PictureManager.shared.currentSet.Picture_Summer != "" && PictureManager.shared.currentSet.Picture_Winter != ""  ){
                //pictures have been selected
                
                //check to make sure locaition is enabled and if not redirect them to settings
                if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
                    //location is enabled
                    
                    //submit pin now since everything has been checked
                    
                    
                    //check to make sure input values fit expected formates and send to database manager
                    if let name = txtNameBox.text, let description = txtPinDiscription.text, let lat = Double(lblLatCord.text!), let long = Double(lblLongCord.text!){
                        
                        let universityid = UserDefaults.standard.integer(forKey: Keys().SAVED_UNIVERSITY_ID)
                        
                        //send all data to database manager
                        DatabaseManager.shared.SendPinData(passedPinName: name, passedPinDescriotion: description, passedUniversityID: universityid, passedPinLong:  long, passedPinLat: lat, passedPictureSet: PictureManager.shared.currentSet )
                        
                        
                    }
                    
                    
                    //make spinner visible and start spinning
                    self.uploadSpinner.isHidden = false
                    self.uploadSpinner.startAnimating()
                    
                    //make button disabled
                    self.btnAddPin.isEnabled = false
                    
                    //used ot dispatch the spinner on the screen until everything for the pin has been uploaded.
                    DispatchQueue.global(qos: .background).async {
                        
                        
                        //wait until all 3 photos are uploaded
                        while(PictureManager.shared.numOfUpload != 3){}
                        
                        
                        //everything has uploaded so display message
                        self.allDataUploaded()
                        
                    }
                        
                    
                    
                    
                    
                    
//                    //send user confirmation alert
//                    displayAlertMessage(passedMessage: "Your pin has been submited for \(UserManager.shared.CurrentUser.University_Name) successfully! Thank you!", passedTitle: "Submitted")
//
//                    //clear all
//                    clearAll()
                    
                }else{
                    requestLocationAuth()
                }
                
                
                
                
                
                
                
            }else{
                displayAlertMessage(passedMessage: "You must select pictures for your location first. Select the button (Select Pictures) and input your pictures first.", passedTitle: "You forgot something!")
            }
            
            
            
        }else{
            displayAlertMessage(passedMessage: "It looks like you forgot to enter in values for one or more textboxs. Please fill in all inputs and try again.", passedTitle: "You forgot something!")
        }
        
        
        
        
        
        
        
        
        
    }
    
    //called when everything has been uploaded to show user and clear
    func allDataUploaded(){
        
        
        DispatchQueue.main.async {
           
            //stop spinner and hide it
            self.uploadSpinner.stopAnimating()
            self.uploadSpinner.isHidden = true
            
            //set button to enabled again
            self.btnAddPin.isEnabled = true
            
        }
        
        
        //reset image number
        PictureManager.shared.numOfUpload = 0
        
        //send user confirmation alert
        displayAlertMessage(passedMessage: "Your pin has been submited for \(UserManager.shared.CurrentUser.University_Name) successfully! Thank you!", passedTitle: "Submitted")
        
        //clear all
        clearAll()
        
        
    }
    
   
    
    
    
    @IBAction func btnLogout_Click(_ sender: Any) {
        
        //logout user
        UserManager.shared.Logout()
        
        //stop location updating
        locationManager.stopUpdatingLocation()
    }
    
    
    
    //used for displaying a message to the user with a ok button
    func displayAlertMessage(passedMessage: String, passedTitle: String){
        
        //display the message to user
        let alert = UIAlertController(title: passedTitle, message: passedMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    //used when user does not have location authenticated and they must do it before performing next actions
    func requestLocationAuth(){
        //display message requesting user enables location and redirect them to settings
        let alert = UIAlertController(title: "Location Required!", message: "This admin tool uses and requires location to be enabled for this application to submite pins. You must first go to the apps settings under your phones settings and enable (While Using) under the location setting. Then you can try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        alert.addAction(UIAlertAction(title: "Goto Settings", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                //goto parent application IOS app settings
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    //btn select pictures was tapped so save the current sesstion
    @IBAction func selectPicture_Tapped(_ sender: Any) {
        
        //set session values to text fields
        UserDefaults.standard.set(txtNameBox.text, forKey: Keys().SAVED_SESSION_NAME)
        UserDefaults.standard.set(txtPinDiscription.text, forKey: Keys().SAVED_SESSION_DESCRIPTION)
    }
    
    func clearAll(){
        
        //clear pictures
        PictureManager.shared.clear()
        
        //clear current sesstion
        UserDefaults.standard.set(nil, forKey: Keys().SAVED_SESSION_NAME)
        UserDefaults.standard.set(nil, forKey: Keys().SAVED_SESSION_DESCRIPTION)
        
    }
    
    
    


}

