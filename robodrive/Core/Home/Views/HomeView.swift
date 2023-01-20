//
//  HomeView.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-11.
//

//-> We have bound two element (round btn and cell result to showLocationSearchView Toggle

import SwiftUI

struct HomeView: View {
  @State private var mapState = MapViewState.noInput
  @EnvironmentObject var locationViewModel: LocationSearchViewModel
  
  var body: some View {
    
    ZStack(alignment: .bottom) {
      ZStack(alignment: .top) {
        RobodriveMapViewRepresentable(mapState: $mapState)
          .ignoresSafeArea()
        
        if mapState == .searchingForLocation {
          //-> Bind the state since it is bound now in the search view
          LocationSearchView(mapState: $mapState)
          
        } else if mapState == .noInput {
          LocationSearchActivationView()
            .padding(.top, 72)
          //-> add animation
            .onTapGesture {
              withAnimation(.spring()){
                mapState = .searchingForLocation
              }
            }
          
        }// ELSE
          MapViewActionButton(mapState: $mapState)
            .padding(.leading)
      }
      
      if mapState == .locationSelected {
        RideRequestView()
          .transition(.move(edge: .bottom))
      }
    }//ZS MAIN
    .edgesIgnoringSafeArea(.bottom)
    .onReceive(LocationManager.shared.$userLocation) {
      location in
      if let location = location {
        locationViewModel.userLocation = location
      }
    }

    
  }// BODY
}// STRUCT

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
   

    }
}
