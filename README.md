🌤 Egypt Weather App
An elegant iOS application built with Swift and UIKit that provides real-time weather data for major Egyptian cities. Powered by the OpenWeatherMap API and Alamofire, the app showcases responsive UI, dynamic data handling, and modular architecture.


---



🚀 Features


✅ Real-Time Weather

Temperature

Feels Like

Max / Min temperatures

Humidity

Pressure

Wind speed

Cloudiness

Sunrise and sunset times

Current date and time zone


✅ City Picker

Choose from 14 major Egyptian cities using a UIPickerView

Updates weather details instantly using NotificationCenter

✅ Responsive UI with Auto Layout

All UI elements use Auto Layout constraints for consistent appearance across iPhones

Rounded views with shadows for a modern card-style interface

✅ Loading Indicator

UIActivityIndicatorView appears while fetching weather data

Hides automatically on data load completion

✅ Lightweight Architecture

Clean separation using MVC

Communication via NotificationCenter

---


🏗️ Architecture

MVC pattern


ViewController.swift:

Fetches weather data using OpenWeatherMap API

Updates UI with real-time data

Listens for city change via NotificationCenter

Parses and displays weather data

Converts temperature from Kelvin to Celsius



ChangeCityViewController.swift:

Presents a UIPickerView for city selection

Posts a Notification when the city changes



City.swift:

Model struct for city name and ID


---


🧱 Tech Stack

✅ Swift 5

✅ UIKit

✅ Auto Layout & Constraints

✅ Alamofire (networking)

✅ NotificationCenter (for city change updates)

✅ OpenWeatherMap API

---


🧪 Dependencies
Alamofire

Make sure to run pod install or add Alamofire via Swift Package Manager.

---


🔧 Setup Instructions

Clone the repository.

Open the .xcworkspace file in Xcode.

Run the project on a simulator or device.

Tap the Edit City button to select another Egyptian city.

---



📌 Notes

Temperatures are converted from Kelvin to Celsius.

All time data is converted to local device time.

NotificationCenter is used for simple communication between view controllers.

---


📽 Demo Video

https://github.com/ayasalman/WeatherApp/issues/1#issue-3091381774

---


📝 License
This project is open-source and available under the MIT License.

---


👩‍💻 Author
Aya
iOS Developer

