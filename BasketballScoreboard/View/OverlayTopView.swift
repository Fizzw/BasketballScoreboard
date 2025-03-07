//
//  OverlayTopView.swift
//  BasketballScoreboard
//
//  Created by 박정우 on 2/24/25.
//

import SwiftUI

import ComposableArchitecture

struct OverlayTopView: View {
    
    //MARK: - Store
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
            
            NavigationLink(destination: MenuView(scenePhaseStore: scenePhaseStore, counterStore: counterStore, colorPickerStore: colorPickerStore, timerStore: timerStore)) {
                Image(systemName: "arrow.right")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
            }
        }
    }
}
