//
//  ViewController.swift
//  HelloMKMapView
//
//  Created by eavictor on 2020/12/21.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    @IBAction func addMeAnnotation(_ sender: UILongPressGestureRecognizer) {
        let touchPoint = sender.location(in: map)
        let touchCoordinate:CLLocationCoordinate2D = map.convert(touchPoint, toCoordinateFrom: map)
        
        let annotation:MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = touchCoordinate
        annotation.title = "New point"
        annotation.subtitle = "I want to be there one day"
        map.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let latitude:CLLocationDegrees = 48.858547
        let longitude:CLLocationDegrees = 2.294524
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let xScale:CLLocationDegrees = 0.01
        let yScale:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        map.mapType = MapKit.MKMapType.satellite
        
        
    }


}

