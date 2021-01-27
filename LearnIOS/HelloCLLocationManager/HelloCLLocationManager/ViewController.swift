//
//  ViewController.swift
//  HelloCLLocationManager
//
//  Created by eavictor on 2020/12/21.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager? = nil

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.activityType = CLActivityType.automotiveNavigation
        locationManager?.startUpdatingLocation()
        
        if let coordinate:CLLocationCoordinate2D = locationManager?.location?.coordinate {
            let xScale:CLLocationDegrees = 0.01
            let yScale:CLLocationDegrees = 0.01
            let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
            let region:MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
            map.setRegion(region, animated: true)
        }
        map.userTrackingMode = MKUserTrackingMode.follow
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinate:CLLocationCoordinate2D = locations[0].coordinate
        print("------")
        print(coordinate.latitude)
        print(coordinate.longitude)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager?.stopUpdatingLocation()
    }


}

