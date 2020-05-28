//
//  MapViewController.swift
//  WhichOneDo
//
//  Created by 김대환 on 2020/05/28.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate {

    var mapView: MTMapView!
    var poiItems: [MTMapPOIItem]!
    var bitters: [MTMapPOIItem] = []
    var sourness:  [MTMapPOIItem] = []
    @IBOutlet var filter: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //create MapView
        mapView = MTMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.baseMapType = .standard
        //mapView.showCurrentLocationMarker = true
        //mapView.currentLocationTrackingMode = .onWithHeading

        //create POIItem
        poiItems = cafeInfo.map({ (cafe: CafeInfo) -> MTMapPOIItem in
            let poiItem = MTMapPOIItem()
            poiItem.itemName = cafe.name
            poiItem.tag = cafe.id
            poiItem.markerType = .bluePin
            poiItem.markerSelectedType = .redPin
            poiItem.showAnimationType = .noAnimation
            poiItem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: cafe.coordinate.1, longitude: cafe.coordinate.0))
            switch cafe.taste{
            case "쓴맛":
                bitters.append(poiItem)
            case "신맛":
                sourness.append(poiItem)
            default:
                break
            }
            return poiItem
        })
        mapView.addPOIItems(poiItems)
        mapView.fitAreaToShowAllPOIItems()
        
        self.view.addSubview(mapView)
        self.view.addSubview(filter)
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
        default:
            break
        }
    }
    
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonRightSideOf poiItem: MTMapPOIItem!) {
        /*
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
        vcName?.modalTransitionStyle = .coverVertical
        self.present(vcName!, animated: true, completion: nil)
        */
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
