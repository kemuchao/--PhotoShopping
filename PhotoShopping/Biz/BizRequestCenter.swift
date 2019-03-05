
//
//  BizRequestCenter.swift
//  sst-ios
//
//  Created by Liang Zhang on 16/4/12.
//  Copyright © 2016年 lzhang. All rights reserved.
//

import UIKit

open class BizRequestCenter : NSObject {
    
    let ntwkAccess = NetworkAccess()
   
    override init() {
        ntwkAccess.listen()
    }
    
    class var sharedInstance : BizRequestCenter {
        return biz
    }
    

    func uploadImage(image: String, dataType: Int,  callback: @escaping RequestCallBack) {
        
        let timeStamp = Date().timeStamp
        let dict:[String:Any] = [
            "content":image,
            "db_id": "101",
            "code": "101",
            "randomValue": timeStamp,
            "classid": 0
        ]
    
        printX("url = \(kBaseUploadImageURLString) param===\(dict)")
        ntwkAccess.uploadFile(url: kBaseUploadImageURLString, parameters: dict) { (data, error) in
            callback(data, error)
        }
    }
    
    func getProductList(products: String, callback: @escaping RequestCallBack) {
        let urlstr = "http://api4test.380star.com/friendshop/36/goods/recommendgoodslist.do?heleId=\(validString(products))"
//        let urlstr = "http://api4test.380star.com/friendshop/36/goods/recommendgoodslist.do?heleId=54604,55830,47624"
        ntwkAccess.request(.get, url: urlstr) {(response, err) -> Void in
            callback(response, err)
        }
    }
}
