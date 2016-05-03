//
//  Alamofire.swift
//  hackathon-project
//
//  Created by Kohei Totani on 2016/05/03.
//  Copyright © 2016年 Kohei Totani. All rights reserved.
//

import Alamofire

protocol AlamofireDelegate {
    func request(json: AnyObject)
}


class AlamofireManager {

    var delegate: AlamofireDelegate? = nil

    init(delegate: AlamofireDelegate?) {
        self.delegate = delegate
    }
    
    func getPictures() {
        Alamofire.request(.GET, Const.URL)
            .responseJSON { response in

                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    self.delegate?.request(JSON)
                }
        }
    }

    
    func postPicture(url: NSURL,latitude: String, longitude: String) {
        Alamofire.upload(.POST, Const.URL, multipartFormData: { (multipartFormData) in
                multipartFormData.appendBodyPart(fileURL: url, name: "uploadFile")
            
                if let data = latitude.dataUsingEncoding(NSUTF8StringEncoding) {
                    multipartFormData.appendBodyPart(data: data, name: "latitude")
                }
                if let data = longitude.dataUsingEncoding(NSUTF8StringEncoding) {
                    multipartFormData.appendBodyPart(data: data, name: "longitude")
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
