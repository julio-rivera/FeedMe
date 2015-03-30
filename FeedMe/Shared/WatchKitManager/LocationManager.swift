//
//  LocationManager.swift
//  FeedMe
//
//  Created by Julio Rivera on 3/1/15.
//  Copyright (c) 2015 Julio Rivera. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func locationManager(didUpdateLocation location: CLLocation!)
    func locationManager(didFailWithError error: NSError!)
}

class LocationManager: NSObject, CLLocationManagerDelegate {

    //MARK: -
    //MARK: Variables
    internal var userLocation  : CLLocation?
    internal weak var delegate : LocationManagerDelegate?

    static weak var delegate: LocationManagerDelegate? {
        didSet {
            self.sharedInstance.delegate = delegate
        }
    }

    private class var sharedInstance: LocationManager{
        struct Singleton {
            static let instance = LocationManager()
        }
        return Singleton.instance
    }

    private lazy var locationManager:CLLocationManager = {
        var tempLocationManager: CLLocationManager = CLLocationManager()
        tempLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        tempLocationManager.requestAlwaysAuthorization()
        tempLocationManager.delegate = self
        return tempLocationManager
    }()

    //MARK: -
    //MARK: Class Methods
    class func startUpdatingLocation() {
        LocationManager.sharedInstance.locationManager.startUpdatingLocation()
    }

    class func authorization() -> (isAuthorized:Bool, error:NSError) {
        var error = NSError()
        var isAuthorized = true

        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined) {
            isAuthorized = false
            let userInfo = [NSLocalizedDescriptionKey: Constants.Strings.Error.LocationNotDetermined]
            error = NSError(domain: "", code: 0, userInfo: userInfo)
        }

        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied){
            isAuthorized = false
            let userInfo = [NSLocalizedDescriptionKey: Constants.Strings.Error.LocationDenied]
            error = NSError(domain: "", code: 0, userInfo: userInfo)
        }

        return (isAuthorized, error)
    }

    //MARK: -
    //MARK: Internal Methods
    internal func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        LocationManager.sharedInstance.locationManager.stopUpdatingLocation()

        self.userLocation = locations.first as? CLLocation

        if let location = self.userLocation {
            self.delegate?.locationManager(didUpdateLocation: location)
        } else {
            self.delegate?.locationManager(didFailWithError: nil)
        }

        // set delegate to nil so delegate method locationManager(manager:, didUpdateLocations locations:)
        // is not called twice
        LocationManager.sharedInstance.delegate = nil
    }

    internal func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        self.delegate?.locationManager(didFailWithError: error)
    }

}


