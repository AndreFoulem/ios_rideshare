//
//  HomeView.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-11.
//

//-> We have bound two element (round btn and cell result to showLocationSearchView Toggle

import SwiftUI

struct HomeView: View {
  @State private var showLocationSearchView = false
  
  var body: some View {
    
    ZStack(alignment: .top) {
      RobodriveMapViewRepresentable()
        .ignoresSafeArea()
      
      if showLocationSearchView {
        //-> Bind the state since it is bound now in the search view
        LocationSearchView(showLocationSearchView: $showLocationSearchView)
        
      } else {
        LocationSearchActivationView()
          .padding(.top, 72)
        //-> add animation
          .onTapGesture {
            withAnimation(.spring()){
              showLocationSearchView.toggle()
            }
          }
        
      }// ELSE
        MapViewActionButton(showLocationSearchView:   $showLocationSearchView)
          .padding(.leading)
      
      
    }//ZS
    
  }// BODY
}// STRUCT

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
