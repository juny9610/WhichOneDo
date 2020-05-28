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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MTMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.baseMapType = .standard
        //mapView.showCurrentLocationMarker = true
        //mapView.currentLocationTrackingMode = .onWithoutHeading
        self.view.addSubview(mapView)
        // Do any additional setup after loading the view.
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
