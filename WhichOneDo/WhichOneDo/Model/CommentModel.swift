//
//  CommentModel.swift
//  WhichOneDo
//
//  Created by 강희선 on 2020/06/24.
//  Copyright © 2020 강희선. All rights reserved.
//

import ObjectMapper
class CommentModel: Mappable{
    public var comments: Dictionary<String, Comments> = [:]
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        comments <- map["comments"]
    }
    public class Comments: Mappable{
        public var message: String?
        public required init?(map: Map) {
            
        }
        public func mapping(map: Map) {
            message <- map["message"]
        }
    }

}
