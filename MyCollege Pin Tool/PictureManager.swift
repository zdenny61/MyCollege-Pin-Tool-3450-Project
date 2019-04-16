//
//  PictureSetClass.swift
//  MyCollege Pin Tool
//
//  Created by Apple Developer on 4/5/19.
//  Copyright © 2019 Denny Homes. All rights reserved.
//

import Foundation

class PictureManager{
    
    static let shared = PictureManager()
    
    var currentSet = PictureSet(Picture_Spring: "", Picture_Winter: "", Picture_Summer: "")
    var numOfUpload = 0
    
    
    
    //func to clear everything in manager
    func clear(){
        
        currentSet = PictureSet(Picture_Spring: "", Picture_Winter: "", Picture_Summer: "")
        
    }
    
}

public struct PictureSet{
    
    //all pictures refrence keys to firebase db
    var Picture_Spring: String
    var Picture_Winter: String
    var Picture_Summer: String
    
}


