//
//  functions.swift
//  memamorukun
//
//  Created by Kohei Totani on 2016/02/16.
//  Copyright © 2016年 Kohei Totani. All rights reserved.
//

import Foundation

struct Const{
    #if DEBUG
    // staging環境
    static let HOST = "http://hogehoge:10000/"
    //    static let HOST = "http://localhost:3000/"
    #else
    
    static let HOST = "http://hogehoge/"
    #endif
    
    static let API_VERSION = "api/v1/"
    static let URL = HOST + API_VERSION
    
    
    // UserDefault
    static let UD_TOKEN = "user_default_device_token_key"
    
    static let UD_ADMIN_EMAIL = "user_default_admin_email_key"
    static let UD_ADMIN_PASSWORD = "user_default_admin_password_key"
    
    static let UD_EMAIL = "user_default_email_key"
    static let UD_PASSWORD = "user_default_password_key"
}

func Log(obj: AnyObject?,
         function: String = #function,
         line: Int = #line) {
    #if DEBUG
        print("[Function:\(function) Line:\(line)] : \(obj)")
    #endif
}
