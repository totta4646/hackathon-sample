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
    let distance : CLLocationDistance = 100

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
            };
        }
        clLocationManager.startUpdatingLocation()
        
        let defaultLatitude: CLLocationDegrees = 37.506804
        let defaultLocation: CLLocationDegrees = 139.930531
        let defaultCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(defaultLatitude, defaultLocation) as CLLocationCoordinate2D
        let defaultRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(defaultCoordinate, distance, distance);
    
        mapView.setRegion(defaultRegion, animated: true)

        // TODO sample用のpinを打つメソッド
        // 汎用的に使わせるためにメソッド化させるほうがいいと思う。
        let mapPin: MKPointAnnotation = MKPointAnnotation()
        mapPin.coordinate = defaultCoordinate
        mapView.addAnnotation(mapPin)
        
    }
    
    func locationManagerFunc(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {

        let locations: NSArray = locations as NSArray
        let lastLocation: CLLocation = locations.lastObject as! CLLocation
        let location:CLLocationCoordinate2D = lastLocation.coordinate
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, distance, distance);

        mapView.setRegion(region, animated: true)
    }
    
    
    func accessCameraroll(button: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {

        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
    }
    @IBAction func postAction(sender: AnyObject) {
   
    }
}