//
//  Place.swift
//  d05
//
//  Created by Kai LIN on 3/26/19.
//  Copyright © 2019 Kai LIN. All rights reserved.
//

import Foundation
import CoreLocation

struct Data {
    static let place : [(String, CLLocation, String)] = [
    ("42", CLLocation(latitude: 48.896652, longitude: 2.3183559999999943), "Super Ecole 42"),
    ("Piscine", CLLocation(latitude: 48.8944401, longitude: 2.3187041999999565), "Piscine Bernard Lafay"),
    ("Tour eiffel", CLLocation(latitude: 48.85837009999999, longitude: 2.2944813000000295), "Tour de fer"),
    ("Colisée", CLLocation(latitude: 41.8902102, longitude: 12.492230899999981), "Amphithéâtre Flavien"),
    ("Statue de la Liberté", CLLocation(latitude: 40.6892494, longitude: -74.0445004), "La Liberté éclairant le monde"),
    ]
}
