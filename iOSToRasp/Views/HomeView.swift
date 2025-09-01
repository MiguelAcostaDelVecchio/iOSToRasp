//
//  HomeView.swift
//  iOSToRasp
//
//  Created by Miguel Acosta Del Vecchio on 8/31/25.
//

import CoreBluetooth
import ConfettiSwiftUI
import Foundation
import SwiftUI

class OverallToastPresenter: ObservableObject {
    @Published var showToast: Bool = false
}

enum DeletionType {
    case instant
    case prompt
}

class OverallTransactionManager: ObservableObject {
    @Published var toEdit: Transaction?
    @Published var toDelete: Transaction?
    @Published var showToast: Bool = false
    @Published var showPopup: Bool = false
    @Published var future: Bool = false
}

struct HomeView: View {
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel
    
    @State var currentTab = "ble"
    
    var topEdge: CGFloat
    var bottomEdge: CGFloat
    
    @State var fromURL1: Bool = false
    @State var fromURL2: Bool = false
    @State var fromURL3: Bool = false
    @State var fromURL4: Bool = false

    @State var launchAdd: Bool = false
    @State var launchSearch: Bool = false

    @State var counter = 0

    @EnvironmentObject var tabBarManager: TabBarManager

    @State var showPopup = false
    
    // Hiding Native TabBar...
    init(topEdge: CGFloat, bottomEdge: CGFloat) {
        UITabBar.appearance().isHidden = true
        self.topEdge = topEdge
        self.bottomEdge = bottomEdge
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section() {
                    ForEach(bluetoothViewModel.peripherals, id: \.identifier) { peripheral in
                        
                        if let _ = peripheral.name { // check if bluetooth device has a name in the advertisement packet
                            if peripheral.state == .connected { // if connected to device, view the device's information
                                NavigationLink(
                                    destination: DeviceInformationView(peripheral: peripheral).environmentObject(bluetoothViewModel),
                                    label: {PeripheralButton(peripheral: peripheral).environmentObject(bluetoothViewModel)}
                                )
                            } else {
                                PeripheralButton(peripheral: peripheral).environmentObject(bluetoothViewModel)
                            }
                        }
                        
                    } // end of ForEach
                } // end of section
            } // end of list
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Text("Bluetooth Devices")
                        .font(.title)
                        .foregroundStyle(Color.white)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Put link here to set up instructions for raspberry pi
                        print("question mark was pressed")
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .imageScale(.large)
                            .bold()
                    }
                }
            }
        }
        
    }
}
