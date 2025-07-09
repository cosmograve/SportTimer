//
//  HomeView.swift
//  SportTimer
//
//  Created by Алексей Авер on 08.07.2025.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var store: WorkoutStore
    @AppStorage("username") private var username: String = "User"
    @Binding var selectedTabIndex: Int
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Hi 👋 \(username)")
                        .titleText()
                    
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Label("Total workouts", systemImage: "flame.fill")
                            Spacer()
                            Text("\(store.workouts.count)")
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Label("Total duration", systemImage: "clock")
                            Spacer()
                            Text(store.workouts.map { Int($0.duration) }.reduce(0, +).formattedTime)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                AppButton(title: "Start workout", color: .blue) {
                    selectedTabIndex = 1
                }
                
                Spacer()
                RecentWorkoutsSection(workouts: store.workouts)
            }
            .mainBackground()
            .navigationTitle("Home")
        }
    }
    
    private func totalDurationFormatted() -> String {
        let totalSeconds = store.workouts.map { Int($0.duration) }.reduce(0, +)
        
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        
        if hours > 0 {
            return "\(hours) ч \(minutes) мин"
        } else {
            return "\(minutes) мин"
        }
    }
}
