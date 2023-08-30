//
//  ViewController.swift
//  AlamofireJSON
//
//  Created by Tony Chen on 14/12/2022.
//

import UIKit
import SkeletonView
import CoreLocation
import Lottie
import SwiftyGif

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var weatherNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: LottieAnimationView!
      
    
    
    
    let apiKey = "ac641c216f7d0d0abae797bade643f8c"
    var service = Services()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else {return}
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            service.getData(lat: latitude, lon: longitude, apiKey: apiKey) { (CurrentWeather) in

                DispatchQueue.main.async {
                    let currentWeather = CurrentWeather

                    self.weatherNameLabel.stopSkeletonAnimation()
                    self.weatherNameLabel.hideSkeleton()
                    let weatherName = currentWeather.weather[0].weatherDescription
                    self.weatherNameLabel.text = "\(weatherName!.capitalized)"

                    let temperature = currentWeather.main.temp
                    self.temperatureLabel.text = "\(Int(round(temperature!))) ℃"

                    let humidity = currentWeather.main.humidity
                    self.humidityLabel.text = "\(Int(round(humidity!))) %"

                    let maxTemp = currentWeather.main.tempMax
                    self.maxTempLabel.text = "\(Int(round(maxTemp!))) ℃"

                    let minTemp = currentWeather.main.tempMin
                    self.minTempLabel.text = "\(Int(round(minTemp!))) ℃"
                    
                    let weatherImage = currentWeather.weather[0].weatherIcon
                    self.setupAnimation(name: weatherImage!)

                    let currentDate = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "EEEER"
                    self.dateLabel.text = dateFormatter.string(from: currentDate)

                }

            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weatherNameLabel.isSkeletonable = true
        weatherNameLabel.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .link),
                                                      animation: nil,
                                                      transition: .crossDissolve(0.2))

        
    }
    
    func setupAnimation(name: String) {
        weatherImage = .init(name: name)
        weatherImage.center = view.center
        weatherImage.frame = CGRect(x: 100, y: 500, width: 200, height: 200)
        weatherImage.contentMode = .scaleAspectFit
        weatherImage.loopMode = .loop
        weatherImage.animationSpeed = 1.0
        view.addSubview(weatherImage)
        weatherImage.play()

        
    }
    
    
}

