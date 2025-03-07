//
//  DotsAnimationView.swift
//  BasketballScoreboard
//
//  Created by 박정우 on 3/7/25.
//

import SwiftUI

struct BouncingDotsLeftView: View {
    
    //MARK: State
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { index in
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.white)
                    .offset(y: isAnimating ? 10 : -10)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct BouncingDotsRightView: View {
    
    //MARK: - State
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { index in
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.white)
                    .offset(y: isAnimating ? -10 : 10)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}


