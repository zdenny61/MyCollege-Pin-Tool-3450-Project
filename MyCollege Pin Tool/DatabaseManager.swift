//
//  SendToDB.swift
//  MyCollege Pin Tool
//
//  Created by Apple Developer on 4/1/19.
//  Copyright © 2019 Denny Homes. All rights reserved.
//

import Foundation

class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    //used to add each pin data to db in order
    func SendPinData(passedPinName: String, passedPinDescriotion: String, passedUniversityID: Int, passedPinLong: Double, passedPinLat: Double, passedPictureSet: PictureSet){
        
        //Add Pin_Picture data
        AddPictures(passedSpringKey: passedPictureSet.Picture_Spring, passedWinterKey: passedPictureSet.Picture_Winter, passedSummerKey: passedPictureSet.Picture_Summer)
        print("Pin_Picture Uploaded")
        
        //Add Pin_Info
        AddPinInfo(Name: passedPinName, Description: passedPinDescriotion)
        print("Pin_Info Uploaded")
        
        
        //Add Pin
        AddPin(University_ID: passedUniversityID, Pin_Long: passedPinLong, Pin_Lat: passedPinLat)
        print("Pin Uploaded")
        
    }
    
    //used to add each picture to db
    func AddPictures(passedSpringKey: String, passedWinterKey: String, passedSummerKey: String){
        
        var urlString = ""
        var pictureType = ""
        
        
        
        //picture types:
        //1 = sprint
        //2 = winter
        //3 = summer
        
        //set picture type and then insert photos spring, winter, summer in that order!
        for i in 1...3 {
            
            //check what kind of picture it is and set the picturetype and url string
            switch(i){
            case 1:
                //insert spring
                pictureType = "1"
                urlString = "http://www.denny-homes-server.com/MyCollegeApp/Insert_Pin_Picture.php?Picture_Type=\(pictureType)&Picture_Path=%22\(passedSpringKey)%22"
                
                break;
            case 2:
                //insert winter
                pictureType = "2"
                urlString = "http://www.denny-homes-server.com/MyCollegeApp/Insert_Pin_Picture.php?Picture_Type=\(pictureType)&Picture_Path=%22\(passedWinterKey)%22"
                
                break;
                
            case 3:
                //insert summer
                pictureType = "3"
                urlString = "http://www.denny-homes-server.com/MyCollegeApp/Insert_Pin_Picture.php?Picture_Type=\(pictureType)&Picture_Path=%22\(passedSummerKey)%22"
                
                break;
                
            default:
                //insert other
                pictureType = "-1"
                urlString = "http://www.denny-homes-server.com/MyCollegeApp/Insert_Pin_Picture.php?Picture_Type=\(pictureType)&Picture_Path=%22\(passedSpringKey)%22"
                
                break
                
            }
            
            //insert the picture to DB
            if let url = URL(string: urlString) {
                
                
                
                let group = DispatchGroup()
                group.enter()
                
                
                let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                    //group.leave()
                    guard data != nil else { return }
                    //print(String(data: data, encoding: .utf8)!)
                    group.leave()
                }
                
                task.resume()
                group.wait()
                
            }
            
            
        }
        
        
        
        
    }
    
    //used to add pin info to db
    func AddPinInfo(Name: String, Description: String){
    //http://www.denny-homes-server.com/MyCollegeApp/Insert_Pin_Info.php?Name=%22namestring%22&Description=%22descstring%22
        
        let description = String(Description)
        let name = String(Name)
        var urlString = "http://www.denny-homes-server.com/MyCollegeApp/Insert_Pin_Info.php?Name=%22\(name)%22&Description=%22\(description)%22"
        
        //check for spaces and replace with %20 to prevent crash
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        urlString = urlString.replacingOccurrences(of: "\n", with: "%0A")
        
        if let url = URL(string: urlString) {
           
            
            
            let group = DispatchGroup()
            group.enter()
            
            
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                //group.leave()
                guard data != nil else { return }
                //print(String(data: data, encoding: .utf8)!)
                group.leave()
            }
            
            task.resume()
            group.wait()
            
        }
        
        
      
        
    }
        
        
        
    //used to add the final pin to db
    func AddPin(University_ID: Int, Pin_Long: Double, Pin_Lat:Double){
        //http://www.denny-homes-server.com/MyCollegeApp/Insert_Pin.php?University_ID=1&Pin_Long=199&Pin_Lat=199
        
        
        
        let url = URL(string: "http://www.denny-homes-server.com/MyCollegeApp/Insert_Pin.php?University_ID=\(University_ID)&Pin_Long=\(Pin_Long)&Pin_Lat=\(Pin_Lat)")!
        
        let group = DispatchGroup()
        group.enter()
        
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
             //group.leave()
            guard data != nil else { return }
            //print(String(data: data, encoding: .utf8)!)
            group.leave()
        }
        
        task.resume()
        group.wait()
        
    }
    
    
    
    
    
}

