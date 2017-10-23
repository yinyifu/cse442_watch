import UIKit
import GoogleMaps
import CoreLocation

class MapController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet var mapView: GMSMapView!
    var cmm : LocationManagerController?;
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cmm = LocationManagerController(mapview: mapView);
        mapView.isMyLocationEnabled = true;
        mapView.camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 16.0);
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        //self._mapView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        //self.view.addSubview(self._mapView)
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: -32.868, longitude: 151.208))
        
        NSLog("search motherfucker \(mapView.camera.target.latitude) and \(mapView.camera.target.longitude)");
        
        /*
        self.cm.requestAlwaysAuthorization();
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            let lc = LocationManagerController(mapview: mapView);
            self.cm.delegate = lc
            self.cm.desiredAccuracy = kCLLocationAccuracyBest;
            self.cm.startUpdatingLocation()
        }else{
            NSLog("Not authorized.");
        }
        */
    }
    func setCenter(_ coord:CLLocationCoordinate2D){
        mapView.camera = GMSCameraPosition.camera(withLatitude: coord.latitude, longitude: coord.longitude, zoom: 16.0);
        NSLog("search motherfucker \(mapView.camera.target.latitude) and \(mapView.camera.target.longitude)");
    }
    func routeTo(_ coord:CLLocationCoordinate2D, _ dir:CLLocationDirection){
    
        
        let marker : GMSMarker = GMSMarker();
        marker.position=CLLocationCoordinate2DMake(18.5203, 73.8567);
        marker.icon = UIImage(named:"download") ;
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5);
        marker.map=mapView;
        let path : GMSMutablePath = GMSMutablePath();
        path.add(marker.position)
        path.add(CLLocationCoordinate2DMake(16.7, 73.8567))
        let rectangle :GMSPolyline = GMSPolyline(path:path);
        rectangle.strokeWidth = 2.2;
        rectangle.map = self.mapView;
    }
    override func viewDidLayoutSubviews() {
        self.view.frame = CGRect(x:0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height);
        
    }
}


extension MapController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}
