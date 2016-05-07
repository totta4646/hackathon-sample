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
    let distance : CLLocationDistance = 100
    let clLocationManager: CLLocationManager! = CLLocationManager()
    var tempImageUrl: Array<String> = []
    
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    
    var alamofire: AlamofireManager = AlamofireManager.init(delegate: nil)
    
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
        let pickedImage:UIImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        let fileManager = NSFileManager.defaultManager()
        // TODO: 一旦ローカル書き込みで回避
        let filePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String + "/pickedimage.JPG"
        let imageData = UIImageJPEGRepresentation(pickedImage, 1.0)
        fileManager.createFileAtPath(filePath, contents: imageData, attributes: nil)
        
        if (fileManager.fileExistsAtPath(filePath)){
            let imageNSURL:NSURL = NSURL.init(fileURLWithPath: filePath)
            alamofire.postPicture(imageNSURL, latitude: latitude.description, longitude: longitude.description);
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
            let defaultLatitude: CLLocationDegrees = (post["latitude"] as! NSString).doubleValue
            let defaultLocation: CLLocationDegrees = (post["longitude"] as! NSString).doubleValue
            let defaultCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(defaultLatitude, defaultLocation) as CLLocationCoordinate2D
            
            let mapPin: MKPointAnnotation = MKPointAnnotation()
            mapPin.coordinate = defaultCoordinate
            let temp = post["picture"];
            tempImageUrl.append((temp as! Dictionary)["url"]!)
            mapView.addAnnotation(mapPin)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "annotation"
        
        
        if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("annotation") {
            return annotationView
        } else {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
            if let url  = NSURL(string: Const.URL + tempImageUrl[0]),
                data = NSData(contentsOfURL: url) {

                let orgImg = UIImage(data: data)!
                let resizedSize = CGSizeMake(50, 50);
                UIGraphicsBeginImageContext(resizedSize);
                orgImg.drawInRect(CGRectMake(0, 0, resizedSize.width, resizedSize.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                tempImageUrl.removeAtIndex(0)

                annotationView.image = resizedImage            }

            return annotationView
        }
        
    }
}