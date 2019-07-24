//
//  WeatherModel.swift
//
//  Created by Vladimir Nitochkin on 23/07/2019.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation

struct WeatherModel: Model {
    let temp: Double
    let pressure: Double
    let humidity: Int
    let state: String
    let icon: String
    let timeStr: String
    let time: Int
    
    static func aggregate(weatherModels: [WeatherModel]) -> WeatherModel {
        let error = WeatherModel(temp: 0, pressure: 0, humidity: 0, state: "ERR", icon: "ERR", timeStr: "ERR", time: 0)
        guard weatherModels.count > 0 else {
            return error
        }
        return weatherModels.first(where: { $0.timeStr.contains("15:00:00") }) ?? WeatherModel.aggregateAverage(weatherModels: weatherModels)
    }
    
    static func aggregateAverage(weatherModels: [WeatherModel]) -> WeatherModel {
        guard weatherModels.count > 0 else {
            return WeatherModel(temp: 0, pressure: 0, humidity: 0, state: "ERR", icon: "ERR", timeStr: "ERR", time: 0)
        }
        var sumTemp: Double = 0
        var sumPressure: Double = 0
        var sumHumidity: Int = 0
        let state = NSCountedSet()
        let icon = NSCountedSet()

        for details in weatherModels {
            sumTemp += details.temp
            sumHumidity += details.humidity
            sumPressure += details.pressure
            state.add(details.state)
            icon.add(details.icon)
        }

        return WeatherModel(
            temp: sumTemp / Double(weatherModels.count),
            pressure: sumPressure / Double(weatherModels.count),
            humidity: sumHumidity / weatherModels.count,
            state: state.maxCount(),
            icon: icon.maxCount(),
            timeStr: weatherModels.first?.timeStr ?? "ERR",
            time: weatherModels.first?.time ?? 0
        )
    }
}
