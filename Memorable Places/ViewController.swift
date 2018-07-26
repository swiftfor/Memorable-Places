//
//  ViewController.swift
//  Memorable Places
//
//  Created by Hamada on 6/5/18.
//  Copyright © 2018 Hamada. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
var manager = CLLocationManager()
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let uilgp = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(gestureRecognizer:)))
        uilgp.minimumPressDuration = 2
        map.addGestureRecognizer(uilgp)
        if activePlaces == -1 {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
        else {
            if places.count > activePlaces{
                if let name = places[activePlaces]["name"]{
                    if let lat = places[activePlaces]["lat"]{
                        if let lon = places[activePlaces]["lon"]{
                            if let latitude = Double(lat){
                                if let longitude = Double(lon) {
                            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                            let region = MKCoordinateRegion(center: coordinate, span: span)
                           self.map.setRegion(region, animated: true)
                                    let annotation = MKPointAnnotation()
                                    annotation.coordinate = coordinate
                                    annotation.title = name
                                    annotation.subtitle = "this place where i wanna go to it in future"
                                    self.map.addAnnotation(annotation)
                                }
                            }
                        }
                    }
                    
                    
                }
                
            }
        }
    }
    @objc func longPress(gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.began {
    let touchpoint = gestureRecognizer.location(in: self.map)
        let newCoordinate = self.map.convert(touchpoint, toCoordinateFrom: self.map)
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            var title = ""
            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                if error != nil {
                    print(error)
                }
                else
                {
                    if let placemark = placemarks?[0]{
                        if placemark.subThoroughfare != nil {
                            title += placemark.subThoroughfare! + " "
                        }
                        if placemark.thoroughfare != nil {
                            title += placemark.thoroughfare! + "\n"
                        }
                    }
                }
                if title == "" {
                    title = "Added \(NSDate())"
                }
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = newCoordinate
                    annotation.title = title
                    annotation.subtitle = "i wanna go to it soon"
                    self.map.addAnnotation(annotation)
                    places.append(["name":"Taj Mahal" , "lat" :String(newCoordinate.latitude) , "lon" : String(newCoordinate.longitude)])
                    UserDefaults.standard.set(places, forKey: "place")
                }
            }
        
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
    }
    }
  

