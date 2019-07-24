//
//  DetailTableViewController.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 24.7.19.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import UIKit

class DetailedViewController: UITableViewController {
    
    var viewModelManager = ViewModelManager<DetailedViewModel>()
    var network: Network?
    public var dayNum = 0
    var details: [DetailedViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        viewModelManager.observableValue.add(observer: self) {[weak self] results in
            self?.details = results.getDay(number: self?.dayNum ?? 0)
        }
        if let network = network {
            viewModelManager.fetchCached(network: network)
        } else {
            self.network = Network()
            viewModelManager.fetchOverviews(network: network!, errorHandler: {[weak self] error in
                guard let context = self else {
                    return
                }
                handle(error: error, onUIContext: context)
            })
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return details.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return details[section].timeStr
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        guard let overviewCell = cell as? OverviewViewCell else {
            fatalError("Unknown cell type! Should be OverviewViewCell.")
        }
        
        let data = details[indexPath.section]
        
        overviewCell.picture.image = UIImage(named: data.icon)
        overviewCell.temperatureLabel.text = data.temp
        overviewCell.stateLabel.text = data.state
        overviewCell.humidityLabel.text = data.humidity
        
        return overviewCell
    }
}
