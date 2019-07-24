//
//  ErrorHandlers.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 24.7.19.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import UIKit

func handle(error: Error, onUIContext uiContext: UIViewController) {
    let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
    controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
    uiContext.present(controller, animated: true, completion: nil)
}
