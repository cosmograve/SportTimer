//
//  ProfileView.swift
//  SportTimer
//
//  Created by Алексей Авер on 08.07.2025.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var store: WorkoutStore
    @AppStorage("isSoundEnabled") private var isSoundEnabled = true
    
    @State private var avatarImage: UIImage? = nil
    @State private var isShowingPhotoPicker = false

    @State private var showResetAlert = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        VStack {
                            AvatarView(image: $avatarImage)
                                .onTapGesture {
                                    isShowingPhotoPicker = true
                                }
                            EditableNameView()
                        }
                        Spacer()
                    }
                }

                Section(header: Text("Statistic")) {
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundStyle(.blue)
                        Text("Total workouts")
                            .mainText()
                        
                        Spacer()
                        Text("\(store.workouts.count)")
                            .secondarytext()
                    }

                    HStack {
                        Image(systemName: "clock")
                            .foregroundStyle(.blue)
                        Text("Total duration")
                            .mainText()
                        
                        Spacer()
                        Text(store.workouts.map { Int($0.duration) }.reduce(0, +).formattedTime)
                            .secondarytext()
                    }
                }

                Section(header: Text("Settings")) {
                    Toggle(isOn: $isSoundEnabled) {
                        HStack {
                            Image(systemName: "speaker.wave.2.fill")
                                .foregroundStyle(.blue)
                            Text("Timer sound")
                                .mainText()
                        }
                        
                    }

                    Button(role: .destructive) {
                        showResetAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundStyle(.danger)
                            Text("Erase data")
                                .mainText()
                        }
                    }
                }

                Section() {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.blue)
                        Text("About")
                            .mainText()
                        Spacer()
                        Text("Ver 1.0.0")
                            .secondarytext()
                    }
                }
            }
            .mainBackground()
            .navigationTitle("Profile")
            .sheet(isPresented: $isShowingPhotoPicker) {
                PhotoPicker { pickedImage in
                    if let image = pickedImage {
                        self.avatarImage = image
                    }
                }
            }
            .alert("Erase all data?", isPresented: $showResetAlert) {
                Button("Delete", role: .destructive) {
                    store.deleteAllWorkouts()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

#Preview {
    ProfileView()
}
