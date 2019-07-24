//
// Created by Vladimir Nitochkin on 2019-07-23.
// Copyright (c) 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation

struct DetailedViewModel: ViewModel {
    let temp: String
    let pressure: String
    let humidity: String
    let state: String
    let icon: String
    let timeStr: String

    static func from(model: Model) -> DetailedViewModel {
        if let weatherModel = model as? WeatherModel {
            return DetailedViewModel.from(weatherModel: weatherModel)
        } else {
            fatalError("Incompatible model passed to 'from' method")
        }
    }
    
    static func from(models: [Model]) -> [DetailedViewModel] {
        if let weatherModels = models as? [WeatherModel] {
            return weatherModels.map { DetailedViewModel.from(weatherModel: $0) }
        } else {
            fatalError("Incompatible model passed to 'from' method")
        }
    }
    
    static func from(weatherModel: WeatherModel) -> DetailedViewModel {
        return DetailedViewModel(
            temp: Degrees.celsiusRepresentation(fromKelvin: weatherModel.temp),
            pressure: "\(weatherModel.pressure)",
            humidity: "\(weatherModel.humidity)% humidity",
            state: "\(weatherModel.state)",
            icon: "\(weatherModel.icon)",
            timeStr: "\(weatherModel.timeStr.split(separator: " ").last ?? "ERR")"

        )
    }
}
