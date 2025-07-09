//
//  TimerView.swift
//  SportTimer
//
//  Created by Алексей Авер on 08.07.2025.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var store: WorkoutStore
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Picker("Workout type", selection: $viewModel.workoutType) {
                    ForEach(WorkoutType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                Spacer()
                CircleTimerView(
                    progress: min(viewModel.elasped / 3600, 1),
                    time: Int(viewModel.elasped)
                )
                Spacer()
                TextField("Notes", text: $viewModel.notes)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    AppButton(title: "Start", color: .blue) {
                        viewModel.start()

                    }
                    
                    AppButton(title: "Pause", color: .warning) {
                        viewModel.pause()
                    }
                    
                    AppButton(title: "Stop", color: .danger) {
                        viewModel.stop(store: store)
                    }
                }
                .frame(height: 44)
                
                Spacer()
            }
            .mainBackground()
            .navigationTitle("Timer")
            .hideKeyboard()
        }
    }
}

#Preview {
    TimerView()
}

