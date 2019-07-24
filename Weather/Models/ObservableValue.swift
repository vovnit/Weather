//
// Created by Vladimir Nitochkin on 2019-07-23.
// Copyright (c) 2019 Vladimir Nitochkin. All rights reserved.
//

import Foundation

class ObservableValue<T> {

    typealias CompletionHandler = ((T) -> Void)

    var value: T {
        didSet {
            self.notify()
        }
    }

    var observers = [String: CompletionHandler]()

    init(_ value: T) {
        self.value = value
    }

    public func add(observer: NSObject, onComplete completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }

    public func addAndNotify(observer: NSObject, onComplete completionHandler: @escaping CompletionHandler) {
        self.add(observer: observer, onComplete: completionHandler)
        self.notify()
    }

    private func notify() {
        observers.forEach({ observer in observer.value(value) })
    }

    deinit {
        observers.removeAll()
    }
}
