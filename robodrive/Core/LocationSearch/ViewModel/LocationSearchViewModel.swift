//
//  LocationSearchViewModel.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-13.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
  
  //-> - Properties
  @Published var results = [MKLocalSearchCompletion]()
  @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
  
  private let searchCompleter = MKLocalSearchCompleter()
  var queryFragment: String = "" {
    didSet{
      searchCompleter.queryFragment = queryFragment
    }
  }
  
  
  override init(){
    //-> super init() is to conform to NSObject
    super.init()
    searchCompleter.delegate = self
    searchCompleter.queryFragment = queryFragment
  }
  
  //-> Helpers for the select location -> selectedLocation: String?
  func selectLocation(_ localSearch: MKLocalSearchCompletion) {
    locationSearch(forLocalSearchCompletion: localSearch) {
      response, error in
      if let error = error {
        print("DEBUG: Location search failed with \(error.localizedDescription)")
        return
      }
      
      guard let item = response?.mapItems.first else { return }
      let coordinate = item.placemark.coordinate
      self.selectedLocationCoordinate = coordinate
      
      print("\n-LocationSearchViewModel-\n location coordinate:\n \(coordinate)")
    }
  }
    //-> grab the title and substring and search the location to get a legit location object
  func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
    
    let searchRequest = MKLocalSearch.Request()
    searchRequest.naturalLanguageQuery  = localSearch.title.appending(localSearch.subtitle)
    let search = MKLocalSearch(request: searchRequest)
    
    //-> completionHandler is the callback that return results
    search.start(completionHandler: completion)
    
  }
  
}

//-> MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    self.results = completer.results
  }
}
