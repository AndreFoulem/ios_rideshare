//
//  RideRequestView.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-17.
//

import SwiftUI

struct RideRequestView: View {
  @State private var selectedRideType: RideType = .uberX
  @EnvironmentObject var locationViewModel: LocationSearchViewModel
  
  var body: some View {
    VStack {
      Capsule()
        .foregroundColor(Color(.systemGray5))
        .frame(width: 48, height: 6)
        .padding(.top, 12)
      
      //-> trip info view
      HStack {
        VStack{
          Circle()
            .fill(Color(.systemGray3))
            .frame(width:8, height:8)
          Rectangle()
            .fill(Color(.systemGray3))
            .frame(width:1, height:22)
          Rectangle()
            .fill(Color(.black))
            .frame(width:8, height:8)
        }// VS indicator view
        
        VStack(alignment: .leading, spacing: 16) {
          HStack {
            Text(locationViewModel.pickupTime ?? "")
              .font(.system(size: 16, weight: .semibold))
              .foregroundColor(.gray)
            Spacer()
            Text(locationViewModel.dropOffTime ?? "")
              .font(.system(size: 14, weight: .semibold))
              .foregroundColor(.gray)
          }
          .padding(.bottom, 8)
          
          HStack {
            if let location = locationViewModel.selectedRobodriveLocation {
              Spacer()
              Text(location.title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
            }
          }
        }//VS current + dest locations
        .padding(.leading, 6)
      
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
          //LOOP
          ForEach(RideType.allCases) { type in
            VStack(alignment: .leading) {
              Image(type.imageName)
                .resizable()
                .scaledToFit()
                .padding(14)
              VStack(alignment: .leading,spacing:0) {
                Text(type.description)
                  .font(.system(size: 14, weight: .semibold))
                Text(locationViewModel.computeRidePrice(forType: type).toCurrency())
                  .font(.system(size: 14, weight: .semibold))
              }
              .padding(.leading)
           
            }
            .frame(width:112, height: 140)
            .foregroundColor(type == selectedRideType ? .white : .black)
            .background(Color(type == selectedRideType ? .systemIndigo :.systemGroupedBackground))
            .scaleEffect(type == selectedRideType ? 1.1 : 1.0)
            .cornerRadius(10)
            .onTapGesture {
              withAnimation(.spring()) {
                selectedRideType = type
              }
            }
        
          }// FOR EACH
        }// HS
      }// SV car rides
      .padding(.horizontal)
      
      Divider()
        .padding(.vertical, 6)
      
      //-> payment option view
      HStack(spacing: 12) {
        Text("Visa")
          .font(.subheadline)
          .fontWeight(.semibold)
          .padding(6)
          .background(.indigo)
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
          .background(.indigo)
          .cornerRadius(10)
          .foregroundColor(.white)
        
      }// BTN
      
      
    }// VS MAIN STACK
    .padding(.bottom,36)
    .background(.white)
    .cornerRadius(16)
    
    
  }//body
}//RideRequestView

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
