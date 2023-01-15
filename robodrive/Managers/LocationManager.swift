//
//  LocationManager.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-12.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
  private let locationManager = CLLocationManager()
  override init(){
    super.init()
    locationManager.delegate = self
    
    // Gives us best accuracy
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    
    // System ask the user for auth
    locationManager.requestWhenInUseAuthorization()
    
    // Start updating the user location
    locationManager.startUpdatingLocation()
    
    //-> Init in RobodriveMapViewRepresentable.swift
  }
}

//-> Add delegates from UIKit
extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    //-> When we get the location with startUpdating, we won't to stop updating it
    guard !locations.isEmpty else { return }
    locationManager.stopUpdatingLocation()
  }
  
}//extension
