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
    var mapView: MTMapView!
    var poiItems: [MTMapPOIItem]!
    var bitters: [MTMapPOIItem] = []
    var sourness:  [MTMapPOIItem] = []
    var watery: [MTMapPOIItem] = []
    
    var filterArray: [CafeModel] = []
    var new_coordinate:[String] = []
    @IBOutlet var filter: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create MapView
        mapView = MTMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.baseMapType = .standard
        //mapView.showCurrentLocationMarker = true
        //mapView.currentLocationTrackingMode = .onWithHeading
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
            self.poiItems = self.filterArray.map({(cafe) -> MTMapPOIItem in
                let poiItem = MTMapPOIItem()
                poiItem.itemName = cafe.cafeName
                poiItem.markerType = .bluePin
                poiItem.markerSelectedType = .redPin
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
            print("poiItem: ", self.poiItems.count)
            print("bitters: ", self.bitters.count)
            print("ssourness: ", self.sourness.count)
            print("watery: ", self.watery.count)
            self.mapView.addPOIItems(self.poiItems)
            self.mapView.fitAreaToShowAllPOIItems()
            self.view.addSubview(self.mapView)
            self.view.addSubview(self.filter)
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
    }
    
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonRightSideOf poiItem: MTMapPOIItem!) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "DetailCafeInfoViewController") as? DetailCafeInfoViewController
        vcName?.get(poiItem.itemName)
        vcName?.modalTransitionStyle = .coverVertical
        self.present(vcName!, animated: true, completion: nil)
        
    }
}
