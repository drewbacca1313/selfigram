//
//  ProfileViewController.swift
//  selfigram
//
//  Created by Andrew Milliken on 2016-11-17.
//  Copyright © 2016 Andrew Milliken. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func cameraButtonPressed(_ sender: AnyObject) {
        print("Camera Button Pressed")
        
            let pickerController = UIImagePickerController()
            
              pickerController.delegate = self
            
            if TARGET_OS_SIMULATOR == 1 {
                
                pickerController.sourceType = .photoLibrary
            } else {
                // 4. We check if we are running on an iPhone or iPad (ie: not a simulator)
                //    If so, we open up the pickerController's Camera (Front Camera, for selfies!)
                pickerController.sourceType = .camera
                pickerController.cameraDevice = .front
                pickerController.cameraCaptureMode = .photo
            }
            
            // Preset the pickerController on screen
            self.present(pickerController, animated: true, completion: nil)
            
        }
    
    @IBOutlet weak var profileViewImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        usernameLabel.text = "yourName"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = PFUser.current() {
            usernameLabel.text = user.username
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 1. When the delegate method is returned, it passes along a dictionary called info.
        //    This dictionary contains multiple things that may be useful to us.
        //    We are getting the image from the UIImagePickerControllerOriginalImage key in that dictionary
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // setting the compression quality to 90%
            if let imageData = UIImageJPEGRepresentation(image, 0.9),
                let imageFile = PFFile(data: imageData),
                let user = PFUser.current(){
                
                // avatarImage is a new column in our User table
                user["avatarImage"] = imageFile
                user.saveInBackground(block: { (success, error) -> Void in
                    if success {
                        // set our profileImageView to be the image we have picked
                        let image = UIImage(data: imageData)
                        self.profileViewImage.image = image
                    }
                })
                
            }
            
            
        }
        
        //3. We remember to dismiss the Image Picker from our screen.
        dismiss(animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
