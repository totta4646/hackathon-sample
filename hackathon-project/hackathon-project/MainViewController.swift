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

class MainViewController: BaseViewController, AlamofireDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate , CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    let distance : CLLocationDistance = 100
    let clLocationManager: CLLocationManager! = CLLocationManager()

    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0

    var alamofire: AlamofireManager = AlamofireManager.init(delegate: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "いちなび"
        
        alamofire.delegate = self
        alamofire.getPictures()

        clLocationManager.delegate = self
        clLocationManager.distanceFilter = 100.0
        clLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        clLocationManager?.requestWhenInUseAuthorization()
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
        Log(json[0])
    }
}