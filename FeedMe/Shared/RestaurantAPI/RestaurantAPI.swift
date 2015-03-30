//
//  YelpAPI.swift
//  FeedMe
//
//  Created by Julio Rivera on 3/7/15.
//  Copyright (c) 2015 Julio Rivera. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class RestaurantAPI : NSObject {

    class var sharedInstance: RestaurantAPI{
        struct Singleton {
            static let instance = RestaurantAPI()
        }
        return Singleton.instance
    }

    class func restaurantsNearLocation(location: CLLocation?,
        completion:((Array<FMRestaurant>?, NSError?) -> Void)!) {

            // create initial MKLocalSearchRequest with query of Restaurants
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = "Restaurants"

            // set region of MKLocalSearchRequest to be
            // 15 miles (lat and lon) from the user's location
            let miles = 10.0
            if let loc = location {
                let coordinate = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude)
                let region = MKCoordinateRegionMakeWithDistance(coordinate, miles * Constants.Floats.MetersToMiles,
                    miles * Constants.Floats.MetersToMiles)
                request.region = region

                // intiate search and return array of FMRestaurant in completion closure
                let search = MKLocalSearch(request: request)
                search.startWithCompletionHandler { (response, error) in
                    if ((error) != nil){
                        completion(nil, error)
                    } else {
                        var restaurantArray = Array<FMRestaurant>()
                        for item in response.mapItems as! Array<MKMapItem>{
                            var restaurant = FMRestaurant(mapItem: item, location:location )
                            restaurantArray.append(restaurant)
                        }
                        completion(restaurantArray, nil)
                    }
                }
            }
        }
}