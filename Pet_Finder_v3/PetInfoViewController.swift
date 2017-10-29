//
//  PetInfoViewController.swift
//  Pet_Finder_v3
//
//  Created by Jordan Denning on 3/29/16.
//  Copyright © 2016 Jordan Denning. All rights reserved.
//

import UIKit
import SwiftyJSON

class PetInfoViewController: UIViewController {
    
    var jsonData: [String:JSON] = [:]
    var name = ""
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petTypeLabel: UILabel!
    @IBOutlet weak var petBreedLabel: UILabel!
    @IBOutlet weak var petSexLabel: UILabel!
    @IBOutlet weak var petAgeLabel: UILabel!
    @IBOutlet weak var petAddressLabel: UILabel!
    @IBOutlet weak var petCityLabel: UILabel!
    @IBOutlet weak var petStateLabel: UILabel!
    @IBOutlet weak var petPhoneLabel: UILabel!
    @IBOutlet weak var petEmailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPetInfo()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "aboutPetSegue"
        {
            let vc: AboutPetViewController? = segue.destination as? AboutPetViewController
            vc!.data = jsonData
            vc!.name = name
        }
        
    }
    
    @IBAction func unwindSegue2(_ sender: UIStoryboardSegue)
    {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getPetInfo()
    {
        // Type
        let petType = jsonData["animal"]!["$t"].stringValue ?? "Not available"
        print(petType)
        
//        Breed
//        let getBreeds = petInfo["breeds"] as! NSDictionary
//        let getBreed = getBreeds["breed"] as! NSDictionary
//        let breed = getBreed["$t"] as? String ?? "Not available"
//        print(breed)
        
        // Sex
        let sex = jsonData["sex"]!["$t"].stringValue ?? "Not available"
        print(sex)
        
        // Age
        let age = jsonData["age"]!["$t"].stringValue ?? "Not available"
        print(age)
        
        // Contact info
        let contact = jsonData["contact"]!.dictionary
        
        // City
        let city = contact!["city"]!["$t"].stringValue ?? "Not available"
        print(city)
        
        // State
        let state = contact!["state"]!["$t"].stringValue ?? "Not available"
        print(state)
        
        // Phone
        let phone = contact!["phone"]!["$t"].stringValue ?? "Not available"
        print(phone)
        
        // Email
        let email = contact!["email"]!["$t"].stringValue ?? "Not available"
        print(email)

        petNameLabel.text = "About \(name):"
        petTypeLabel.text = "Animal: \(petType)"
//      petBreedLabel.text = "Breed: \(breed)"
        petSexLabel.text = "Sex: \(sex)"
        petAgeLabel.text = "Age: \(age)"
        petCityLabel.text = "City: \(city)" ?? ""
        petStateLabel.text = "State: \(state)" ?? ""
        petPhoneLabel.text = "Phone: \(phone)" ?? ""
        petEmailLabel.text = "Email: \(email)" ?? ""
    }
}
