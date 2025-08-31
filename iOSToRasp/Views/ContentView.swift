//
//  ContentView.swift
//  iOSToRasp
//
//  Created by Miguel Acosta Del Vecchio on 6/4/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    
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
            .navigationBarTitle("Bluetooth Devices")
        }
    }
}

#Preview {
    ContentView()
}
