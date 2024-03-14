//
//  CitySearchViewController.swift
//  Hava Durumu
//
//  Created by Ferhat on 4.12.2023.

import UIKit
import MapKit

class CitySearchViewController: UIViewController {
    //    MARK: - IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTable: UITableView!
    
    //    MARK: - Properties
   private var searchCompleter = MKLocalSearchCompleter()
   private var searchResults = [MKLocalSearchCompletion()]
   public private(set) var coordinate: CLLocationCoordinate2D? // didselectRowAt fonksiyonundaki coordinate CLLocationCoordinate2D türünden olduğu için biz de o türden bir coordinate değişkeni tanımladık. Tanımlamamın sebebi coordinate değişkenini fonksiyonun içinden çıkarıp ViewController içindeki unwindSegue de kullanabilmek. public private(set), başka modülde erişilebilir olsun fakat değiştirilemesin, sadece kendi içinde değiştirilsin.
    
    
    //    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter.delegate = self
        searchBar.delegate = self
        searchResultsTable.delegate = self
        searchResultsTable.dataSource = self
        
    
    }
}

//    MARK: - UISearchBarDelegate
extension CitySearchViewController: UISearchBarDelegate {
    // Bu yöntem, arama çubuğundaki metin her değiştirildiğinde searchCompleter'ın arama yapacağı sorgunun da güncelleneceğini bildirir.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            searchCompleter.queryFragment = searchText
    }
}





//    MARK: - MKLocalSearchCompleterDelegate
extension CitySearchViewController: MKLocalSearchCompleterDelegate {
    // Bu yöntem, searchCompleter yeni arama sonuçlarına sahip olduğunda çağrılacağını bildirir
    // tableViewda görüntülenen lokasyonlar üzerinde herhangi bir filtreleme yapmak isterseniz, bunu yapacağınız yer burası olacaktır.
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // searchResults değişkenimizi searchCompleter'ın döndürdüğü sonuçlara ayarlamak için...
        searchResults = completer.results
        // TableView'u yeni searchResults ile yeniden yüklemek için...
        searchResultsTable.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}


//    MARK: - TableView DataSource and Delegate
extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as! CitySearchTableViewCell
        cell.updateCell(with: searchResult)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedLocation = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedLocation)
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else { return }
            guard let name = response?.mapItems[0].name else { return }
            self.coordinate = coordinate
            let lat = coordinate.latitude
            let lon = coordinate.longitude
            
            print(lat)
            print(lon)
            print(name)
        self.performSegue(withIdentifier: "UnwindCell", sender: nil) // performsegue yi didselecetForRowAt içinde tanımlarsak veri göndermeden(response etmeden) önce segue yapar. Response etmeden yeni ekrana geçtiği için de veri yeni ekranda gösterilmez.
        }
        
    }
    
}

