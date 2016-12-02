//
//  ProfileViewController.swift
//  selfigram
//
//  Created by Andrew Milliken on 2016-11-17.
//  Copyright © 2016 Andrew Milliken. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func cameraButtonPressed(_ sender: AnyObject) {
        print("Camera Button Pressed")
        
            // 1: Create an ImagePickerController
            let pickerController = UIImagePickerController()
            
            // 2: Self in this line refers to this View Controller
            //    Setting the Delegate Property means you want to receive a message
            //    from pickerController when a specific event is triggered.
            pickerController.delegate = self
            
            if TARGET_OS_SIMULATOR == 1 {
                // 3. We check if we are running on a Simulator
                //    If so, we pick a photo from the simulator’s Photo Library
                // We need to do this because the simulator does not have a camera
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
     
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
           
            profileViewImage.image = image
            
        }
        
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
