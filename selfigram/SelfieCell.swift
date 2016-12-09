//
//  SelfieCell.swift
//  selfigram
//
//  Created by Andrew Milliken on 2016-12-01.
//  Copyright © 2016 Andrew Milliken. All rights reserved.
//

import UIKit
import Parse

class SelfieCell: UITableViewCell {

    @IBOutlet weak var selfieImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    var post:Post? {
        didSet{
           
            if let post = post {
                
                selfieImageView.image = nil
                
                let imageFile = post.image
                imageFile.getDataInBackground(block: {(data, error) -> Void in
                    if let data = data {
                        let image = UIImage(data: data)
                        self.selfieImageView.image = image
                    }
                })
                
                usernameLabel.text = post.user.username
                commentLabel.text = post.comment
                
                likeButton.isSelected = false
                
                let query = post.likes.query()
                query.findObjectsInBackground(block: { (users, error) -> Void in
                    
                    if let users = users as? [PFUser] {
                        for user in users {
                            if user.objectId != PFUser.current()?.objectId { continue }
                            
                            self.likeButton.isSelected = true

                        }
                    }
                })
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if let post = post,
            let user = PFUser.current() {
            
            if sender.isSelected {
                post.likes.add(user)
                
                post.saveInBackground(block: { (success, error) -> Void in
                    if success {
                        print("like from user successfully saved")
                        
                    }
                })
                
            }else{
                post.likes.remove(user)
                post.saveInBackground(block: { (success, error) -> Void in
                    if success {
                        print("like from user successfully removed")
                        
                    }else{
                        print("error is \(error)")
                    }
                    
                })
            }
            
 
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
