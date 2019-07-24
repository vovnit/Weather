//
// Created by Vladimir Nitochkin on 2019-07-23.
// Copyright (c) 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation

protocol ViewModel {
    static func from(model: Model) -> Self
    static func from(models: [Model]) -> [Self]
}
