//
//  Links.swift
//  Optipest
//
//  Created by IOS on 28/02/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

enum URLS {
    
    case BASE_URL
   
    var getDescription: String {
        get {
            switch self {
                
            case .BASE_URL:
                return "http://www.recipepuppy.com/api/?"
                
            
            }
        }
    }
}

enum APISuffix {
    
    case recepie(String, String, Int)
    
    
    var getDescription: String {
       
        get {
            switch self {
                
            case .recepie(let i, let q, let p):
            
                return "i=\(i ?? "")&q=\(q ?? "")&p=\(p ?? 1)"
           
            }
        }
    }
}
