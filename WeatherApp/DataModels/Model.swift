//
//  Model.swift
//  WeatherApp
//
//  Created by Matthew on 28/4/21.
//

import Foundation

struct weatherModel:Decodable {
    var list: [weatherStruct]?
}
struct weatherStruct:Decodable {
    var coord: coordinates?
    var weather: [weather1]?
    var main: main1?
    var id: Int?
    var name: String?
    var wind: wind1?
    var clouds: clouds1?
}
struct coordinates:Decodable {
    var lon: Double?
    var lat: Double?
}
struct weather1:Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}
struct main1:Decodable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidity: Int?
}
struct wind1:Decodable {
    var speed: Double?
    var deg: Int?
}
struct clouds1:Decodable {
    var all: Int?
}
