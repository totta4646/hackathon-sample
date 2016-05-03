//
//  ViewController.swift
//  hackathon-project
//
//  Created by Kohei Totani on 2016/05/03.
//  Copyright © 2016年 Kohei Totani. All rights reserved.
//

import UIKit
import AssetsLibrary

class ViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        let button: UIButton = UIButton()
        button.frame = CGRectMake(100, 100, 100, 100)
        button.setTitle("Access!", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.blueColor()
        // TODO: メソッドの整理
        button.addTarget(self, action: Selector("accessCameraroll:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    
    
    
    func accessCameraroll(button: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        Log(info);
    }
}

