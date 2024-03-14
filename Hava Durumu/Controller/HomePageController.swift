//
//  ViewController.swift
//  Hava Durumu
//
//  Created by Ferhat on 27.11.2023.
//

import UIKit
import CoreLocation

class HomePageController: UIViewController {
    
    //    MARK: - UI Elements
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateNameLabel: UILabel!
    @IBOutlet weak var todayImage: UIImageView!
    @IBOutlet weak var dailyIconImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var sensibleTemperatureLabel: UILabel!
    @IBOutlet weak var rainProbabilityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    
    @IBOutlet weak var nextDayCollectionView: UICollectionView!
    

    
    //    MARK: - Properties
   private let networkController = NetworkController()
   private let locationManager = CLLocationManager()
   private var nextDays = [Weather]()
    
    
    
    //     MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nextDayCollectionView.delegate = self
        nextDayCollectionView.dataSource = self
        locationManager.delegate = self
        locationManager.requestLocation()
        //      locationManager.requestWhenInUseAuthorization()// uygulama kullanımdayken konum için izin ister.
        //      locationManager.startUpdatingLocation() // kullanıcının mevcut konumunu bildiren güncellemelerin oluşturulmasını başlatır.
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        collectionViewLayout.minimumInteritemSpacing = 2.5
        let collectionViewWidth = UIScreen.main.bounds.width
        let cellWidth = collectionViewWidth / 6
        collectionViewLayout.itemSize = CGSize(width: cellWidth, height: cellWidth * 2.13)
        nextDayCollectionView.collectionViewLayout = collectionViewLayout
        
    }
    
    
    //    MARK: - Functions
    func updateUI(with foreCast: ForeCast) {
        guard let day = foreCast.data.first?.date else { return }
        guard let today = foreCast.data.first else { return }
        self.nextDays = foreCast.data // collectionView de, nextDays değişkeninin indexpath ini almak için burada içini doldurdum.
        nextDays.removeFirst() // collectionView, bir sonraki günden başlaması için arraydeki ilk elemanı sildim.
        nextDayCollectionView.reloadData()
        
        //    MARK: - ForDay
        self.cityNameLabel.text = "\(foreCast.cityName), \(foreCast.countryCode)"
        self.dateNameLabel.text = Helpers.shared.dateConfing(date: day, identifier: "dd MMM yyyy, EEEE")
        self.todayImage.image = today.weather.todayImage
        self.dailyIconImage.image = today.weather.icon
        self.temperatureLabel.text = "\(Int(today.temperature))°c"
        self.maxMinTempLabel.text = "\(Int(today.maxTemp))°c/\(Int(today.minTemp))°c"
        self.descriptionLabel.text = today.weather.description
        self.sensibleTemperatureLabel.text = String(Int(today.appAverage))
        self.rainProbabilityLabel.text = "%\(Int(today.probability))"
        self.windSpeedLabel.text = "\(Int(today.windSpeed))m/s"
        self.humidityLabel.text = "%\(Int(today.humidity))"
        self.uvIndexLabel.text = String(Int(today.humidity))
    }
    
    @IBAction func cityCoordinateUnwind (_ segue: UIStoryboardSegue){
        guard segue.identifier == "UnwindCell",
              let sourceViewController = segue.source as? CitySearchViewController,
              let newCoordinate = sourceViewController.coordinate else { return }
        
        networkController.fetchInfo(for: newCoordinate) { newCity in
            guard let newCity = newCity else { return }
            self.updateUI(with: newCity)
        }
    }
}




extension HomePageController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myCoordinate = locations.first?.coordinate{
            networkController.fetchInfo(for: myCoordinate) { forecast in
                guard let foreCast = forecast else { return }
                self.updateUI(with: foreCast)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


extension HomePageController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         nextDays.count - 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nextDay = nextDays[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nextDaysCell", for: indexPath) as! NextDaysCollectionViewCell
        cell.update(with: NextDaysCollectionViewCellViewModel(weather: nextDay))
        return cell
    }
}


    
