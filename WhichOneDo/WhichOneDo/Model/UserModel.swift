//
//  UserModel.swift
//  WhichOneDo
//
//  Created by 강희선 on 2020/06/10.
//  Copyright © 2020 강희선. All rights reserved.
//

import ObjectMapper
class UserModel: Mappable{
    public var users: Dictionary<String, Stars> = [:]
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        users <- map["users"]
    }
    public class Stars: Mappable{
        public var cafeId: String?
        public var cafeName: String?
        public var cafePosition: [Double] = []
        public required init?(map: Map) {
            
        }
        public func mapping(map: Map) {
            cafeName <- map["cafeName"]
            cafePosition <- map["cafePosition"]
            cafeId <- map["cafeId"]
        }
    }

}
