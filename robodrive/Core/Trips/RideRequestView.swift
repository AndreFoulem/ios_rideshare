//
//  RideRequestView.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-17.
//

import SwiftUI

struct RideRequestView: View {
  var body: some View {
    VStack {
      Capsule()
        .foregroundColor(Color(.systemGray5))
        .frame(width: 48, height: 6)
      
      //-> trip info view
      HStack {
        VStack{
          Circle()
            .fill(Color(.systemGray3))
            .frame(width:8, height:8)
          Rectangle()
            .fill(Color(.systemGray3))
            .frame(width:1, height:32)
          Rectangle()
            .fill(Color(.black))
            .frame(width:8, height:8)
        }// VS indicator view
        
        VStack(alignment: .leading, spacing: 24) {
          HStack {
            Text("Current Location")
              .font(.system(size: 16, weight: .semibold))
              .foregroundColor(.gray)
            Spacer()
            Text("1:30pm")
              .font(.system(size: 14, weight: .semibold))
              .foregroundColor(.gray)
          }
          .padding(.bottom, 10)
          
          HStack {
            Text("Starbucks Coffee")
              .font(.system(size: 16, weight: .semibold))
              .foregroundColor(.black)
            Spacer()
            Text("1:45pm")
              .font(.system(size: 14, weight: .semibold))
              .foregroundColor(.gray)
          }
        }//VS current + dest locations
        .padding(.leading, 12)
      
      }// HS
      .padding()
      
      Divider()
      
      //-> ride type selection view
      Text("SUGGESTED RIDES")
        .font(.subheadline)
        .fontWeight(.semibold)
        .foregroundColor(.gray)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
      
      ScrollView(.horizontal){
        HStack(spacing: 12) {
          ForEach(0..<3, id: \.self) { _ in
            VStack(alignment: .leading) {
              Image("uber-x")
                .resizable()
                .scaledToFit()
              VStack{
                Text("XBOX")
                  .font(.system(size: 14, weight: .semibold))
                  .foregroundColor(.gray)
                Text("22$")
                  .font(.system(size: 14, weight: .semibold))
                  .foregroundColor(.gray)
              }
            }
            .frame(width:112, height: 140)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
          }
        }// HS
      }// SV
      //-> payment option view
      
      
      //-> request ride button
    }// VS
    
    
  }//body
}//RideRequestView

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
