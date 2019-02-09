//
//  TweetViewController.swift
//  Twitter
//
//  Created by Max Cohen on 2/4/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
       characterCountLabel.text = "140"
        tweetTextView.delegate = self
    
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
       // characterCountLabel.text = "\(tweetTextView.text.characters.count)"
        if (!tweetTextView.text.isEmpty){
            if(tweetTextView.text.characters.count < 140){
                TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                    self.dismiss(animated: true, completion: nil)
                }, failure: { (error) in
                    print("Error posting tweet \(error)")
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
         characterCountLabel.text = "\(characterLimit - tweetTextView.text.characters.count)"
        
        // TODO: Update Character Count Label
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
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
