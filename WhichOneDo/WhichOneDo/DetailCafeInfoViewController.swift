//
//  DetailCafeInfoViewController.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/05/22.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit
import Firebase
//struct Cafe{
//    var cafeImage : String
//    var cafeName : String
//    var coffeeBeanHome : String
//    var coffeeFlavor : String
//    var americanoPrice : String
//    var cafeBusinessHours : String
//    var cafeAddress : String
//    var cafePhone : String
//}

//var cafes : [Cafe] = [
//    Cafe(cafeImage: "스타벅스", cafeName: "스타벅스 한양대점", coffeeBeanHome: "케냐", coffeeFlavor: "쓴맛", americanoPrice: "4100원", cafeBusinessHours: "월 : 07 : 30 ~ 20 : 00\n화 : 07 : 30 ~ 20 : 00\n수 : 07 : 30 ~ 20 : 00\n목 : 07 : 30 ~ 20 : 00\n금 : 07 : 30 ~ 20 : 00\n토 : 07 : 30 ~ 20 : 00\n일 : 07 : 30 ~ 20 : 00", cafeAddress: "서울시 성동구 왕십리로 225", cafePhone: "02-1522-3232"),
//    Cafe(cafeImage: "", cafeName: "아리가또", coffeeBeanHome: "과테말라", coffeeFlavor: "신맛", americanoPrice: "3800원", cafeBusinessHours: "", cafeAddress: "서울시 성동구 마조로1길 39", cafePhone: ""),
//    Cafe(cafeImage: "", cafeName: "띠앋", coffeeBeanHome: "코스타리카", coffeeFlavor: "쓴맛, 신맛", americanoPrice: "2500원", cafeBusinessHours: "", cafeAddress: "서울시 성동구 마조로 17 1층 제2호", cafePhone: "010-8429-9308"),
//    Cafe(cafeImage: "", cafeName: "카페흥신소", coffeeBeanHome: "코스타리카", coffeeFlavor: "쓴맛", americanoPrice: "4500원", cafeBusinessHours: "", cafeAddress: "서울시 성동구 왕십리로 231 1층", cafePhone: "0507-1342-2143"),
//    Cafe(cafeImage: "", cafeName: "커피빈 왕십리민자역사점", coffeeBeanHome: "인도네시아", coffeeFlavor: "고소한맛", americanoPrice: "4800원", cafeBusinessHours: "", cafeAddress: "서울시 성동구 왕십리광장로 17", cafePhone: "02-2200-6120")
//]

class DetailCafeInfoViewController: UIViewController {
    //txt outlet
    @IBOutlet var txtCoffeeBeanHome: UILabel!
    @IBOutlet var txtCoffeeFlavor: UILabel!
    @IBOutlet var txtAmericanoPrice: UILabel!
    @IBOutlet var txtCafeBusinessHours: UILabel!
    @IBOutlet var txtCafeAddress: UILabel!
    @IBOutlet var txtCafePhone: UILabel!
    //variable outlet
    @IBOutlet var cafeImage: UIImageView!
    @IBOutlet var cafeName: UILabel!
    @IBOutlet var coffeeBeanHome: UILabel!
    @IBOutlet var coffeeFlavor: UILabel!
    @IBOutlet var americanoPrice: UILabel!
    @IBOutlet var cafeBusinessHours: UILabel!
    @IBOutlet var cafeAddress: UILabel!
    @IBOutlet var cafePhone: UILabel!

    var name: String!
    var cafeArray:[CafeModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getCafeDetail(name)
    }
    func get(_ name1:String){
        name = name1
    }

    func getCafeDetail(_ name1: String){
        Database.database().reference().child("cafes").observe(DataEventType.value, with: {
            (datasnapshot) in
            self.cafeArray.removeAll()
            for child in datasnapshot.children{
                let fchild = child as! DataSnapshot
                let cafeModel = CafeModel()
                cafeModel.setValuesForKeys(fchild.value as! [String:Any])
                if cafeModel.cafeName == name1{
                    self.cafeArray.append(cafeModel)
                    self.cafeName.text = name1
                    self.americanoPrice.text = self.cafeArray[0].americanoPrice
                    self.cafeAddress.text = self.cafeArray[0].location
                    self.cafePhone.text = self.cafeArray[0].number
                    self.cafeBusinessHours.text = self.cafeArray[0].cafeBusinessHours
                    self.coffeeFlavor.text = self.cafeArray[0].taste
                    self.coffeeBeanHome.text = self.cafeArray[0].coffeeBeanHome
                    break
                }
            }
        })
    }
   
}
