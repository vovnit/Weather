//
//  NSCountedSet-extension.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 23/07/2019.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation

extension NSCountedSet {
    func maxCount() -> String {
        return self.max { self.count(for: $0) < self.count(for: $1) } as! String
    }
}
