//
//  ViewController.swift
//  Distance
//
//  Created by Matt on 29/05/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var firstLocationLabel: UILabel!
    @IBOutlet private weak var secondLocationLabel: UILabel!
    @IBOutlet weak var distanceBtn: UIButton!
    
    // MARK: - Properties
    var firstLongitude: Double?
    var firstLatitude: Double?
    var secondLongitude: Double?
    var secondLatitude: Double?
    
    // MARK: - Coordinates to calculate distance
    var firstCoordinates: CLLocation? {
        guard let firstLatitude = firstLatitude, let firstLongitude = firstLongitude else { return nil }
        return CLLocation(latitude: firstLatitude, longitude: firstLongitude)
    }
    
    var secondCoordinates: CLLocation? {
        guard let secondLatitude = secondLatitude, let secondLongitude = secondLongitude else { return nil }
               return CLLocation(latitude: secondLatitude, longitude: secondLongitude)
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        distanceBtnIsEnable(firstCoordinates != nil && secondCoordinates != nil)
    }
    // MARK: - GetPlace
    func getPlace(lat: Double, long: Double, label: UILabel) {
        NetworkManager.shared.getPlace(latitude: lat, longitude: long) { [weak self] result in
            switch result {
            case .success(let place):
                label.text = place.addressDescription
            case .failure(_):
                self?.getLocationAlert()
            }
            
        }
    }
    
// MARK: - IBActions
    @IBAction func firstLocationTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MapViewController", bundle: nil)
        let mapVC = storyboard.instantiateViewController(identifier: "MapViewController") as! MapViewController
        let navigationVC = UINavigationController()
        navigationVC.viewControllers = [mapVC]
        navigationVC.modalPresentationStyle = .fullScreen
        
        if let firstLatitude = firstLatitude, let firstLongitude = firstLongitude {
            mapVC.latitude = firstLatitude
            mapVC.longitude = firstLongitude
        }
        
        mapVC.onGetLocation = { [weak self] mapLatitude, mapLongitude in
            self?.firstLocationLabel.text = "\(mapLatitude), \(mapLongitude)"
            self?.getPlace(lat: mapLatitude, long: mapLongitude, label: (self?.firstLocationLabel)!)
            self?.firstLatitude = mapLatitude
            self?.firstLongitude = mapLongitude
        }
        present(navigationVC, animated: true, completion: nil)
    }
   
    @IBAction func secondLocationTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MapViewController", bundle: nil)
        let mapVC = storyboard.instantiateViewController(identifier: "MapViewController") as! MapViewController
        let navigationVC = UINavigationController()
        navigationVC.viewControllers = [mapVC]
        navigationVC.modalPresentationStyle = .fullScreen
        
        if let secondLatitude = secondLatitude, let secondLongitude = secondLongitude {
            mapVC.latitude = secondLatitude
            mapVC.longitude = secondLongitude
        }
        
        mapVC.onGetLocation = { [weak self] latitude, longitude in
            self?.secondLocationLabel.text = "\(latitude), \(longitude)"
            self?.getPlace(lat: latitude, long: longitude, label: (self?.secondLocationLabel)!)
            self?.secondLatitude = latitude
            self?.secondLongitude = longitude
        }
        present(navigationVC, animated: true, completion: nil)
    }

    
    @IBAction func distanceTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "DistanceViewController", bundle: nil)
        let distanceVC = storyboard.instantiateViewController(identifier: "DistanceViewController") as! DistanceViewController
        
        guard let firstCoordinates = firstCoordinates, let secondCoordinates = secondCoordinates else { return }
        let distanceInMeters = (firstCoordinates.distance(from: secondCoordinates))
        let distanceInKm = distanceInMeters / 1000
        
        distanceVC.distanceInKm = distanceInKm
        distanceVC.distanceInMeters = Int(distanceInMeters)

        present(distanceVC, animated: true, completion: nil)
    }
    
    // MARK: - Helper functions
    func distanceBtnIsEnable(_ enable: Bool) {
           distanceBtn.isEnabled = enable
           distanceBtn.alpha = enable ? 1 : 0.5
       }
       
       func getLocationAlert() {
           let alert = UIAlertController(title: "Can't get location, please try again",
                                         message: nil,
                                         preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
           self.present(alert, animated: true)
       }
    
}

