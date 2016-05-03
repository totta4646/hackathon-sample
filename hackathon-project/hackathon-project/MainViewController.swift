//
//  ViewController.swift
//  hackathon-project
//
//  Created by Kohei Totani on 2016/05/03.
//  Copyright © 2016年 Kohei Totani. All rights reserved.
//

import UIKit
import AssetsLibrary
import MapKit
import CoreLocation

class MainViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
            var clLocationManager: CLLocationManager!

                clLocationManager = CLLocationManager()
        
                clLocationManager.delegate = self
        
                clLocationManager.distanceFilter = 100.0
        
                clLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
            let status = CLLocationManager.authorizationStatus()
        
            if(status == CLAuthorizationStatus.NotDetermined) {
                
                if #available(iOS 8.0, *) {
                    clLocationManager.requestAlwaysAuthorization()
                } else {
                
                };
            }
        
            clLocationManager.startUpdatingLocation()
        
            view.addSubview(mapView)
        
            let myLatitude: CLLocationDegrees = 37.506804
            let myLocation: CLLocationDegrees = 139.930531
            let myCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLocation) as CLLocationCoordinate2D
            let Latdistance : CLLocationDistance = 100
            let Londistance : CLLocationDistance = 100
            let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, Latdistance, Londistance);
        
            mapView.setRegion(myRegion, animated: true)
        
            var mapPin: MKPointAnnotation = MKPointAnnotation()
        
            mapPin.coordinate = myCoordinate
    
            mapView.addAnnotation(mapPin)

        }
    
        func locationManager1(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
            var Locations: NSArray = locations as NSArray
            var LastLocation: CLLocation = Locations.lastObject as! CLLocation
            var Location:CLLocationCoordinate2D = LastLocation.coordinate
        
            let LatDist : CLLocationDistance = 100
            let LonDist : CLLocationDistance = 100
            let Region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(Location, LatDist, LonDist);
        
            mapView.setRegion(Region, animated: true)
    }
    
        func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
            print("regionDidChangeAnimated")
        }
    
        func accessCameraroll(button: UIButton) {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
//            let controller = UIImagePickerController()
//            controller.delegate = self
//            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
    }
}