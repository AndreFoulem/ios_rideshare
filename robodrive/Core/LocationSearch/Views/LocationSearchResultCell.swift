//
//  LocationSearchResultCell.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-13.
//

import SwiftUI

struct LocationSearchResultCell: View {
  let title: String
  let subtitle: String
  
  var body: some View {
      HStack {
        Image(systemName: "mappin.circle.fill")
          .resizable()
          .foregroundColor(.indigo)
          .accentColor(.white)
          .frame(width: 40, height: 40)
        
        VStack(alignment: .leading, spacing: 2){
          Text(title)
            .font(.body)
          Text(subtitle)
            .font(.system(size: 15))
            .foregroundColor(.gray)
          Divider()
            .padding(3)
        }// VS
        .padding(.leading, 8)
        .padding(.vertical, 4)
    
      }// HS
      .padding(.leading)
      
    }// BODY
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
      LocationSearchResultCell(title: "Starbucks", subtitle: "123 Main St")
    }
}
