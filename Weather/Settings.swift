//
//  Settings.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 23/07/2019.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation

struct Settings {
    static let token = "<changeit>"
    static let url = "https://api.openweathermap.org/data/2.5/forecast"
    static let query = "id=524901&APPID=\(token)"
}
