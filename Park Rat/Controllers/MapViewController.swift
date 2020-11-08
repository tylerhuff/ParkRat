//
//  ViewController.swift
//  Park Rat
//
//  Created by Tyler Huff on 10/4/20.
//  Copyright © 2020 Tyler Huff. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        
        
        map.delegate = self
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.showsScale = true
        map.showsCompass = true
        map.showsUserLocation = true
        
        if let coor = locationManager.location {
            map.setCenter(coor.coordinate, animated: true)
            let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let region = MKCoordinateRegion(center: coor.coordinate, span: span)
            map.setRegion(region, animated: true)
        }
        
        //load parks
        var parser = SkateparkParser()
        
        parser.excelParser()
        for park in parser.skateparks {
            
            let coordinate = CLLocationCoordinate2D(latitude: park.latitude, longitude: park.longitude)
            
            if park.visited {
                let pin = VisitedSkateparkMarkerView(title: park.name, coordinate: coordinate, info: "", parkInfo: park)
                self.map.addAnnotation(pin)
            } else {
                let pin = SkateparkMarkerView(title: park.name, coordinate: coordinate, info: "", parkInfo: park)
                self.map.addAnnotation(pin)
            }
            
            
        }
    }
    
    
    
    @IBAction func goToCurrentLocation(_ sender: UIBarButtonItem) {
        
        
        if let coor = map.userLocation.location?.coordinate{
            map.setCenter(coor, animated: true)
            let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let region = MKCoordinateRegion(center: coor, span: span)
            map.setRegion(region, animated: true)
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
}


extension MapViewController {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // If annotation refers to user location user default Annotation View
        if annotation === mapView.userLocation { return nil }
        
        
        var color = UIColor.red
        var identifier = "SkateparkMarkerView"
        if type(of: annotation) == VisitedSkateparkMarkerView.self {
            color = UIColor.green
            identifier = "VisitedSkateparkMarkerView"
        }
        // 3
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            //4
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6
            annotationView?.annotation = annotation
        }
        annotationView?.markerTintColor = color
        annotationView?.annotation = annotation
        annotationView?.displayPriority = .required
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    
        performSegue(withIdentifier: "mapViewToSkateparkView", sender: MapViewController.self)
            let ac = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)

    }
    
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mapViewToSkateparkView" {
            if let nextViewController = segue.destination as? SkateparkViewController {
                            nextViewController.skatepark = "XYZ" //Or pass any values

                    }
        }
        
        
    }
    

    
}
