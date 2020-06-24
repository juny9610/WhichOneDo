//
//  MapViewController.swift
//  WhichOneDo
//
//  Created by 김대환 on 2020/05/28.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit
import Firebase
class MapViewController: UIViewController, MTMapViewDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    var mapView: MTMapView!
    var poiItems: [MTMapPOIItem]!
    var bitters: [MTMapPOIItem] = []
    var sourness:  [MTMapPOIItem] = []
    var watery: [MTMapPOIItem] = []
    var filterArray: [CafeModel] = []
    var new_coordinate:[String] = []
    var gpsImage: UIImage!
    
    @IBOutlet var gpsButton: UIButton!
    @IBOutlet var filter: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        //create MapView
        mapView = MTMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.baseMapType = .standard
        gpsImage = UIImage(named: "GPS")
        let new_image = gpsImage.withTintColor(UIColor(red: 80/255.0, green: 60/255.0, blue: 39/255.0, alpha: 1))
        gpsButton.setImage(new_image, for: .normal)
        let currentLocationMarker = MTMapLocationMarkerItem()
        currentLocationMarker.customTrackingImageName = "tracking_icon.png"
        mapView.updateCurrentLocationMarker(currentLocationMarker)
        filter.backgroundColor = UIColor(red: 167/255.0, green: 142/255.0, blue: 122/255.0, alpha: 1)
        let favoriteViewController = self.tabBarController?.viewControllers![1] as! FavoriteViewController
        favoriteViewController.getStarList1()
        getfilteredList()
        
    }
    func getfilteredList(){
           Database.database().reference().child("cafes").observe(DataEventType.value, with: {
               (datasnapshot) in
               self.filterArray.removeAll()
               for child in datasnapshot.children{
                   let fchild = child as! DataSnapshot
                   let filterModel = CafeModel()
                   filterModel.setValuesForKeys(fchild.value as! [String:Any])
                   self.filterArray.append(filterModel)
               }
            let favoriteViewController = self.tabBarController?.viewControllers![1] as! FavoriteViewController
            let stars = favoriteViewController.stars
            self.poiItems = self.filterArray.map({(cafe) -> MTMapPOIItem in
                let poiItem = MTMapPOIItem()
                poiItem.tag = Int(cafe.cafeId!)!
                poiItem.userObject = cafe
                poiItem.itemName = cafe.cafeName! + "\n" + cafe.taste!
                if stars.contains(where: { $0.cafeName == cafe.cafeName }) {
                    poiItem.markerType = .customImage
                    poiItem.customImageName = "map_pin_favorite.png"
                    poiItem.markerSelectedType = .customImage
                    poiItem.customSelectedImageName = "map_pin_selected.png"
                }
                else{
                    poiItem.markerType = .customImage
                    poiItem.customImageName = "map_pin_brown.png"
                    poiItem.markerSelectedType = .customImage
                    poiItem.customSelectedImageName = "map_pin_selected.png"
                }
                poiItem.showAnimationType = .noAnimation
                poiItem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: cafe.coordinate[1], longitude: cafe.coordinate[0]))
                switch cafe.taste{
                case "쓴맛":
                    self.bitters.append(poiItem)
                case "신맛":
                    self.sourness.append(poiItem)
                case "연한맛":
                    self.watery.append(poiItem)
                default:
                    break
                }
                return poiItem
            })
            self.view.addSubview(self.mapView)
            self.mapView.addPOIItems(self.poiItems)
            self.view.addSubview(self.filter)
            self.view.addSubview(self.gpsButton)
            self.mapView.fitAreaToShowAllPOIItems()

           })
       }
    @IBAction func filtering(_ sender: Any) {
        let selectedIndex = filter.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            mapView.removeAllPOIItems()
            mapView.addPOIItems(poiItems)
        case 1:
            mapView.removeAllPOIItems()
            mapView.addPOIItems(bitters)
        case 2:
            mapView.removeAllPOIItems()
            mapView.addPOIItems(sourness)
        case 3:
            mapView.removeAllPOIItems()
            mapView.addPOIItems(watery)
        default:
            break
        }
        mapView.currentLocationTrackingMode = .off
        mapView.fitAreaToShowAllPOIItems()
    }
    
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonRightSideOf poiItem: MTMapPOIItem!) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "DetailCafeInfoViewController") as? DetailCafeInfoViewController
        let cafe = poiItem.userObject as! CafeModel
        vcName?.get(cafe.cafeName!)
        vcName?.modalTransitionStyle = .coverVertical
        self.present(vcName!, animated: true, completion: nil)
    }
    
    @IBAction func gpsButtonTouched(_ sender: Any) {
        mapView.currentLocationTrackingMode = .onWithoutHeading
    }
    
    func mapUpdate(){
        self.poiItems.removeAll()
        self.bitters.removeAll()
        self.sourness.removeAll()
        self.watery.removeAll()
        Database.database().reference().child("cafes").observe(DataEventType.value, with: {
            (datasnapshot) in
            self.filterArray.removeAll()
            for child in datasnapshot.children{
                let fchild = child as! DataSnapshot
                let filterModel = CafeModel()
                filterModel.setValuesForKeys(fchild.value as! [String:Any])
                self.filterArray.append(filterModel)
            }
         let favoriteViewController = self.tabBarController?.viewControllers![1] as! FavoriteViewController
         let stars = favoriteViewController.stars
         self.poiItems = self.filterArray.map({(cafe) -> MTMapPOIItem in
             let poiItem = MTMapPOIItem()
             poiItem.tag = Int(cafe.cafeId!)!
             poiItem.userObject = cafe
             poiItem.itemName = cafe.cafeName! + "\n" + cafe.taste!
             if stars.contains(where: { $0.cafeName == cafe.cafeName }) {
                 poiItem.markerType = .customImage
                 poiItem.customImageName = "map_pin_favorite.png"
                 poiItem.markerSelectedType = .customImage
                 poiItem.customSelectedImageName = "map_pin_selected.png"
             }
             else{
                 poiItem.markerType = .customImage
                 poiItem.customImageName = "map_pin_brown.png"
                 poiItem.markerSelectedType = .customImage
                 poiItem.customSelectedImageName = "map_pin_selected.png"
             }
             poiItem.showAnimationType = .noAnimation
             poiItem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: cafe.coordinate[1], longitude: cafe.coordinate[0]))
             switch cafe.taste{
             case "쓴맛":
                 self.bitters.append(poiItem)
             case "신맛":
                 self.sourness.append(poiItem)
             case "연한맛":
                 self.watery.append(poiItem)
             default:
                 break
             }
             return poiItem
         })
            self.mapView.removeAllPOIItems()
         self.mapView.addPOIItems(self.poiItems)

        })
    }
}
