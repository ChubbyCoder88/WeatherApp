//
//  DetialedViewVC.swift
//  WeatherApp
//
//  Created by Matthew on 30/4/21.
//

import UIKit
import CoreData

class DetailedViewVC: UIViewController {
    let detailCellID = "detailCellID"
    var modallyIsOff = true
    var data1 = [weatherViewModel]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailedViewCell.self, forCellReuseIdentifier: detailCellID)
        tableView.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = UIColor.myTransparentBlack
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        view.backgroundColor = UIColor.myTransparentBlack
    }
    
    @objc func addCity() {
        var cityID = Cities.maybe
        Cities.added += cityID
        Cities.maybe = ""
        CoreData().insertCoreData(String: Cities.added)
        data1 = []
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
            })
    }
    @objc func cancelCity() {
        Cities.maybe = ""
        data1 = []
        dismiss(animated: true) {
        }
    }
}
 
extension DetailedViewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var info = data1[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCellID, for: indexPath) as! DetailedViewCell
        cell.detailTable = self
        cell.cityNameLabel.text = info.name
        cell.descriptionLabel.text = info.description
        cell.tempLabel.text = info.tempWithout0
        cell.lowLabel.text = info.min
        cell.AddButton.isHidden = modallyIsOff
        cell.CancelButton.isHidden = modallyIsOff
        cell.weatherImage.image = UIImage(named: info.main)
        cell.humidityLabel.text = info.humidity
        cell.pressureLabel.text = info.pressure
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data1.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 830
    }
}
