//
//  RobodriveMapViewRepresentable.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-11.
//
import SwiftUI
import MapKit

struct RobodriveMapViewRepresentable: UIViewRepresentable {
  let mapView = MKMapView()
  
  // Init the LocationManager Class
  //-> Tell the user why we're requesting location -> In Project info
  //->  add the key: 'Privacy - Location When In Use Usage Description' + string prompt
  let locationManager = LocationManager()
  @EnvironmentObject var locationViewModel: LocationSearchViewModel
  
  func makeUIView(context: Context) -> some UIView {
    // context.coordinator gives us access to the MapCoordinator Delegate
    mapView.delegate = context.coordinator
    mapView.isRotateEnabled = false
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    
    return mapView
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
    //-> coordinate comes from clicking address selection
    if let coordinate = locationViewModel.selectedLocationCoordinate {
      context.coordinator.addAndSelectAnnotation(withCoordinate:  coordinate)
    }
  }
  

  // function to satisfy Coordinator protocol - return a MapCoordinator
  func makeCoordinator() -> MapCoordinator {
    return MapCoordinator(parent: self)
  }

  
}// RobodriveMapViewRepresentable

extension RobodriveMapViewRepresentable {
  //-> MKMapViewDelegate gives SwiftUI functionality from UIKit
  
  class  MapCoordinator: NSObject, MKMapViewDelegate {
    
    //-> MARK: Properties
    
    let parent: RobodriveMapViewRepresentable
    
    //-> MARK: Lifecycle
    
    init(parent: RobodriveMapViewRepresentable) {
      self.parent = parent
      super.init()
    }
    
    //-> MARK: MKMapViewDelegate
    
    //-> ZOOM LOCATION
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
      let region = MKCoordinateRegion(
        center:CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
              longitude: userLocation.coordinate.longitude),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
      )
      parent.mapView.setRegion(region, animated: true)
    }
    
    //-> MARK - helpers
    func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D){
      //' remove all previous annotations
      parent.mapView.removeAnnotations(parent.mapView.annotations)
      let anno = MKPointAnnotation()
      anno.coordinate = coordinate
      self.parent.mapView.addAnnotation(anno)
      self.parent.mapView.selectAnnotation(anno, animated: true)
    }
    
  }//MapCoordinator Class
  
}//extension

