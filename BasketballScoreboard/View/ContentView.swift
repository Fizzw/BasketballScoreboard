//
//  ContentView.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/25.
//

import SwiftUI

import ComposableArchitecture

struct ContentView: View {
    let timerStore: StoreOf<TimerFeature>
    let counterStore: StoreOf<CounterFeature>
    let scenePhaseStore: StoreOf<ScenePhaseFeature>
    let colorPickerStore: StoreOf<ColorPickerFeature>
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                OverlayScoreView(colorPickerStore: colorPickerStore, counterStore: counterStore)
                VStack {
                    OverlayTopView(timerStore: timerStore, scenePhaseStore: scenePhaseStore, counterStore: counterStore, colorPickerStore: colorPickerStore)
                    Spacer()
                    OverlayMiddleView(timerStore: timerStore, counterStore: counterStore)
                    Spacer()
                    ZStack {
                        OverlayBottomView(counterStore: counterStore,timerStore: timerStore, colorPickerStore: colorPickerStore)
                            .padding(.bottom, 20)
                    }
                    Spacer()
                }
                OverlayCounterView(counterStore: counterStore, colorPickerStore: colorPickerStore, timerStore: timerStore)

            }
            .persistentSystemOverlays(.hidden)
            .onAppear {
                colorPickerStore.send(.loadSavedColor)
                timerStore.send(.loadSavedTime)
                counterStore.send(.loadSavedQuater)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
    }
        
}


