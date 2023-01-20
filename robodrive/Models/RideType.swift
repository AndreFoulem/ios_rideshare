  //
  //  RideType.swift
  //  robodrive
  //
  //  Created by AndreMacBook on 2023-01-18.
  //

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
  //-> Case iterable let us wrap the cases in an array
  case uberX
  case black
  case cybertruck
  
  var id: Int { return rawValue }
  
  var description: String {
    switch self {
      case .uberX: return "ZOOX"
      case .black: return "Google Car"
      case .cybertruck: return "Cyber Truck"
    }
  }
  
  var imageName: String {
    switch self {
      case .uberX: return "uber-x"
      case .black: return "uber-black"
      case .cybertruck: return "cybertruck"
    }
  }
  
  var baseFare: Double {
    switch self {
      case .uberX: return 8
      case .black: return 12
      case .cybertruck: return 10
    }
  }
  
  func computePrice(for distanceInMeters: Double) -> Double {
    let distanceInMiles = distanceInMeters / 1000

      switch self {
        case .uberX: return distanceInMiles * 1.5 + baseFare
        case .black: return distanceInMiles * 2.0 + baseFare
        case .cybertruck: return distanceInMiles * 1.75 + baseFare
      }
    }
    
  
  
}
