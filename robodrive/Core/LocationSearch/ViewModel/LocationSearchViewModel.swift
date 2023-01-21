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
  @Published var selectedRobodriveLocation: RobodriveLocation?
  
  private let searchCompleter = MKLocalSearchCompleter()
  var queryFragment: String = "" {
    didSet{
      searchCompleter.queryFragment = queryFragment
    }
  }
  
  var userLocation: CLLocationCoordinate2D?
  
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
      self.selectedRobodriveLocation = RobodriveLocation(title: localSearch.title, coordinate: coordinate)
      
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
  
  func computeRidePrice(forType type: RideType) -> Double {
    guard let destCoordinate = selectedRobodriveLocation?.coordinate else {return 0.0}
    guard let userCoordinate = self.userLocation else {return 0.0}
    
    let userLocation = CLLocation(latitude: userCoordinate.latitude,
                                  longitude: userCoordinate.longitude)
    let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
    let tripInDistanceMeters = userLocation.distance(from: destination)
    return type.computePrice(for: tripInDistanceMeters)
  }
}

//-> MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    self.results = completer.results
  }
}
