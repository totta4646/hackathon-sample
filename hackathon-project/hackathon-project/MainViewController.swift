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

class MainViewController: BaseViewController, AlamofireDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate , CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let alamofire: AlamofireManager = AlamofireManager.init(delegate: nil)

    let distance: CLLocationDistance = 100
    let clLocationManager: CLLocationManager! = CLLocationManager()
    var tempImageUrl: [String] = []
    
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "いちなび"
        
        alamofire.delegate = self
        alamofire.getPictures()

        mapView.delegate = self
        
        clLocationManager.delegate = self
        clLocationManager.distanceFilter = distance
        clLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        clLocationManager?.requestWhenInUseAuthorization()
        clLocationManager.startUpdatingLocation()
        
        let defaultLatitude: CLLocationDegrees = 35.674643
        let defaultLocation: CLLocationDegrees = 139.70452
        let defaultCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(defaultLatitude, defaultLocation) as CLLocationCoordinate2D
        let defaultRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(defaultCoordinate, distance, distance);
    
        mapView.setRegion(defaultRegion, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {

        let location: CLLocationCoordinate2D = newLocation.coordinate
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, distance, distance);

        latitude = location.latitude
        longitude = location.longitude
        
        mapView.setRegion(region, animated: true)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let pickedImage: UIImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        
        if let imageURL: NSURL = ImageUtils.createImageForFileManager(pickedImage) {
            alamofire.postPicture(imageURL, latitude: latitude.description, longitude: longitude.description);
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }

    @IBAction func postAction(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let ImagePicker = UIImagePickerController()
            ImagePicker.delegate = self
            ImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(ImagePicker, animated: true, completion: nil)
        }
    }
    
    func request(json: AnyObject) {
        let posts = json as! Array<AnyObject> as Array
        
        for post in posts {
            let latitude: CLLocationDegrees = (post["latitude"] as! NSString).doubleValue
            let longitude: CLLocationDegrees = (post["longitude"] as! NSString).doubleValue
            let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude) as CLLocationCoordinate2D
            
            let pin: MKPointAnnotation = MKPointAnnotation()
            pin.coordinate = coordinate

            tempImageUrl.append((post["picture"] as! Dictionary)["url"]!)

            mapView.addAnnotation(pin)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "annotation"
        
        if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("annotation") {
            return annotationView
        } else {

            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            if let postImage: UIImage = ImageUtils.getByUrl(Const.URL + tempImageUrl[0]) {
                tempImageUrl.removeFirst()
                annotationView.image = ImageUtils.resize(postImage, width: 50, height: 50)

            }
            
            return annotationView
        }
        
    }
}