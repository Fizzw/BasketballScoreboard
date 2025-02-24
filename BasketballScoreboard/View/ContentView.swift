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
                VStack {
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
                               .frame(width: 150, height: 40)

                            HStack {
                               Button {
                                   if timerStore.isRunning {
                                       timerStore.send(.stopBothTimers)
                                   } else {
                                       if timerStore.remainingTime > 0 {
                                           timerStore.send(.restartBothTimers)
                                       } else {
                                           timerStore.send(.startBothTimers)
                                       }
                                   }
                               } label: {
                                   Image(systemName: timerStore.isRunning ? "pause" : "play.fill")
                                       .foregroundStyle(.white)
                               }
                               .frame(width: 60, height: 40)

                               Divider()
                                   .frame(height: 40)
                                
                                Button {
                                    timerStore.send(.startBothTimers)
                                } label: {
                                    Image(systemName: "restart.circle")
                                        .foregroundStyle(.white)
                                }
                                .frame(width: 60, height: 40)
                                .foregroundStyle(.white)
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
                    Spacer()
                    OverlayTopView(timerstore: timerStore, counterStore: counterStore)
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


