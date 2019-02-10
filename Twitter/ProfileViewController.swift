//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Max Cohen on 2/10/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        let myUrl = "https://api.twitter.com/1.1/account/verify_credentials.json"
        
        var profile = NSDictionary()
        
        TwitterAPICaller.client?.getDictionaryRequest(url: myUrl, parameters: ["count": 1], success: { (profile) in
            self.userLabel.text = profile["name"] as? String
            let screenName = profile["screen_name"] as? String
            self.taglineLabel.text = "@" + screenName!
            
            self.followersCountLabel.text = "\(profile["followers_count"] as! Int)"
            
            self.tweetCountLabel.text = "\(profile["statuses_count"] as! Int)"
            
            self.followingCountLabel.text = "\(profile["friends_count"] as! Int)"
            
            self.likeCountLabel.text = "\(profile["favourites_count"] as! Int)"
            
            self.retweetCountLabel.text = "\(profile["listed_count"] as! Int)"
            
        
            
            self.profileImageView.layer.borderWidth = 1
            self.profileImageView.layer.masksToBounds = false
            self.profileImageView.layer.borderColor = UIColor.white.cgColor
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
            self.profileImageView.clipsToBounds = true
            
            let imageUrl = URL(string: (profile["profile_image_url_https"] as? String)!)
            let data = try? Data(contentsOf: imageUrl!)
            
            if let imageData = data {
                self.profileImageView.image = UIImage(data: imageData)
                
            }
           // print(profile["profile_banner_url"])
            
            let imageBackdropUrl = URL(string: (profile["profile_banner_url"] as? String)!)
            let backdropData = try? Data(contentsOf: imageBackdropUrl!)
            
            if let imageBackdropData = backdropData {
                self.backdropImageView.image = UIImage(data: imageBackdropData)
                
            }
            
        }, failure: { (error) in
            print("Could not retrieve profile information")
        })
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
