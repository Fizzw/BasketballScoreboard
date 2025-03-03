//
//  OverlayMiddleView.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/25.
//

import SwiftUI

import ComposableArchitecture

struct OverlayMiddleView: View {
    let timerStore: StoreOf<TimerFeature>
    let counterStore: StoreOf<CounterFeature>
    @State var asd: Int = 3
    var body: some View {
        VStack {
            WithViewStore(timerStore, observe: { $0 }) { viewStore in
                Text("\(counterStore.quater)쿼터")
                    .onTapGesture {
                        counterStore.send(.nextQuater)
                    }
                    .onChange(of: viewStore.remainingTime) { oldValue, newValue in
                        print("newValue \(viewStore.remainingTime)")
                        if newValue == 0 {
                            counterStore.send(.nextQuater)
                            viewStore.send(.stopBothTimers)
                        }
                    }
                    .onLongPressGesture {
                        hapticImpact()
                        timerStore.send(.startBothTimers(true))
                        timerStore.send(.stopBothTimers)
                    }
            }
           
            HStack {
                Text(timeString(from: timerStore.remainingTime))
                    .font(.custom("Seven Segment", size: 100))
                    .foregroundStyle(.green)
            }
        }
    }
    
    // 초를 "MM:SS" 형식으로 변환
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
