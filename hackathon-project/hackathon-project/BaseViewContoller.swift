//
//  BaseViewContoller.swift
//  hackathon-project
//
//  Created by Kohei Totani on 2016/05/03.
//  Copyright © 2016年 Kohei Totani. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    override func loadView() {
        if let view = UINib(nibName: Context.className(self.classForCoder), bundle: nil).instantiateWithOwner(self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    override func viewDidLoad() {
        Log(Context.className(self.classForCoder))
    }
    
    override func viewWillAppear(animated: Bool)
        Log(Context.className(self.classForCoder))
    }
    
    override func viewWillDisappear(animated: Bool) {
        Log(Context.className(self.classForCoder))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
