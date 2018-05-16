//
//  ViewController.swift
//  Crystal Blue Persuasion
//
//  Created by Julian Morrisette on 5/14/18.
//  Copyright © 2018 Julian Morrisette. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var theMap: MKMapView!
    @IBOutlet weak var theLabel: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    var manager:CLLocationManager!
    var myLocations: [CLLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup our Location Manager
        manager = CLLocationManager()
        manager.delegate = self as? CLLocationManagerDelegate
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        //Setup our Map View
        theMap.delegate = self as? MKMapViewDelegate
        theMap.mapType = MKMapType.satellite
        theMap.showsUserLocation = true//This should locate the user's current location, and center on it.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        theLabel.text = "   \(locations[0].speed) mph"
        label2.text = "   \(locations[0].coordinate.latitude) latitude"
        label3.text = "   \(locations[0].coordinate.longitude) longitude"
        myLocations.append(locations[0])
        self.theMap.showsUserLocation = true
        
        //Span denotes the accuracy of zoom on the coordinates. Like when it zooms in, how much it zooms in on
        //those coordinates, or any coordinates
        let spanX = 0.007
        let spanY = 0.007
        let newRegion = MKCoordinateRegion(center: theMap.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        theMap.setRegion(newRegion, animated: true)
        
        //this will be a list of coordinates that have been visited
        if (myLocations.count > 1){
            let sourceIndex = myLocations.count - 1//go to the end of the list and take that position as the starting point
            let destinationIndex = myLocations.count - 2//go to the 2nd to last spot in the list and that will be the end point
            /**
            Because this isn't watching between any 2 destinations, it will be tracking movement. Because of this,
             the 2nd spot will be where the user is, and the source is where they started. The "Destination" updates
             as the user moves
             */
            //c1 and c2 are the coordinates of the source and destination
            let coordinate1 = myLocations[sourceIndex].coordinate
            let coordinate2 = myLocations[destinationIndex].coordinate
            var area = [coordinate1, coordinate2]
            //this should be the line drawn for the path the user is following
            let polyline = MKPolyline(coordinates: &area, count: area.count)//this draws a straight line since there are only 2 inputs within
                                                                            //the area list. Just the 2 coordinates
            theMap.add(polyline)
        }}
    
   //may/may not function
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //This should draw a green line onver the user's current-moved path
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.green
            polylineRenderer.lineWidth = 4
            return MKPolylineRenderer()
        }
        return MKPolylineRenderer()
    }}

