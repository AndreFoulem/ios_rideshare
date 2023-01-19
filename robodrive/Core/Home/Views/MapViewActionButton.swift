//
//  MapViewActionButton.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-13.
//

import SwiftUI

struct MapViewActionButton: View {
  @Binding var mapState: MapViewState
  @EnvironmentObject var viewModel: LocationSearchViewModel
    
  var body: some View {
    Button{
      withAnimation(.spring()) {
        actionForState(mapState)
      }
    } label: {
      Image(systemName: imageNameForState(mapState))
        .font(.title)
        .foregroundColor(.white)
        .padding()
        .background(.indigo)
        .clipShape(Circle())
        .shadow(radius: 6)
    }// label
    .frame(maxWidth: .infinity, alignment: .leading)
    
  }// body
  
  
      func actionForState(_ state: MapViewState) {
        switch state {
          case .noInput:
            print("DEBUG no input")
          case .searchingForLocation:
            mapState = .noInput
          case .locationSelected:
            mapState = .noInput
            viewModel.selectedLocationCoordinate = nil
        }
      }
      
      func imageNameForState(_ state: MapViewState) -> String {
        switch state {
          case .noInput:
            return "line.3.horizontal"
          case .searchingForLocation, .locationSelected:
            return "arrow.left"
        }
      }
      
}// struct

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
      MapViewActionButton(mapState: .constant(.noInput))
    }
}
