//
//  LoadImage.swift
//  Pet_Finder_v3
//
//  Created by Jordan Denning on 3/29/16.
//  Copyright © 2016 Jordan Denning. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    
    //had to change from NSCache()
    var cache = NSCache<NSString, UIImage>()
    
    class var sharedLoader: ImageLoader
    {
        struct Static
        {
            static let instance: ImageLoader = ImageLoader()
        }
        
        return Static.instance
    }
    
    func imageForUrl(_ urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async(execute: { () in
            
            let data: Data? = self.cache.object(forKey: urlString) as? Data
            
            if let theData = data
            {
                let image = UIImage(data: theData)
                
                DispatchQueue.main.async(execute: { () in
                    completionHandler(image, urlString)
                })
                
                return
            }
            
            let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL(string: urlString)!,
                completionHandler: {(data: Data?, response: URLResponse?, error: NSError?) -> Void in
                
                if (error != nil)
                {
                    completionHandler(nil, urlString)
                    return
                }
                
                if data != nil
                {
                    let image = UIImage(data: data!)
                    
                    self.cache.setObject(data!, forKey: urlString)
                    
                    DispatchQueue.main.async(execute: { () in
                        completionHandler(image, urlString)
                    })
                    
                    return
                }
                
            } as! (Data?, URLResponse?, Error?) -> Void)
            
            downloadTask.resume()
        })
    }
}
