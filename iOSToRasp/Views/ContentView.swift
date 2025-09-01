//
//  ContentView.swift
//  iOSToRasp
//
//  Created by Miguel Acosta Del Vecchio on 6/4/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel
    
    // Color Scheme
    @AppStorage("colorScheme", store: UserDefaults(suiteName: "group.com.MiguelAcosta.iosToRasp")) var colorScheme: Int = 0
    
    // Notifications
    @AppStorage("showNotifications", store: UserDefaults(suiteName: "group.com.MiguelAcosta.iosToRasp")) var showNotifications: Bool = false
    @AppStorage("notificationsEnabled", store: UserDefaults(suiteName: "group.com.MiguelAcosta.iosToRasp")) var notificationsEnabled: Bool = true
    var center = UNUserNotificationCenter.current()
    
    // First Launch
    @AppStorage("firstLaunch", store: UserDefaults(suiteName: "group.com.MiguelAcosta.iosToRasp")) var firstLaunch: Bool = true
    
    @State var showIntro: Bool = false
    
    // Edges
    @AppStorage("topEdge", store: UserDefaults(suiteName: "group.com.MiguelAcosta.iosToRasp")) var savedTopEdge: Double = 30
    @AppStorage("bottomEdge", store: UserDefaults(suiteName: "group.com.MiguelAcosta.iosToRasp")) var savedBottomEdge: Double = 15
    
    var body: some View {
        GeometryReader { proxy in
            let topEdge = proxy.safeAreaInsets.top
            let bottomEdge = proxy.safeAreaInsets.bottom
            
            HomeView(topEdge: topEdge, bottomEdge: bottomEdge == 0 ? 15 : bottomEdge)
                .ignoresSafeArea(.all, edges: .bottom)
                .preferredColorScheme(colorScheme == 1 ? .light : colorScheme == 2 ? .dark : nil)
                .fullScreenCover(isPresented: $showIntro) {
                    WelcomeSheetView()
                }
                .onAppear {
                    savedTopEdge = topEdge
                    savedBottomEdge = bottomEdge
                }
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            let defaults = UserDefaults(suiteName: "group.com.MiguelAcosta.iosToRasp") ?? UserDefaults.standard
            
            if firstLaunch {
                showIntro = true
                firstLaunch = false

                defaults.set(1, forKey: "haptics")
                defaults.set(1, forKey: "notificationOption")
                defaults.set(false, forKey: "confetti")
                defaults.set(false, forKey: "chromatic")
                defaults.set(true, forKey: "animated")

            }
            
            center.getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                    if !showNotifications && notificationsEnabled == false {
                        showNotifications = true
                        notificationsEnabled = true
//                        newNotification()
                    }
                } else if settings.authorizationStatus == .denied {
                    notificationsEnabled = false

                    if showNotifications {
                        showNotifications = false
                        center.removeAllPendingNotificationRequests()
                    }
                }
            }
            
        }
    }
    
}
