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
  
  func makeUIView(context: Context) -> some UIView {
    mapView.isRotateEnabled = false
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    
    return mapView
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
      
  }
  
  func makeCoordinator() -> MapCoordinator {
    return MapCoordinator(parent: self)
  }

  
}// RobodriveMapViewRepresentable

extension RobodriveMapViewRepresentable{
  class  MapCoordinator: NSObject, MKMapViewDelegate {
    let parent: RobodriveMapViewRepresentable
    
    init(parent: RobodriveMapViewRepresentable) {
      self.parent = parent
      super.init()
    }
  }
}

//-> CHATGPT CODE <-//
  //  func makeUIView(context: Context) -> MKMapView {
  //    return mapView
  //  }
  //
  //  func updateUIView(_ uiView: MKMapView, context: Context) {
  //      // This can be used to update the map view, if necessary.
  //      // For example, if you need to change the region of the map, you can set the region property of the map view here.
  //  }
