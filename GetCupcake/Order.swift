//
//  Order.swift
//  GetCupcake
//
//  Created by Viktor Yamchinov on 15/01/2019.
//  Copyright © 2019 Viktor Yamchinov. All rights reserved.
//

import Foundation

struct Order: Codable, Hashable {
    var cake: Product
    var toppings: Set<Product>
    
    var name: String {
        // if we have no toppings just send back the name
        if toppings.count == 0 {
            return cake.name
        } else {
            // we have toppings, so lowercase and join them all so they look better
            let toppingNames = toppings.map {
                $0.name.lowercased()
            }
            return "\(cake.name), \(toppingNames.joined(separator: ", "))"
        }
    }
    
    var price: Int {
        return toppings.reduce(cake.price) { $0 + $1.price}
    }
    
    var intent: OrderIntent {
        let intent = OrderIntent()
        intent.cakeName = cake.name
        intent.toppings = toppings.map { $0.name.lowercased()}
        intent.suggestedInvocationPhrase = "Give me a \(cake.name) cupcake or give me a death!"
        return intent
    }
}

extension Order {
    init?(from data: Data?) {
        guard let data = data else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let savedOrder = try? decoder.decode(Order.self, from: data) else {
            return nil
        }
        cake = savedOrder.cake
        toppings = savedOrder.toppings
    }
    
    init?(from intent: OrderIntent) {
        // if we can't find a cake name - exit
        guard let cake = Menu.shared.findCake(from: intent.cakeName) else {
            return nil
        }
        // convert the toppings array to array of topping products, discarding any that don't exist
        guard let toppings = intent.toppings?.compactMap({Menu.shared.findTopping(from: $0)}) else {
            return nil
        }
        // both properties loaded successfully, so create the object
        self.cake = cake
        self.toppings = Set(toppings)
    }
}
