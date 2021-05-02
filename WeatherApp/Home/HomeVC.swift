//
//  HomeVC.swift
//  WeatherApp
//
//  Created by Matthew on 27/4/21.
//

import UIKit
import Combine
import Foundation
import CoreData

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var clean = CleanData()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        navigationController?.navigationBar.barTintColor = UIColor.myTransparentBlack
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        Cities.secretKey = "b1c37ad2fe6c5b38f09e404fd5c21e5c"
        NotificationCenter.default.addObserver(self, selector: #selector(HomeVC.modalDismissed), name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
        updateEvery5Minutes()
        getCoreData()
    }
    @objc func updateEvery5Minutes() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 300) {
            self.dataApiCall()
            self.updateEvery5Minutes()
        }
    }
    @objc func modalDismissed() {
        dataApiCall()
        DispatchQueue.main.async { self.tableView.reloadData() }
     }
    
    private var usersSubscriper: AnyCancellable?
    private var wData = [weatherViewModel]()
    private var wData2 = [weatherViewModel]()
    @objc func doNothing() {}
    private func dataApiCall() {
        usersSubscriper = DataManager().usersPublisher
            .sink(receiveCompletion: { [weak self] finished in
                switch finished {
                case .failure(_): Alert.show(title: "There was an issue", message: "Please try later", vc: self ?? HomeVC())
                case .finished: print("finished")
                }
             }, receiveValue: { [weak self] (data) in
                self?.refactorData(data: data)
             })
    }
    func refactorData(data: weatherModel) {
        do {
            try clean.refactorAndInsertIntoViewModel(data: data, completion: { [weak self] (result) in
            switch result {
                case .failure(let error): print("error", error)
                case .success(let data1): self?.wData = data1;
                    DispatchQueue.main.async {
                        self?.tableView.reloadData();
                        self?.tableView.tableFooterView = UIView()
                    }
              }})
        } catch { Alert.show(title: "There was an issue", message: "Please try later", vc: self) }
    }
    var modallyIsOff = false
    var core = CoreData()
    @objc func getCoreData() {
        do {
            try core.checkIfCoreDataExists(completion: { [weak self] (result) in
            switch result {
                case .failure(let error): print("error", error)
                case .success(let data1): print("data1", data1)
                    DispatchQueue.main.async {
                        self?.dataApiCall()
                    }
              }})
        } catch { inputSingleCoreDataCauseThereIsNone() }
    }
    @objc func inputSingleCoreDataCauseThereIsNone() {
        Cities.added = "2147714,4163971,2174003"
        dataApiCall()
        CoreData().insertCoreData(String: Cities.added)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        var info = wData[indexPath.row]
        cell.cityNameLabel.text = info.name
        cell.tempLabel.text = info.temp
        cell.weatherImage.image = UIImage(named: info.main)  
        cell.selectionStyle = .none
        return cell
     }
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var input = wData[indexPath.row]
        wData2 = []
        wData2.append(input)
        modallyIsOff = true
        performSegue(withIdentifier: "ToDetailVCFromHomeVC", sender: indexPath)
      }
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailVCFromHomeVC" {
            let nextView = segue.destination as! DetailedViewVC
                nextView.data1 = wData2
                nextView.modallyIsOff = modallyIsOff
            }
        }
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wData.count
      }
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
      }
}
