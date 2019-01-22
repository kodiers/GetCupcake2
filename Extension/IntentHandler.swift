//
//  IntentHandler.swift
//  Extension
//
//  Created by Viktor Yamchinov on 18/01/2019.
//  Copyright © 2019 Viktor Yamchinov. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension, OrderIntentHandling {
    func handle(intent: OrderIntent, completion: @escaping (OrderIntentResponse) -> Void) {
        // attempt to create an Order from this intent or exit with teh failure
        guard let order = Order(from: intent) else {
            completion(OrderIntentResponse(code: .failure, userActivity: nil))
            return
        }
        // if we have a valid Order, send back success
        let response = OrderIntentResponse(code: .success, userActivity: nil)
        // give Siri a cake name to put into our placeholder string
        response.cakeName = intent.cakeName
        // create a reasonable preparation time for the placeholder string
        response.preparationTime = NSNumber(value: 5 + order.toppings.count)
        // tell Siri confirm the order
        completion(response)
    }
    
    func confirm(intent: OrderIntent, completion: @escaping (OrderIntentResponse) -> Void) {
        let response = OrderIntentResponse(code: .ready, userActivity: nil)
        completion(response)
    }
    
    
}
