//
//  LocationSearchActivationView.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-13.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
      HStack {
        Rectangle()
          .fill(Color.indigo)
          .frame(width:8,height:8)
          .padding(.horizontal)
        
        Text("Where to?")
          .foregroundColor(Color.indigo)
          .bold()
        
        Spacer()
 
      }//hstack
      // bounds = padding relating to bound
      .frame(width: UIScreen.main.bounds.width - 64, height: 50)
      .background(
        Rectangle()
          .fill(Color.white)
          .shadow(color: .indigo, radius: 4)
        )
      
    }// body
}// struct

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
