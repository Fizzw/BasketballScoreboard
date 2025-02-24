//
//  BasketballScoreboardApp.swift
//  BasketballScoreboard
//
//  Created by 박정우 on 2/23/25.
//

import SwiftUI
import ComposableArchitecture
@main
struct BasketballScoreboardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(timerStore: Store(initialState: TimerFeature.State(), reducer: {
                TimerFeature()
            }), counterStore: Store(initialState: CounterFeature.State(), reducer: {
                CounterFeature()
            }), scenePhaseStore: Store(initialState: ScenePhaseFeature.State(), reducer: {
                ScenePhaseFeature()
            }), colorPickerStore: Store(initialState: ColorPickerFeature.State(), reducer: {
                ColorPickerFeature()
            }))
        }
    }
}
