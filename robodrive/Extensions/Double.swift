//
//  Double.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-20.
//

import Foundation

extension  Double {
  
  private var currencyFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }
}
