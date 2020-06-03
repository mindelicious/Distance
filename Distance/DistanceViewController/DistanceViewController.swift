//
//  DistanceViewController.swift
//  Distance
//
//  Created by Matt on 29/05/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import UIKit

class DistanceViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var kilometersLabel: UILabel!
    @IBOutlet private weak var metersLabel: UILabel!
    
    var distanceInKm: Double!
    var distanceInMeters: Int!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showDistance()
    }
    
    func showDistance() {
        kilometersLabel.text = "\(String(distanceInKm.rounded(toPlaces: 1))) Kilometers"
        metersLabel.text = "\(String(distanceInMeters.formattedWithSeparator)) Meters"
    }
    
}
