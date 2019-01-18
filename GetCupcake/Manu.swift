//
//  Manu.swift
//  GetCupcake
//
//  Created by Viktor Yamchinov on 18/01/2019.
//  Copyright © 2019 Viktor Yamchinov. All rights reserved.
//

import Foundation

class Menu {
    var cakes: [Product]
    var toppings: [Product]
    
    static let shared = Menu()
    
    private init() {
        cakes = Bundle.main.decode(from: "cupcakes.json")
        toppings = Bundle.main.decode(from: "toppings.json")
    }
    
    func findCake(from name: String?) -> Product? {
        return cakes.first { $0.name == name }
    }
    
    func findTopping(from name: String?) -> Product? {
        return toppings.first { $0.name.lowercased() == name }
    }
}


extension Bundle {
    func decode(from filename: String) -> [Product] {
        guard let json = url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in app bundle.")
        }
        guard let jsonData = try? Data(contentsOf: json) else {
            fatalError("Failed to load \(filename) in app bundle.")
        }
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode([Product].self, from: jsonData) else {
            fatalError("Failed to decode \(filename) in app bundle.")
        }
        return result.sorted {
            return $0.name < $1.name
        }
    }
}
