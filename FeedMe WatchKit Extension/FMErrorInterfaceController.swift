//
//  FMErrorInterfaceController.swift
//  FeedMe
//
//  Created by Julio Rivera on 3/29/15.
//  Copyright (c) 2015 Julio Rivera. All rights reserved.
//

import WatchKit
import Foundation

class FMErrorInterfaceController: WKInterfaceController {

    //MARK: -
    //MARK: Outlets
    @IBOutlet weak var errorLabel: WKInterfaceLabel!

    //MARK: -
    //MARK: InterfaceController Lifecycle
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        // Configure interface objects here.
        let error = context as? NSError
        if let description = error?.userInfo?[NSLocalizedDescriptionKey] as? String {
            errorLabel.setText(description)
        }
    }

}