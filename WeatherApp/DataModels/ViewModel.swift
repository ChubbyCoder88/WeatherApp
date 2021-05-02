//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Matthew on 28/4/21.
//

import Foundation

struct weatherViewModel:Decodable {
    var id: Int?
    var name: String?
    var temp: String?
    var tempWithout0: String?
    var description: String?
    var min: String?
    var max: Double?
    var main: String
    var pressure: String?
    var humidity: String?
}

