//
//  CafeModel.swift
//  WhichOneDo
//
//  Created by 강희선 on 2020/06/01.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit
import Firebase
class CafeModel: NSObject {
    @objc var americanoPrice: String?
    @objc var cafeBusinessHours: String?
    @objc var cafeName: String?
    @objc var coffeeBeanHome: String?
    @objc var coordinate: [Double] = []
    @objc var location: String?
    @objc var number: String?
    @objc var taste: String?
}
