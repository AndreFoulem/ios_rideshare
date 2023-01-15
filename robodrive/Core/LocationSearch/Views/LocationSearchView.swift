//
//  LocationSearchView.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-13.
//

import SwiftUI

struct LocationSearchView: View {
  @State private var startLocationText = ""
  @Binding var showLocationSearchView: Bool
  @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
      
      VStack{
     
        HStack {
          VStack{
            Circle()
              .fill(Color(.black))
              .frame(width:6, height:6)
            Rectangle()
              .fill(Color(.black))
              .frame(width:1, height:24)
            Rectangle()
              .fill(Color(.black))
              .frame(width:6, height:6)
          }
          
          VStack{
            TextField("Current location", text:
                        $startLocationText)
            .frame(height: 32)
            .background(Color(.systemGroupedBackground))
            .padding(.trailing)
            
            TextField("Where to?", text:
                        $viewModel.queryFragment)
            .frame(height: 32)
            .background(Color(.systemGray4))
            .padding(.trailing)
          }

        }//HS - Header View
        .padding(.horizontal)
        .padding(.top, 64)
        
        Divider()
          .padding(.vertical)

        
        ScrollView{
          VStack(alignment: .leading){
            ForEach(viewModel.results, id: \.self) { result in
              LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                //->. pass the gesture corresponding to the bool binding
                .onTapGesture {
                  //-> model needs be before toggling
                  viewModel
                    .selectLocation(result .title)
                  
                  showLocationSearchView.toggle()
                }
            }
          }
          
        }//SV - Scroll View
        
        
     
      }//VS - Group
      .background(.white)
      
    }//BODY
}//STRUCT

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
      //-> always passed the bool from the binding in the Preview
      LocationSearchView(showLocationSearchView: .constant(false))
    }
}
