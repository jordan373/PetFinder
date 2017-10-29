//
//  AboutPetViewController.swift
//  Pet_Finder_v3
//
//  Created by Jordan Denning on 3/29/16.
//  Copyright © 2016 Jordan Denning. All rights reserved.
//

import UIKit
import SwiftyJSON

class AboutPetViewController: UIViewController {
    
    var data: [String:JSON] = [:]
    var name = ""
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var petDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDescription()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDescription()
    {
        let description = data["description"]!["$t"].stringValue
        
        petDescription.text = description ?? "Not available"
        petDescription.isEditable = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
