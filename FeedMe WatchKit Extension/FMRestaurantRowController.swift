//
//  FMRestaurantRowController.swift
//  FeedMe
//
//  Created by Julio Rivera on 3/4/15.
//  Copyright (c) 2015 Julio Rivera. All rights reserved.
//

import Foundation
import WatchKit

class FMRestaurantRowController : NSObject {

    //MARK: -
    //MARK: Outlets & Variables
    @IBOutlet weak private var nameLabel: WKInterfaceLabel!
    @IBOutlet weak private var distanceLabel: WKInterfaceLabel!

    var restaurant: FMRestaurant? {
        didSet {
            nameLabel.setText(restaurant?.name)
            distanceLabel.setText(restaurant?.distance)
        }
    }
    
}
