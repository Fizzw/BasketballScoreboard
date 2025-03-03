//
//  OverlayBottomView.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/25.
//

import SwiftUI

import ComposableArchitecture

struct OverlayBottomView: View {
    let counterStore: StoreOf<CounterFeature>
    let timerStore: StoreOf<TimerFeature>
    let colorPickerStore: StoreOf<ColorPickerFeature>
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Text(String(format: "%02d", timerStore.shotClockTime))
                 .font(.custom("Seven Segment", size: 100))
                 .frame(width: 150)
                 .foregroundStyle(.red)
            }
            Spacer()
            
           
        }
    }
     
     private func timeString(from seconds: Int) -> String {
         let minutes = seconds / 60
         let seconds = seconds % 60
         return String(format: "%02d:%02d", minutes, seconds)
     }
    
    private func hapticImpact() {
        let style = UIImpactFeedbackGenerator.FeedbackStyle.heavy 
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
