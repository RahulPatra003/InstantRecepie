//
//  RecepieViewModle.swift
//  InstantRecepie
//
//  Created by MAC on 17/06/20.
//  Copyright © 2020 Techangouts. All rights reserved.
//

import Foundation

class RecepieViewModle: BaseAPI {
    
    private var recepieModleData : RecepieModle?
    private var recepieStoredModleData : RecepieModle?
    
    var page: Int = 1
    var isSearching: Bool = false
    var isLast: Bool = false
    
    
    var dataRecepie: RecepieModle? {
        get {
            return recepieModleData
        }
    }
    
    func searchRecepie(withText text: String) {
        self.recepieModleData = self.recepieStoredModleData
        self.recepieModleData?.results = (self.recepieModleData?.results ?? []) ??= text
    }
    
    func hitRecepieApi(withIngrediants ingrediants: String, andPageNo page : Int, completion: @escaping FinalSuccess) {
        
        let request = Request(url: (.BASE_URL, .recepie(ingrediants, "", page)), method: .get, headers: false)
        
        hitApi(requests: request) { (responseJson, error, responseCode) in
            
            if responseCode == 1 {
                
                do{
                    if (((responseJson as? [String:Any])?["results"] as? [[String:Any]])?.count ?? 0) != 0 {
                        let serialized = try JSONSerialization.data(withJSONObject: responseJson as! [String:Any], options: .prettyPrinted)
                        
                        let decoded = try JSONDecoder().decode(RecepieModle.self, from: serialized)
                        
                        if self.recepieModleData != nil {
                            self.recepieModleData?.results += decoded.results
                        } else {
                            self.recepieModleData = decoded
                        }
                        self.isLast = false
                        completion(true, "Success")
                    } else {
                        self.isLast = true
                        completion(true, "Success")
                    }
                    
                }catch{
                    completion(false, error.localizedDescription)
                }
                
            }else{
                completion(false, "Failed")
            }
        }
    }
}


protocol Searchable {
    var searchableText: String { get }
}

infix operator ??=

func ??=<S: Searchable>(lhs: [S] , rhs: String) -> [S] {
    return lhs.filter({$0.searchableText.lowercased().replacingOccurrences(of: " ", with: "").contains(rhs.lowercased().replacingOccurrences(of: " ", with: ""))})
}
