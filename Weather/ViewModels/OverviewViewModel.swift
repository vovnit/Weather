//
//  WeatherModel.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 23/07/2019.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation

struct OverviewViewModel: ViewModel {
    let temp: String
    let humidity: String
    let state: String
    let icon: String
    let date: String
    
    init(temp: String, humidity: String, state: String, icon: String, date: String) {
        self.temp = temp
        self.humidity = humidity
        self.state = state
        self.icon = icon
        self.date = date
    }
    
    static func from(model: Model) -> OverviewViewModel {
        if let weatherModel = model as? WeatherModel {
            return OverviewViewModel.from(weatherModel: weatherModel)
        } else {
            fatalError("Incompatible model passed to 'from' method")
        }
    }
    
    static func from(models: [Model]) -> [OverviewViewModel] {
        if let weatherModels = models as? [WeatherModel] {
            return OverviewViewModel.from(days: weatherModels)
        } else {
            fatalError("Incompatible model passed to 'from' method")
        }
    }
    
    static func from(days: [WeatherModel]) -> [OverviewViewModel] {
        return days.getDays().map { OverviewViewModel.from(weatherModel: $0) }
    }
    
    static func from(weatherModel: WeatherModel) -> OverviewViewModel {
        let date = Date(timeIntervalSince1970: TimeInterval(weatherModel.time))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMMM d"
        
        return OverviewViewModel(
            temp: Degrees.celsiusRepresentation(fromKelvin: weatherModel.temp),
            humidity: "\(weatherModel.humidity)% humidity",
            state: "\(weatherModel.state)",
            icon: "\(weatherModel.icon)",
            date: dateFormatter.string(from: date)
        )
    }
}
