//
//  ViewController.swift
//  hackathon-project
//
//  Created by Kohei Totani on 2016/05/03.
//  Copyright © 2016年 Kohei Totani. All rights reserved.
//

import UIKit
import AssetsLibrary

class MainViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "いちなび"
    }
    
    @IBAction func postAction(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let ImagePicker = UIImagePickerController()
            ImagePicker.delegate = self
            ImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(ImagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let pickedImage:UIImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        let fileManager = NSFileManager.defaultManager()
        // TODO: 一旦ローカル書き込みで回避
        let filePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String + "/pickedimage.jpg"
        let imageData = UIImageJPEGRepresentation(pickedImage, 1.0)
        fileManager.createFileAtPath(filePath, contents: imageData, attributes: nil)
        
        if (fileManager.fileExistsAtPath(filePath)){
            let imageNSURL:NSURL = NSURL.init(fileURLWithPath: filePath)
            AlamofireManager().testAccess(imageNSURL);
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

