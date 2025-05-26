//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Aya on 06/04/2025.
//

import UIKit

class ChangeCityViewController: UIViewController {
   
    var citiesArray = [City(name: "Cairo", id: "360630"),
                       City(name: "Giza", id: "360995"),
                       City(name: "Alexandria", id: "361058"),
                       City(name: "Aswan", id: "359787"),
                       City(name: "Dahab", id: "358245"),
                       City(name: "Damanhūr", id: "358448"),
                       City(name: "Port Said", id: "358619"),
                       City(name: "Asyūţ", id: "359781"),
                       City(name: "Suez", id: "359796"),
                       City(name: "Sharqīyah", id: "360016"),
                       City(name: "Minyā", id: "360688"),
                       City(name: "Al Maḩallah al Kubrá", id: "360829"),
                       City(name: "Ismailia", id: "361055"),
                       City(name: "Al Fayyūm", id: "361323")
    ]
    


    
    var selectedCity : City?

    @IBOutlet weak var citiesPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        citiesPickerView.delegate = self
        citiesPickerView.dataSource = self
    }
    

   
    @IBAction func editButton(_ sender: Any) {
        if let city = selectedCity {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CityNameChanged"), object: nil, userInfo: ["city" : city])
            self.dismiss(animated: true,completion: nil)
        }
        
    }
    
}

extension ChangeCityViewController : UIPickerViewDelegate,UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        citiesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citiesArray[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = citiesArray[row]
    }
}
