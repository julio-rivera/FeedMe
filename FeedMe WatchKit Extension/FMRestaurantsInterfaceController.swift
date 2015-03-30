//
//  FMRestaurantsInterfaceController.swift
//  FeedMe
//
//  Created by Julio Rivera on 3/4/15.
//  Copyright (c) 2015 Julio Rivera. All rights reserved.
//

import WatchKit
import Foundation

class FMRestaurantsInterfaceController: WKInterfaceController {

    //MARK: -
    //MARK: Outlets & Variables
    @IBOutlet weak private var restaurantsTable: WKInterfaceTable!

    private var restaurants:Array<FMRestaurant>?

    //MARK: -
    //MARK: InterfaceController Lifecycle
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let restaurants = context as? Array<FMRestaurant>{
            self.restaurants = restaurants
            self.configureTableWithRestaurants(restaurants)
        }
    }

    //MARK: -
    //MARK: Private Methods
    private func configureTableWithRestaurants(restaurants:Array<FMRestaurant>?) {
        // define the number of rows for the table displaying restaurant information
        self.restaurantsTable.setNumberOfRows(restaurants!.count, withRowType: "FMRestaurantRowController")

        // for each row, provide FMRestaurantRowController its model object
        // so it can display the restaurant information appropriately
        for (var i = 0 ; i < self.restaurantsTable.numberOfRows; i++){
            var row = self.restaurantsTable.rowControllerAtIndex(i) as! FMRestaurantRowController
            if let restaurant = self.restaurants?[i]  {
                row.restaurant = restaurant
            }
        }
    }

}
