//
//  ContextUtils.swift
//  memamorukun
//
//  Created by Kohei Totani on 2016/02/16.
//  Copyright © 2016年 Kohei Totani. All rights reserved.
//

import Foundation

struct Context{
    static func className(selfClass: AnyClass) -> String {
        let className = NSStringFromClass(selfClass)
        let range = className.rangeOfString(".")
        return className.substringFromIndex(range!.endIndex)
    }
}
