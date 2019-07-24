//
//  OverviewTableViewController.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 23/07/2019.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import UIKit

class OverviewTableViewController: UITableViewController {

    var viewModelManager = ViewModelManager<OverviewViewModel>()
    var network: Network = Network()
    var overviews: [OverviewViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @objc func refresh()
    {
        viewModelManager.fetchOverviews(network: network, errorHandler: {[weak self] error in
            guard let context = self else {
                return
            }
            handle(error: error, onUIContext: context)
            }, callback: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        viewModelManager.observableValue.add(observer: self) {[weak self] results in
            self?.overviews = results
        }
        refresh()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return overviews.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func getDay(bySection section: Int) -> String {
        if section == 0 {
            return "Today"
        } else if section == 1 {
            return "Tomorrow"
        } else {
            return overviews[section].date
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getDay(bySection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        guard let overviewCell = cell as? OverviewViewCell else {
            fatalError("Unknown cell type! Should be OverviewViewCell.")
        }
        
        let data = overviews[indexPath.section]
        
        overviewCell.picture.image = UIImage(named: data.icon)
        overviewCell.temperatureLabel.text = data.temp
        overviewCell.stateLabel.text = data.state
        overviewCell.humidityLabel.text = data.humidity
        
        return overviewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedViewController: DetailedViewController = UIStoryboard(name: "Overview", bundle: nil).instantiateViewController(withIdentifier: "Details") as! DetailedViewController
        detailedViewController.dayNum = indexPath.section
        detailedViewController.network = network
        detailedViewController.dayName = getDay(bySection: indexPath.section)
        navigationController?.pushViewController(detailedViewController, animated: true)
    }
}
