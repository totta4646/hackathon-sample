//
//  ViewController.swift
//  hackathon-project
//
//  Created by Kohei Totani on 2016/05/03.
//  Copyright © 2016年 Kohei Totani. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: BaseViewController , MKMapViewDelegate, CLLocationManagerDelegate {
//    var myMapView: MKMapView!
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        locationManager.distanceFilter = 100.0
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        let status = CLLocationManager.authorizationStatus()

        if(status == CLAuthorizationStatus.NotDetermined) {

            if #available(iOS 8.0, *) {
                self.locationManager.requestAlwaysAuthorization()
            } else {
                // Fallback on earlier versions
            };
        }
        
        locationManager.startUpdatingLocation()
        
        //let mapView : MKMapView = MKMapView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        
        // mapView.delegate = self
        
        // self.view.addSubview(mapView)
        
        let currentLatitude: CLLocationDegrees = 35.689634
        let myLon: CLLocationDegrees = 139.692101
        let myCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLatitude, myLon) as CLLocationCoordinate2D
        
        let myLatDistance : CLLocationDistance = 100
        let myLonDistance : CLLocationDistance = 100
        
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, myLatDistance, myLonDistance);
        
        // mapView.setRegion(myRegion, animated: true)
        
    }
     func CLlocationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let myLocations: NSArray = locations as NSArray
        let myLastLocation: CLLocation = myLocations.lastObject as! CLLocation
        let myLocation:CLLocationCoordinate2D = myLastLocation.coordinate
        
    }

    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        print("regionDidChangeAnimated")
    }

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        case .AuthorizedWhenInUse:
            print("AuthorizedWhenInUse")
        case .Authorized:
            print("Authorized")
        case .Denied:
            print("Denied")
        case .Restricted:
            print("Restricted")
        case .NotDetermined:
            print("NotDetermined")
        default:
            print("etc.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

