//
//  DeviceInformation.swift
//  iOSToRasp
//
//  Created by Miguel Acosta Del Vecchio on 6/8/24.
//

import SwiftUI
import CoreBluetooth

struct DeviceInformationView: View {
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var SelectedGPIOPin = 0
    @State private var possibleGPIOPins = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27]
    var peripheral: CBPeripheral
    
    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    HStack {
                        Text("Connection to \(peripheral.name ?? peripheral.identifier.uuidString)")
                        Text(peripheral.state == .connected ? "Connected" : "Disconnected")
                            .bold()
                    }
                    
                    Button {
                        bluetoothViewModel.disconnect(from: peripheral)
                        dismiss()
                    } label: {
                        Text("Disconnect")
                    }

                    Menu {
                        ForEach(possibleGPIOPins, id: \.self) { GPIOpin in
                            Button {
                                SelectedGPIOPin = GPIOpin
                            } label: {
                                Text("GPIO \(GPIOpin)")
                            }

                        }
                    } label: {
                        HStack {
                            Text("Choose GPIO Pin To Toggle")
                            Spacer()
                            if SelectedGPIOPin != 0 {
                                Text("GPIO \(SelectedGPIOPin)")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    
                    if SelectedGPIOPin != 0 {
                        HStack {
                            Spacer()
                            Button {
                                let data = Data([UInt8(SelectedGPIOPin)])
                                bluetoothViewModel.writeToPeripheral(peripheral: peripheral, data: data)
                            } label: {
                                Image(systemName: "lightbulb")
                                Text("Toggle GPIO-\(SelectedGPIOPin)")
                            } // end of button
                            .buttonStyle(.bordered)
                            Spacer()
                        }
                    }
                } // end of Section
                
                Section("Description") {
                    Text(peripheral.description)
                }
                
                /*Section("Services & Characteristics") {
                    Text(peripheral.services)
                }*/
                
            } // end of form
            .navigationTitle("Device Information")
        }
    }
}
