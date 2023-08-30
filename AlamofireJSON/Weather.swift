//
//  Weather.swift
//  AlamofireJSON
//
//  Created by Tony Chen on 16/12/2022.
//

// JSON Mapping

import Foundation

struct CurrentWeather: Decodable {
    var weather: [Weather]
    var main: weatherData
    var name = "name"
}

struct Weather: Decodable {
    var weatherId: Int
    var weatherName: String?
    var weatherDescription: String?
    var weatherIcon: String?
    
    enum CodingKeys: String, CodingKey {
        case weatherId = "id"
        case weatherName = "main"
        case weatherDescription = "description"
        case weatherIcon = "icon"
    }
}

struct weatherData: Decodable {
    var temp: Double?
    var humidity: Double?
    var tempMax: Double?
    var tempMin: Double?
    
    enum CodingKeys: String, CodingKey{
        case temp
        case humidity
        case tempMax = "temp_max"
        case tempMin = "temp_min"
   }
}

//struct name: Decodable {
//    var name: String?
//
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//    }
//}
