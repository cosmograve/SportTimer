//
//  AppButton.swift
//  SportTimer
//
//  Created by Алексей Авер on 09.07.2025.
//

import SwiftUI

struct AppButton: View {
    let title: String
    let color: Color
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical, 14)
            .padding(.horizontal, 32)
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .scaleEffect(isPressed ? 0.8 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isPressed)
            .onTapGesture {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                    action()
                }
            }
    }
}

#Preview {
    AppButton(title: "1", color: .blue, action: {
        
    })
}

