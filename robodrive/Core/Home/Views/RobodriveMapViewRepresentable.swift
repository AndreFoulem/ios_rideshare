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
  @Binding var mapState: MapViewState
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
    print("\n-updateViewUI: Map state is\n\(mapState)")
    
    switch mapState {
      case .noInput:
        context.coordinator.clearMapViewAndRecenterOnUserLocation()
        break
      case .searchingForLocation:
        break
      case .locationSelected:
        if let coordinate = locationViewModel.selectedLocationCoordinate {
          context.coordinator.addAndSelectAnnotation(withCoordinate:  coordinate)
          context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
        }
        break
    }

    

//    if mapState == .noInput {
//      context.coordinator.clearMapViewAndRecenterOnUserLocation()
//    }
  }
  

  // function to satisfy Coordinator protocol - return a MapCoordinator
  func makeCoordinator() -> MapCoordinator {
    return MapCoordinator(parent: self)
  }

  
}// RobodriveMapViewRepresentable


//--------------------------------------------------------------
extension RobodriveMapViewRepresentable {
  //-> MKMapViewDelegate gives SwiftUI functionality from UIKit
  
  class  MapCoordinator: NSObject, MKMapViewDelegate {
    
    //-> MARK: Properties
    
    let parent: RobodriveMapViewRepresentable
    //: create a class level property
    var userLocationCoordinate: CLLocationCoordinate2D?
    var currentRegion: MKCoordinateRegion?
    
    //-> MARK: Lifecycle
    
    init(parent: RobodriveMapViewRepresentable) {
      self.parent = parent
      super.init()
    }
    
    //-> MARK: MKMapViewDelegate
    //-> ZOOM LOCATION
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
 
      self.userLocationCoordinate = userLocation.coordinate
      
      let region = MKCoordinateRegion(
        center:CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
              longitude: userLocation.coordinate.longitude),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
      )
      self.currentRegion = region
      parent.mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let polyline = MKPolylineRenderer(overlay: overlay)
      polyline.strokeColor = .systemIndigo
      polyline.lineWidth = 6
      return polyline
    }
    
    //-> MARK - helpers
    func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D){
        //' remove all previous annotations
      parent.mapView.removeAnnotations(parent.mapView.annotations)
      let anno = MKPointAnnotation()
      anno.coordinate = coordinate
      parent.mapView.addAnnotation(anno)
      parent.mapView.selectAnnotation(anno, animated: true)
      
        //' zoom map to show annotation + user location
      parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
    }
    
    func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
      
      guard let userLocationCoordinate = self.userLocationCoordinate else { return }
      
      getDestinationRoute(from: userLocationCoordinate, to: coordinate) {route in
        self.parent.mapView.addOverlay(route.polyline)
      }
    }
    
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void){
      
      let userPlacemark = MKPlacemark(coordinate: userLocation)
      let destPlacemark = MKPlacemark(coordinate: destination)
      let request = MKDirections.Request()
      request.source = MKMapItem(placemark: userPlacemark)
      request.destination = MKMapItem(placemark: destPlacemark)
      
      let directions = MKDirections(request: request)
      
      directions.calculate { response, error in
        if let error = error {
          print("\n-getDestinations\n Failed to get destinations\(error.localizedDescription)")
          return
        }
        
        guard let route = response?.routes.first else { return }
        completion(route)
        
      }
    }
    
    func clearMapViewAndRecenterOnUserLocation() {
      parent.mapView.removeAnnotations(parent.mapView.annotations)
      parent.mapView.removeOverlays(parent.mapView.overlays)
      if let currentRegion = currentRegion {
        parent.mapView.setRegion(currentRegion, animated: true)
      }
    }

  }//MapCoordinator Class
  
}//extension

