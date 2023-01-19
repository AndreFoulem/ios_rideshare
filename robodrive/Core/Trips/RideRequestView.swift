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
        .padding(.leading, 8)
      
      }// HS trip info view
      .padding()
      
      Divider()
      
      //-> ride type selection view
      Text("SUGGESTED RIDES")
        .font(.subheadline)
        .fontWeight(.semibold)
        .foregroundColor(.gray)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
      
      ScrollView(.horizontal) {
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
              .padding(8)
           
            }
            .frame(width:112, height: 140)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
        
          }// FOR EACH
        }// HS
      }// SV car rides
      .padding(.horizontal)
      
      Divider()
        .padding(.vertical, 8)
      
      //-> payment option view
      HStack(spacing: 12) {
        Text("Visa")
          .font(.subheadline)
          .fontWeight(.semibold)
          .padding(6)
          .background(.blue)
          .cornerRadius(4)
          .foregroundColor(.white)
          .padding(.leading)
        
        Text("**** 1234")
          .fontWeight(.bold)
        
        Spacer()
        
        Image(systemName: "chevron.right")
          .imageScale(.medium)
          .padding()
      }// HS payments
      .frame(height: 50)
      .background(Color(.systemGroupedBackground))
      .cornerRadius(10)
      .padding(.horizontal)
      
      //-> request ride button
      Button {
        
      } label: {
        Text("CONFIRM RIDE")
          .fontWeight(.bold)
          .frame(width: UIScreen.main.bounds.width - 32, height: 50)
          .background(.blue)
          .cornerRadius(10)
          .foregroundColor(.white)
        
      }// BTN
      
      
    }// VS MAIN STACK
    .background(.white)
    
    
  }//body
}//RideRequestView

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}