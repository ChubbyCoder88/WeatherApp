//
//  SearchVC.swift
//  WeatherApp
//
//  Created by Matthew on 30/4/21.
//

import UIKit
import CoreLocation
import MapKit
class SearchVC: UIViewController, UITextViewDelegate, UITextFieldDelegate, MKLocalSearchCompleterDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var SearchWhiteBackground: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var enterCityLabel: UILabel!
    let SearchCellID = "SearchCellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.myTransparentBlack
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCellID)
        self.tableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        searchBar.becomeFirstResponder()
        Cities.maybe = ""
    }

    @IBAction func clearText(_ sender: UIButton) {
        self.searchBar.text = ""
        DispatchQueue.main.async {
            self.dismissModalView()
         }
    }

    // MARK: - SEARCH COMPLETER
    var searchResults = [MKLocalSearchCompletion]()
    var matchingItems:[MKMapItem] = []
    lazy var searchCompleter: MKLocalSearchCompleter = {
        let sC = MKLocalSearchCompleter()
        sC.delegate = self
        return sC
    }()
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            searchCompleter.queryFragment = searchText
        }
    }
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results.filter({ (result) -> Bool in
            if !result.title.contains(",") {
                return false
            } else {
            }
            return true
        })
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - API CALLS
    var data1 = [weatherViewModel]()
    @objc func apiCallCityText(String: String, Lat: String, Long: String) {
        let holidayRequest = CityNameRequest(countryCode: String)
        holidayRequest.callData { [weak self] result in
            switch result {
            case .failure(let error):
                var E = HTTPError()
                DispatchQueue.main.async(execute: {
                    if error == .appearsToBeOffline {
               Alert.show(title: "There was an issue", message: E.errorInternet, vc: self ?? SearchVC())
                    } else {
               Alert.show(title: "There was an issue", message: "Please try again later", vc: self ?? SearchVC())
                        /*CBS   self?.apiCallByGeoLoc(String: String, Lat: Lat, Long: Long) */
                    }
                })
            case .success(let holidays):
                self?.refactorData(data: holidays)
            }
        }
    }
    // MARK: - refactorData
    var clean = CleanData()
    func refactorData(data: weatherStruct) {
        do {
            try clean.refactorFromSearchVCAndInsertIntoViewModel(data: data, completion: { [weak self] (result) in
            switch result {
                case .failure(let error): print("error", error)
                case .success(let data1): self?.data1 = data1;
                    DispatchQueue.main.async {
                        if let cityID = self?.data1[0].id {
                            self?.addCityID(id: cityID)
                        }
                      self?.OpenDetailModally()
                    }
              }})
        } catch { Alert.show(title: "There was an issue", message: "Please try later", vc: self) }
    }
    
    // MARK: - SEGUE
    var modallyIsOff = false
    @objc func OpenDetailModally() {
        modallyIsOff = false
        performSegue(withIdentifier: "ToDetailVC", sender: "none")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailVC" {
            let nextView = segue.destination as! DetailedViewVC
                nextView.data1 = data1
                nextView.modallyIsOff = modallyIsOff
            }
        }
    @objc func addCityID(id: Int) {
        var cityID = String(id)
        Cities.maybe += "," + cityID
    }
    @objc func dismissModalView() {
        Cities.maybe = ""
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
        }
    }
}



extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: - cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCellID, for: indexPath) as! SearchCell
            var searchResult = searchResults[indexPath.row]
            cell.searchLabel.text = searchResult.title
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.myTransparentBlack
            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completion = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
            search.start { (response, error) in
        let coordinate = response?.mapItems[0].placemark.coordinate
                if let lat2 = coordinate?.latitude  {
                    if let long2 = coordinate?.longitude {
                        if let title = response?.mapItems[0].name {
                            var lat = String(lat2)
                            var long = String(long2)
                            if title.contains(" ") {
                                let replaced = title.replacingOccurrences(of: " ", with: "%20")
                                self.apiCallCityText(String: replaced, Lat: lat, Long: long)
                            } else {
                                self.apiCallCityText(String: title, Lat: lat, Long: long)
                            }
                        }
                    }
                }
            }
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


