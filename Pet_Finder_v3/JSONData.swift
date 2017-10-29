//
//  JSONData.swift
//  Pet_Finder_v3
//
//  Created by Jordan Denning on 4/21/16.
//  Copyright © 2016 Jordan Denning. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class JSONData: NSObject {
    
    let petFinderCallRandom: String = "https://api.petfinder.com/pet.getRandom?key=c4945bb7a8711167396fd27927fdf857&output=basic&format=json"
    
    override init() {
        super.init()
    }
    
    func getData(_ completion: (JSON?) -> ()) {
        
        Alamofire.request(.GET, petFinderCallRandom)
            .responseJSON { response in
                
                
                guard response.result.isSuccess else
                {
                    print("Error: \(response.result.isSuccess)")
                    completion(nil)
                    return
                }
                
                let jsonData = response.data
                
                let json = JSON(data: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
                
                completion(json)
        }
    }
}
