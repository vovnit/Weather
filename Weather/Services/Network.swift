//
//  Network.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 23/07/2019.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation
import SwiftyJSON

class Network {
    let defaultSession = URLSession(configuration: .default)
    var errorMessage: String = ""
    var dataTask: URLSessionDataTask?
    var result: [WeatherModel] = []
    
    fileprivate func updateResults(_ data: Data) {
        var response: JSON
        result.removeAll()
        
        do {
            response = try JSON(data: data)
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        let array = response["list"]
        guard array.count > 0 else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        for i in 0..<array.count {
            result.append(WeatherModel(
                temp: array[i]["main"]["temp"].doubleValue,
                pressure: array[i]["main"]["pressure"].doubleValue,
                humidity: array[i]["main"]["humidity"].intValue,
                state: array[i]["weather"][0]["main"].stringValue,
                icon: array[i]["weather"][0]["icon"].stringValue,
                timeStr: array[i]["dt_txt"].stringValue,
                time: array[i]["dt"].intValue))
        }
    }
    
    func doRequest(completion: @escaping ([WeatherModel]?, String)->()) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: Settings.url) {
            urlComponents.query = Settings.query
            guard let url = urlComponents.url else { return }
            self.dataTask = self.defaultSession.dataTask(with: url) {[weak self] data, response, error in
                defer { self?.dataTask = nil }
                if let error = error {
                    self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self?.updateResults(data)
                    DispatchQueue.main.async {
                        if let result = self?.result, let errorMessage = self?.errorMessage {
                            completion(result, errorMessage)
                        }
                    }
                }
            }
            dataTask?.resume()
        }
    }
}
