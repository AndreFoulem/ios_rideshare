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
}

//-> MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    self.results = completer.results
  }
}
