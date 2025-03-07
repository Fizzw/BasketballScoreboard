//
//  Extension+View.swift
//  BasketballScoreboard
//
//  Created by 박정우 on 3/7/25.
//

import SwiftUI

extension View {
    
    //MARK: - public Funcitons
    public func hapticImpact() {
        let style = UIImpactFeedbackGenerator.FeedbackStyle.heavy
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    // 초를 "MM:SS" 형식으로 변환
    public func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
