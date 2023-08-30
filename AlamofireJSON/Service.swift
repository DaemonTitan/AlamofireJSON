//
//  Service.swift
//  AlamofireJSON
//
//  Created by Tony Chen on 15/12/2022.
//

import Foundation
import Alamofire

class Services {
    
    func getData(lat: Double, lon: Double, apiKey: String, completion: @escaping (CurrentWeather)->(Void) ) {

        let baseURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        
        AF.request(baseURL,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: nil,
                   interceptor: nil
        ).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let weatherJson = try JSONDecoder().decode(CurrentWeather.self, from: data!)
                    completion(weatherJson)
                    let name = weatherJson.name
                    print(name)
                }catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
