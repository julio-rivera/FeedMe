//
//  FMMainInterfaceController.swift
//  FeedMe WatchKit Extension
//
//  Created by Julio Rivera on 3/4/15.
//  Copyright (c) 2015 Julio Rivera. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation

class FMMainInterfaceController: WKInterfaceController, LocationManagerDelegate {

    //MARK: -
    //MARK: Outlets
    @IBOutlet weak private var feedMeButton: WKInterfaceButton!

    //MARK: - 
    //MARK: InterfaceController Lifecycle
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    //MARK: -
    //MARK: Action Methods
    @IBAction private func feedMeButtonTapped() {
        self.startUpdatingLocation()
    }

    //MARK: -
    //MARK: Private Methods
    private func showRestaurants(restaurants: Array<FMRestaurant>?) {
        self.pushControllerWithName("FMRestaurantsInterfaceController", context: restaurants)
    }

    private func showErrorController(error: NSError?) {
        self.pushControllerWithName("FMErrorInterfaceController", context: error)
    }

    private func startUpdatingLocation() {
        if (LocationManager.authorization().isAuthorized){
            LocationManager.delegate = self
            LocationManager.startUpdatingLocation()
        } else {
            self.showErrorController(LocationManager.authorization().error)
        }
    }

    //MARK: -
    //MARK: <LocationManagerDelegate>
    internal func locationManager(didUpdateLocation location: CLLocation!) {
        RestaurantAPI.restaurantsNearLocation(location,
            completion: { (restaurants, error) -> Void in
                if ((error) != nil){
                    self.showErrorController(error)
                } else {
                    self.showRestaurants(restaurants)
                }
            })
    }

    internal func locationManager(didFailWithError error: NSError!) {
        self.showErrorController(error)
    }

}
