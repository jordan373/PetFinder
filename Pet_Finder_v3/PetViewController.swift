//
//  ViewController.swift
//  Pet_Finder_v3
//
//  Created by Jordan Denning on 3/28/16.
//  Copyright © 2016 Jordan Denning. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import BTNavigationDropdownMenu

class PetViewController: UIViewController {
    
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet var petView: UIView!
    @IBOutlet weak var refreshPetButton: UIButton!
    @IBOutlet weak var petInfoButton: UIButton!
    @IBOutlet weak var petLikeButton: UIButton!
    @IBOutlet weak var dropdownMenuButton: UIButton!
    
    var name = ""
    var imageURL = ""
    var id = ""
    var jsonData: [String:JSON] = [:]
    
    let api = JSONData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callData()
        
        self.petImage.layer.cornerRadius = 15.0;
        self.petImage.clipsToBounds = true;
        self.petImage.layer.borderWidth = 3.0;
        self.petImage.layer.borderColor = UIColor.gray.cgColor
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dropdownMenuButton(_ sender: AnyObject)
    {
        let items = ["Search", "Favorites"]
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items.first!, items: items)
        self.navigationItem.titleView = menuView
        
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            
            print("Did select item at index \(indexPath)")
            self.selectedCellLabel.text = items[indexPath]
            
            menuView.show()
        }
    }
    
    func callData()
    {
        api.getData() { json in
            
            self.jsonData = json!["petfinder"]["pet"].dictionary!
            
            self.getRandomPetInfo()
            
            return
        }
    }
    
    @IBAction func refreshPet(_ sender: AnyObject)
    {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveLinear], animations: {
            
            self.petImage.center.x += self.view.bounds.width
            self.petNameLabel.center.x += self.view.bounds.width
            
        }, completion: nil)
        
        callData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "petInfoSegue"
        {
            let vc: PetInfoViewController? = segue.destination as? PetInfoViewController
            vc!.jsonData = jsonData
            vc!.name = name
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue)
    {
        
    }
    
    func getRandomPetInfo()
    {
        let petInfo = jsonData
        
        id = petInfo["id"]!["$t"].stringValue
        name = petInfo["name"]!["$t"].stringValue
        
        guard let media = petInfo["media"]!["photos"].dictionary else
        {
            return
        }
        let photo = media["photo"]!.array
        let selectedImage = photo![2].dictionary
        imageURL = selectedImage!["$t"]!.stringValue
        
        DispatchQueue.main.async
        {
            self.petNameLabel.text = self.name
            
            ImageLoader.sharedLoader.imageForUrl(self.imageURL,
                completionHandler:{(image: UIImage?, url: String) in
                                                    
                    self.petImage.image = image!
            })
            
            UIView.animate(withDuration: 0.2, delay: 0.5, options: [.curveEaseOut], animations: {
                
                self.petImage.center.x += self.view.bounds.width
                self.petNameLabel.center.x += self.view.bounds.width
                
            }, completion: nil)
        }
    }
}
