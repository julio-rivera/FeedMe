//
//  FMRestaurant.swift
//  FeedMe
//
//  Created by Julio Rivera on 3/6/15.
//  Copyright (c) 2015 Julio Rivera. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class FMRestaurant : NSObject {
    // restrict setter access to within this class
    private(set) var name:String?
    private(set) var phoneNumber:String?
    private(set) var websiteURL:NSURL?
    private(set) var coordinate:CLLocationCoordinate2D?
    private(set) var distance:String?

    init(mapItem:MKMapItem?, location:CLLocation?) {
        if let item = mapItem {
            self.name           = item.name
            self.coordinate     = item.placemark?.coordinate
            self.phoneNumber    = item.phoneNumber
            self.websiteURL     = item.url

            if let distance = location?.distanceFromLocation(mapItem?.placemark.location) {
                self.distance = String(format:"%.2f mi", distance/Constants.Floats.MetersToMiles)
            }
        }

    }
}
