//
//  MapViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 07.09.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let tabBar = UITabBarItem(title: "Карта",
                              image: UIImage(systemName: "map"),
                              selectedImage: UIImage(systemName: "map.fill"))
    
    var mapView = MKMapView()
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeAnnotation))
        
        setup()
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        tabBarItem = tabBar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeAnnotation()
    }
    
    func setup() {
        mapView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        mapView.mapType = .standard
        manager.delegate = self
        
        tapForAddAnnotations()
        requestLocationAuthorization()
    }
    
    func tapForAddAnnotations() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(tap(_ :)))
        mapView.addGestureRecognizer(gesture)
    }
    
    @objc func tap(_ recognizer: UILongPressGestureRecognizer) {
        removeAnnotation()
        let point: CGPoint = recognizer.location(in: mapView)
        let tapCoordinates: CLLocationCoordinate2D = mapView.convert(point, toCoordinateFrom: view)
        let annotation = MKPointAnnotation()
        annotation.coordinate = tapCoordinates
        annotation.title = "Метка"
        mapView.addAnnotation(annotation)
        addRoute(destination: tapCoordinates)
    }
    
    @objc func removeAnnotation() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
    }
    
    func addRoute(destination location: CLLocationCoordinate2D) {
        let directionRequest = MKDirections.Request()
        
        guard let myLocation = manager.location?.coordinate else { return }
        let sourcePlaceMark = MKPlacemark(coordinate: myLocation)
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        
        let destinationPlaceMark = MKPlacemark(coordinate: location)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        
        directionRequest.transportType = .walking
        let directions = MKDirections(request: directionRequest)
        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            guard let response = response else {
                if let error = error {
                    print(error)
                }
                return
            }
            guard let route = response.routes.first else { return }
            self.mapView.delegate = self
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
    }
    
    func requestLocationAuthorization() {
        let currentStatus = manager.authorizationStatus
        switch currentStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsScale = true
            mapView.showsUserLocation = true
            mapView.showsCompass = true
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("Необходимо изменить настройки")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 6
        renderer.strokeColor = .blue
        return renderer
    }
}
