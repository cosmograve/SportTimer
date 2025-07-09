//
//  MainTabView.swift
//  SportTimer
//
//  Created by Алексей Авер on 08.07.2025.
//


import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var store: WorkoutStore
    @State private var selectedTabIndex: Int = 0
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            HomeView(selectedTabIndex: $selectedTabIndex)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)

            TimerView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("Timer")
                }
                .tag(1)

            HistoryView(store: store)
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }
                .tag(2)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(3)
        }
    }
}

#Preview {
    MainTabView()
}
