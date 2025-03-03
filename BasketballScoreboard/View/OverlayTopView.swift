//
//  OverlayTopView.swift
//  BasketballScoreboard
//
//  Created by 박정우 on 2/24/25.
//

import SwiftUI

import ComposableArchitecture


struct OverlayTopView: View {
    let timerStore: StoreOf<TimerFeature>
    let scenePhaseStore: StoreOf<ScenePhaseFeature>
    let counterStore: StoreOf<CounterFeature>
    let colorPickerStore: StoreOf<ColorPickerFeature>
    var body: some View {
        HStack {
            Text("\(timerStore.currentTime)")
                .foregroundStyle(.white)
                .padding()
                .onAppear {
                    timerStore.send(.startCurrentTimer)
                }
            
            Spacer()
            ZStack {
               RoundedRectangle(cornerRadius: 6)
                   .fill(Color.gray.opacity(0.2))
                   .frame(width: 80, height: 40)

                HStack {
                   Button {
                       if timerStore.isRunning {
                           timerStore.send(.stopBothTimers)
                       } else {
                           if timerStore.remainingTime > 0 {
                               timerStore.send(.restartBothTimers)
                           } else {
                               timerStore.send(.startBothTimers(false))
                           }
                       }
                   } label: {
                       Image(systemName: timerStore.isRunning ? "pause" : "play.fill")
                           .foregroundStyle(.white)
                   }
                   .frame(width: 60, height: 40)

               }
           }
           .padding(.horizontal, 20)
            
            NavigationLink(destination: MenuView(scenePhaseStore: scenePhaseStore, counterStore: counterStore, colorPickerStore: colorPickerStore, timerStore: timerStore)) {
                Image(systemName: "arrow.right")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
            }
        }
    }
}
