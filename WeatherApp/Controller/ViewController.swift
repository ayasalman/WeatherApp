//
//  ViewController.swift
//  WeatherApp
//
//  Created by Aya on 05/04/2025.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
  
    @IBOutlet weak var headerUIView: UIView!
    
    @IBOutlet weak var sunriseUiView: UIView!
    
    @IBOutlet weak var sunsetUIView: UIView!
 
    @IBOutlet weak var cloudsUIView: UIView!
    
    @IBOutlet weak var windUIView: UIView!
    
    @IBOutlet weak var humidityUIView: UIView!
  
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var sunRiseLabel: UILabel!
    
    @IBOutlet weak var pressureUIView: UIView!
    
    @IBOutlet weak var cloudLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var maxTemp: UILabel!
    
    @IBOutlet weak var minTemp: UILabel!
    
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var TemperatureLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    var cityID = "360630"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateUI(view: headerUIView)
        updateUI(view: humidityUIView)
        updateUI(view: pressureUIView)
    
        roundedView(view: windUIView)
        roundedView(view: cloudsUIView)
        roundedView(view: sunsetUIView)
        roundedView(view: sunriseUiView)
     
        NotificationCenter.default.addObserver(self, selector: #selector(cityChanged), name: NSNotification.Name(rawValue: "CityNameChanged"), object: nil)
        
     getCity()
    }
    
    func updateUI(view: UIView) {
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 1
        
    }
    
    func roundedView (view: UIView)
    {
        view.layer.cornerRadius.round()
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 1
    }
    
    
    @objc func cityChanged(notification : Notification)
    {
        if let city = notification.userInfo?["city"] as? City
        {
            cityLabel.text = city.name
            cityID = city.id
            
            
          getCity()
            
            
            
        }
    }

    func convertTemp(tempo : Double)-> Double {
       var tempo = tempo - 272.15
        tempo = Double(round(1000 * tempo) / 1000)
        return tempo
    }

    
    
    func getCity()
    {
        let parameters = ["id": cityID, "appid" : "edefbe35dcdf20b2cd435c0265e91537"]
       // loaderIndicator.startAnimating()
        AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            //print(response.value)
            
            if let result = response.value {
                let JSON = result as! NSDictionary
                let main = JSON["main"] as! NSDictionary
                if let weatherArray = JSON["weather"] as? NSArray,
                       let firstWeather = weatherArray.firstObject as? NSDictionary,
                       let description = firstWeather["description"] as? String {

                        self.weatherDescription.text = description.capitalized
                        print(description)
                    }
                let wind = JSON["wind"] as! NSDictionary
                let clouds = JSON["clouds"] as! NSDictionary
                
                
                
                if let dt = JSON["dt"] as? Double {
                        let date = Date(timeIntervalSince1970: dt)
                        let formatter = DateFormatter()
                        formatter.dateStyle = .full
                        formatter.timeStyle = .none
                        formatter.locale = Locale.current
                        self.dateLabel.text = formatter.string(from: date)
                    }
                
                
                
                
                if let sys = JSON["sys"] as? NSDictionary {
                       if let sunrise = sys["sunrise"] as? Double,
                          let sunset = sys["sunset"] as? Double {

                           let formatter = DateFormatter()
                           formatter.dateStyle = .none
                           formatter.timeStyle = .short
                           formatter.locale = Locale.current
                           formatter.timeZone = TimeZone.current

                           let sunriseDate = Date(timeIntervalSince1970: sunrise)
                           let sunsetDate = Date(timeIntervalSince1970: sunset)

                           self.sunRiseLabel.text = " \(formatter.string(from: sunriseDate))"
                           self.sunsetLabel.text = "\(formatter.string(from: sunsetDate))"
                       }
                   }
                
                
                

                var maxTemp = main["temp_max"] as! Double
                var minTemp = main["temp_min"] as! Double
                var feelsLike = main["feels_like"] as! Double
                var temp = main["temp"] as! Double
                var pressure =  main["pressure"] as! Int
                var humidity = main["humidity"] as! Double
                var windSpeed = wind["speed"] as! Double
                var cloud = clouds["all"] as! Int
                
                
                
                
               temp = self.convertTemp(tempo: temp)
               feelsLike =  self.convertTemp(tempo: feelsLike)
               minTemp = self.convertTemp(tempo: minTemp)
               maxTemp = self.convertTemp(tempo: maxTemp)
                

                self.loaderIndicator.stopAnimating()
                
                print(temp)
                
                self.TemperatureLabel.text = "\(temp)°"
                self.pressureLabel.text = "\(pressure)"
                self.humidityLabel.text = "\(humidity)"
                self.feelsLikeLabel.text = "Feels Like: \(feelsLike)°"
                self.minTemp.text = "\(minTemp)°"
                self.maxTemp.text = "\(maxTemp)°"
                self.windLabel.text = "\(windSpeed)m/s"
                self.cloudLabel.text = "\(cloud)%"
                
            }
        }
    }
    
}



