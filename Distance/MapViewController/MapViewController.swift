//
//  MapViewController.swift
//  Distance
//
//  Created by Matt on 29/05/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: - Properties
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    var onGetLocation: ((Double, Double) -> Void)?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackButton()
        setupInterface()
        longPressTap()
        putPin(lat: latitude, long: longitude)
    }
    
    func setupInterface() {
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
    }
    // MARK: - Handle Tap on Map
    func longPressTap() {
        let longPress = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(longPress)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
    
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

        latitude = coordinate.latitude.rounded(toPlaces: 6)
        longitude = coordinate.longitude.rounded(toPlaces: 6)
        
        guard let onGetLocation = onGetLocation else { return }
        onGetLocation(latitude, longitude)
        mapView.removeAnnotations(mapView.annotations)

        putPin(lat: latitude, long: longitude)

    }
    
    func putPin(lat: Double, long: Double) {
        let locationCoords = CLLocationCoordinate2DMake(lat,long)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoords
        
        let latitudeTitle = "latitude: \(String(format: "%f", annotation.coordinate.latitude)) "
        let longitudeTitle = "longitude: \(String(format: "%f", annotation.coordinate.longitude))"
        annotation.title = latitudeTitle + longitudeTitle
        
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - Helper functions
    func makeBackButton() {
        let leftButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(buttonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc private func buttonTapped() {
        dismiss(animated: true, completion: nil)
    }
}


