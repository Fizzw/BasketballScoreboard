//
//  OverlayMiddleView.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/25.
//

import SwiftUI

import ComposableArchitecture

struct OverlayMiddleView: View {
    
    //MARK: - Store
    let timerStore: StoreOf<TimerFeature>
    let counterStore: StoreOf<CounterFeature>

    var body: some View {
        VStack {
            WithViewStore(timerStore, observe: { $0 }) { viewStore in
                Text("\(counterStore.quater)쿼터")
                    .onTapGesture {
                        counterStore.send(.nextQuater)
                        timerStore.send(.stopBothTimers)
                    }
                    .onChange(of: viewStore.remainingTime) { oldValue, newValue in
                        print("newValue \(viewStore.remainingTime)")
                        if newValue == 0 {
                            timerStore.send(.playBuzzer)
                            timerStore.send(.startBreakTimer)
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
}
