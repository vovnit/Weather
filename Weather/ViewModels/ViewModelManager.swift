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
    
    func fetchOverviews(network: Network, errorHandler: ErrorHandler? = nil) {
        network.doRequest {(results, error) in
            if !error.isEmpty {
                errorHandler?(.NetworkProcessError(error))
            }
            if let results = results {
                self.observableValue.value = T.from(models: results)
            }
        }
    }
}
