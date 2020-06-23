//
//  CommunityModel.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/06/23.
//  Copyright © 2020 강희선. All rights reserved.
//

import ObjectMapper

class CommunityModel: Mappable{
    public var title: String?
    public var contents: String?
    public var time: String?
    public var userID: String?
    public var likeNum: String?
    public var commentsNum: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        title <- map["title"]
        contents <- map["contents"]
        time <- map["time"]
        userID <- map["userID"]
        likeNum <- map["likeNum"]
        commentsNum <- map["commentsNum"]
    }
    
    public class Comments: Mappable {
        public var contents: String?
        public var time: String?
        public required init?(map: Map) {
            
        }
        public func mapping(map: Map) {
            contents <- map["contents"]
            time <- map["time"]
        }
    }
    
}
