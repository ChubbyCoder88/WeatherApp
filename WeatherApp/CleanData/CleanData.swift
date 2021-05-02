//
//  CleanData.swift
//  WeatherApp
//
//  Created by Matthew on 29/4/21.
//

import Foundation
import UIKit
struct CleanData {
     
     func refactorAndInsertIntoViewModel(data: weatherModel, completion: @escaping(Result<[weatherViewModel], DataError>) -> Void) throws {
        var traData = [weatherViewModel]()

        if let weather = data.list {
            for a in weather {
                var temp = ""
                if let tempA = a.main?.temp {
                    var tempString = String(format: "%.0f", tempA) + "°"
                    temp = tempString
                }
                
                var tempWithout0 = ""
                if let tempWithout0A = a.main?.temp {
                    var tempString = String(format: "%.0f", tempWithout0A)
                    tempWithout0 = tempString
                }
                
                var main = ""
                if let mainA = a.weather?[0].main {
                    main = mainA
                }
 
                var humidity = ""
                if let humidityA = a.main?.humidity {
                    humidity = "Humidity: " + String(humidityA)
                }
                
                var pressure = ""
                if let pressureA = a.main?.humidity {
                    pressure = "Pressure: " + String(pressureA)
                }

                var min = ""
                if let minA = a.main?.temp_min { if let maxA = a.main?.temp_max {
                    min = "L:" + String(format: "%.0f", minA) + "°" + " H:" + String(format: "%.0f", maxA) + "°"
                }}
                
                var input = weatherViewModel(id: a.id, name: a.name, temp: temp, tempWithout0: tempWithout0, description: a.weather?[0].description, min: min, max: a.main?.temp_max, main: main, pressure: pressure, humidity: humidity)
                traData.append(input)
            }
        } else { throw DataError.noDataAvailable }
        
        if traData.count < 1 { throw DataError.noDataAvailable }
        completion(.success(traData))
        traData = []
    }
    
    
    func refactorFromSearchVCAndInsertIntoViewModel(data: weatherStruct, completion: @escaping(Result<[weatherViewModel], DataError>) -> Void) throws {
       var traData = [weatherViewModel]()
                var a = data
                var temp = ""
                if let tempA = data.main?.temp {
                    var tempString = String(format: "%.0f", tempA) + "°"
                    temp = tempString
                }
               
                var tempWithout0 = ""
                if let tempWithout0A = a.main?.temp {
                    var tempString = String(format: "%.0f", tempWithout0A)
                    tempWithout0 = tempString
                }
        
                var main = ""
                if let mainA = a.weather?[0].main {
                    main = mainA
                }
        
                var humidity = ""
                if let humidityA = a.main?.humidity {
                    humidity = "Humidity: " + String(humidityA)
                }
                
                var pressure = ""
                if let pressureA = a.main?.humidity {
                    pressure = "Pressure: " + String(pressureA)
                }
                
                var min = ""
                if let minA = a.main?.temp_min { if let maxA = a.main?.temp_max {
                    min = "L:" + String(format: "%.0f", minA) + "°" + " H:" + String(format: "%.0f", maxA) + "°"
                }}

               var input = weatherViewModel(id: a.id, name: a.name, temp: temp, tempWithout0: tempWithout0, description: a.weather?[0].description, min: min, max: a.main?.temp_max, main: main, pressure: pressure, humidity: humidity)
               traData.append(input)
 
       if traData.count < 1 { throw DataError.noDataAvailable }
       completion(.success(traData))
       traData = []
   }
    
}

 
