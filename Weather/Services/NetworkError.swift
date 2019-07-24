//
//  NetworkError.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 23/07/2019.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation

typealias ErrorHandler = (NetworkError)->()

enum NetworkError : Error {
    case NetworkNil(String)
    case NetworkProcessError(String)
}
