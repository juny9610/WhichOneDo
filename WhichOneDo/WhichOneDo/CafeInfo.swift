//
//  CafeInfo.swift
//  WhichOneDo
//
//  Created by 김대환 on 2020/05/28.
//  Copyright © 2020 강희선. All rights reserved.
//

import Foundation

class CafeInfo{
    var id: Int
    var name: String
    var taste: String
    var coordinate: (Double,Double)
    init(id: Int, name: String, taste: String, coordinate: (Double,Double)) {
        self.id = id
        self.name = name
        self.taste = taste
        self.coordinate = coordinate
    }
}

let cafeInfo = [CafeInfo(id: 0, name: "스타벅스 한양대점", taste: "쓴맛", coordinate:                            (127.042092,37.5571353)),
                CafeInfo(id: 1, name: "아리가또", taste: "신맛", coordinate: (127.039208,37.5610015)),
                CafeInfo(id: 2, name: "아리가또 2호점", taste: "신맛", coordinate:
                    (127.039525,37.5613438)),
                CafeInfo(id: 3, name: "띠앋", taste: "쓴맛", coordinate:
                    (127.040531,37.5594514)),
                CafeInfo(id: 4, name: "할리스커피 한양대시티빌점", taste: "쓴맛", coordinate: (127.039898,37.5604787))]
