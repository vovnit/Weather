//
//  ViewModelManager.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 24.7.19.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation

struct ViewModelManager<T: ViewModel> {
    
    var observableValue: ObservableValue<[T]> = ObservableValue<[T]>([])
    
    func fetchCached(network: Network) {
        observableValue.value = T.from(models: network.result)
    }
    
    func fetchOverviews(network: Network, errorHandler: ErrorHandler? = nil, callback: (()->())? = nil) {
        network.doRequest {(results, error) in
            if !error.isEmpty && !error.contains("cancelled") {
                errorHandler?(.NetworkProcessError(error))
            }
            if let results = results, results.count > 0 {
                self.observableValue.value = T.from(models: results)
            }
            callback?()
        }
    }
}
