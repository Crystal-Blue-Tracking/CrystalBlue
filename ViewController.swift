import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //Map
    @IBOutlet weak var map: MKMapView!
    
    let Location_manager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        Location_manager.delegate = self
        Location_manager.desiredAccuracy = kCLLocationAccuracyBest
        Location_manager.requestWhenInUseAuthorization()
        Location_manager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]//locations is a CLLocation object
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)//mistake number 1 -> did not input range
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)//span is how accurate the locator is
        map.setRegion(region, animated: true)//this will be a combination of your current location(latitude and longitude) but also the
                                            //accuracy will be based upon the span object
        
        print("Altitude: ",location.altitude)
        print("Speed: ",location.speed)
        
        self.map.showsUserLocation = true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

