//
//  MapViewActionButton.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-13.
//

import SwiftUI

struct MapViewActionButton: View {
  @Binding var showLocationSearchView: Bool
    
    var body: some View {
      Button{
        withAnimation(.spring()) {    showLocationSearchView.toggle()
        }
      } label: {
        Image(systemName: showLocationSearchView ? "arrow.left" : "line.3.horizontal")
          .font(.title)
          .foregroundColor(.white)
          .padding()
          .background(.indigo)
          .clipShape(Circle())
        .shadow(radius: 6)
      }// label
      .frame(maxWidth: .infinity, alignment: .leading)
      
      
    }// body
}// struct

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
      MapViewActionButton(showLocationSearchView: .constant(true))
    }
}
