//
//  Degrees.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 24/07/2019.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation

struct Degrees {
    static func convertToCelsius(fromKelvin kelvin: Double) -> Double {
        return kelvin - 273.15
    }
    
    private static func prefix(for degrees: Double) -> String {
        return degrees.isLess(than: 0) ? "" : "+"
    }
    
    static func representation(fromCelsius celsius: Double) -> String {
        let number = String(format: "%.1f˚C", celsius)
        return "\(prefix(for: celsius))\(number)"
    }
    
    static func celsiusRepresentation(fromKelvin kelvin: Double) -> String {
        return representation(fromCelsius: convertToCelsius(fromKelvin: kelvin))
    }
}
