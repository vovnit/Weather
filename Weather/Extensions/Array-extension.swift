//
//  Array-extension.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 24.7.19.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation

extension Array where Element == WeatherModel {
    func getDays() -> [WeatherModel] {
        var days: [[WeatherModel]] = [[]]
        var sliceIt = 0
        for i in 0..<self.count {
            days[sliceIt].append(self[i])
            if self[i].timeStr.contains("00:00:00") && i > 0 && i < self.count - 1 {
                days.append([])
                sliceIt += 1
            }
        }
        return days.map { WeatherModel.aggregate(weatherModels: $0) }
    }
}

extension Array where Element == DetailedViewModel {
    func getDay(number: Int) -> [DetailedViewModel] {
        var days: [[DetailedViewModel]] = [[]]
        var sliceIt = 0
        for i in 0..<self.count {if self[i].timeStr.contains("00:00:00") {
            if sliceIt == number {
                return days[number]
            }
            days.append([])
            sliceIt += 1
            }
            days[sliceIt].append(self[i])
        }
        fatalError("Somehow requirement times weren't found")
    }
}
