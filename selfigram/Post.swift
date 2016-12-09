//
//  Post.swift
//  selfigram
//
//  Created by Andrew Milliken on 2016-11-22.
//  Copyright © 2016 Andrew Milliken. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    
    @NSManaged var image:PFFile
    @NSManaged var user:PFUser
    @NSManaged var comment:String
    
    static func parseClassName() -> String {
        
        return "Post"
    }
    
    var likes: PFRelation<PFObject>! {
        return relation(forKey: "likes")
    }
    
//    let imageURL:URL
//    let user:User
//    let comment:String
    
    convenience init(image:PFFile, user:PFUser, comment:String){
        // You can name the property you are passing into the function the
        // same name as the class' property. To distinguish the two
        // add "self." to the beginning of the class' property.
        // So for example we are passing in an UImage called image and setting it as our
        // image property for Post.
        self.init()
        self.image = image
        self.user = user
        self.comment = comment
    }
    
}
