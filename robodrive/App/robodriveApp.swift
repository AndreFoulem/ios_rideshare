//
//  robodriveApp.swift
//  robodrive
//
//  Created by AndreMacBook on 2023-01-11.
//

import SwiftUI

@main
struct robodriveApp: App {
  @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
            .environmentObject(locationViewModel)
        }
    }
}
