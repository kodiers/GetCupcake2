//
//  Product.swift
//  GetCupcake
//
//  Created by Viktor Yamchinov on 11/01/2019.
//  Copyright © 2019 Viktor Yamchinov. All rights reserved.
//

import Foundation

struct Product: Codable, Hashable {
    var name: String
    var description: String
    var price: Int
}
