//
//  Alamofire.swift
//  hackathon-project
//
//  Created by Kohei Totani on 2016/05/03.
//  Copyright © 2016年 Kohei Totani. All rights reserved.
//

import Alamofire

class AlamofireManager {

    func testAccess(url: NSURL) {
        Alamofire.upload(.POST, Const.URL, multipartFormData: { (multipartFormData) in
                multipartFormData.appendBodyPart(fileURL: url, name: "uploadFile")
            
                // TODO: 位置情報の整理 & サンプルパラメーター
                if let data = "hoge".dataUsingEncoding(NSUTF8StringEncoding) {
                    multipartFormData.appendBodyPart(data: data, name: "stringVal")
                }
                if let data = String(10).dataUsingEncoding(NSUTF8StringEncoding) {
                    multipartFormData.appendBodyPart(data: data, name: "intVal")
                }
            },
            encodingCompletion: { (encodingResult) in
                switch encodingResult {
                case .Success(let upload, _, _):
                    break

                case .Failure(let encodingError):
                    break
                    
                }
        })
    }
}
