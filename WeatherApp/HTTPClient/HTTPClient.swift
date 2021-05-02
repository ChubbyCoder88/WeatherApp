//
//  HTTPClient.swift
//  WeatherApp
//
//  Created by Matthew on 28/4/21.
//

import Foundation
import Combine

struct Cities {
    static var added = String()
    static var maybe = String()
    static var secretKey = String()
}

// CALL FROM HomeVC   (COMBINE)
class DataManager {
    private let urlString = "http://api.openweathermap.org/data/2.5/group?id=\(Cities.added)&units=metric&APPID=\(Cities.secretKey)"
    var usersPublisher: AnyPublisher<weatherModel, Error> {
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: weatherModel.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        }
    }


// CALL FROM SearchVC (NORMAL API CALL)
class CityNameRequest: NSObject {
let resourceURL:URL
let API_KEY = ""
var location = Cities.added
var key = Cities.secretKey
init(countryCode: String) {
   var res = "http://api.openweathermap.org/data/2.5/weather?q=\(countryCode)&units=metric&appid=\(Cities.secretKey)"
   guard let resourceUR2L = URL(string: res) else {fatalError()}
   self.resourceURL = resourceUR2L
}
func callData (completion: @escaping(Result<weatherStruct, APIError>) -> Void ) {
 var request = URLRequest(url: resourceURL)
     request.httpMethod = "GET"
   let session = URLSession.shared
   let task = session.dataTask(with: request) { (data, urlRes, err) in
       if err != nil {
           var desc = err?.localizedDescription
           if let desc = desc {
               if desc == "The Internet connection appears to be offline." {
                   completion(.failure(.appearsToBeOffline))
                   return
               } else {
                   completion(.failure(.resultOther))
                   return
               }
           }
       }
// HANDLING URL ERR
                   if let httpResponse = urlRes as? HTTPURLResponse {
                       var code = httpResponse.statusCode
                       if code == 401 {
                           completion(.failure(.result401))
                           return
                       } else if code == 403 {
                           completion(.failure(.result403))
                           return
                       } else if code == 404 {
                           completion(.failure(.result404))
                           return
                       } else if code == 406 {
                           completion(.failure(.result406))
                           return
                       } else if code == 409 {
                           completion(.failure(.result409))
                           return
                       } else if code == 500 {
                           completion(.failure(.result500))
                           return
                       } else if code == 200 {
                           
                       } else if code == 203 {
                          completion(.failure(.result203))
                           return
                       }
                   }
       
            guard let jsonData = data else {
                        completion(.failure(.noDataAvailable))
                        return
                    }
                    do {
                       let decoder = JSONDecoder()
                       let holidaysResponse = try decoder.decode(weatherStruct.self, from: jsonData)
                       let holidayDetails2 = holidaysResponse
                       completion(.success(holidayDetails2))
                    } catch {
                       completion(.failure(.canNotProcessData))
                    }
            }
            task.resume()
   }
}




enum DataError:Error {
    case noDataAvailable
}
enum ValidationError: LocalizedError {
    case invalidValue
}
enum APIError:Error {
    case noDataAvailable
    case canNotProcessData
    case appearsToBeOffline
    case result401
    case result403
    case result404
    case result406
    case result409
    case result200
    case result203
    case result500
    case resultOther
}
struct HTTPError {
    var errorInternet = "Please check your internet connection. \n It appears to be offline"
    var error401 = "There are issues loading this content. Please try again later"
    var error403 = "We're having issues loading this content. Please try again later"
    var error404 = "We are having issues loading this content. Please try again later"
    var error406 = "We are having difficulties loading this content. Please try again later"
    var error409 = "The loading of this content is experiencing difficulties. Please try again later"
    var error203 = "This content was unable to load. Please try again later"
    var error500 = "There are issues loading this content. Please try this page again later"
    var errorCanNotProcessData = "We are having issues loading this content. Please try this page again later"
    var errorNoDataAvailable = "We are having issues loading this page. Please try again later"
    var errorResultOther = "We are having issues loading this page. Please try reloading later"
    var errorElse = "We are experiencing issues loading this content. Please try again later"
}
 
