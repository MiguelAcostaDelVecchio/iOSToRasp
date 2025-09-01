//
//  iOSToRaspApp.swift
//  iOSToRasp
//
//  Created by Miguel Acosta Del Vecchio on 6/4/24.
//

import SwiftUI

@main
struct iOSToRaspApp: App {
    // Instantiate view models
    @StateObject var bluetoothViewModel = BluetoothViewModel()
    @StateObject var tabBarManager = TabBarManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bluetoothViewModel)
                .environmentObject(tabBarManager)
        }
    }
}
