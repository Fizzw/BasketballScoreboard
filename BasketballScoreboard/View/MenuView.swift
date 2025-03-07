//
//  MenuView.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/25.
//

import SwiftUI

import ComposableArchitecture

struct MenuView: View {
    
    //MARK: - Store
    let scenePhaseStore: StoreOf<ScenePhaseFeature>
    let counterStore: StoreOf<CounterFeature>
    let colorPickerStore: StoreOf<ColorPickerFeature>
    let timerStore: StoreOf<TimerFeature>
    
    //MARK: - Environments
    @Environment(\.presentationMode) var presentationMode
     
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text("쿼터 수: \(counterStore.selectedQuater) 쿼터")
                    Spacer()
                    WithViewStore(counterStore, observe: { $0 }) { viewStore in
                        Picker("", selection: viewStore.binding(
                            get: { $0.selectedQuater },
                            send: { .selectQuater($0) }
                        )) {
                            ForEach(viewStore.quaters, id: \.self) { quaters in
                                Text("\(quaters)쿼터").tag(quaters)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        .frame(width: 300)
                    }
                }
                .frame(height: 150)
                
                HStack {
                    Text("쿼터 당 시간: \(timerStore.selectedMinutesPerQuater) 분")
                    Spacer()
                    WithViewStore(timerStore, observe: { $0 }) { viewStore in
                        Picker("", selection: viewStore.binding(
                            get: { $0.selectedMinutesPerQuater },
                            send: { .selectQuaterTime($0) }
                        )) {
                            ForEach(viewStore.minutsPerQuater, id: \.self) { minute in
                                Text("\(minute)분").tag(minute)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        .frame(width: 300)
                    }
                }
                .frame(height: 150)
                
                HStack {
                    Text("쿼터 간 쉬는 시간: \(timerStore.selectedMinutesPerRelax) 분")
                    Spacer()
                    WithViewStore(timerStore, observe: { $0 }) { viewStore in
                        Picker("", selection: viewStore.binding(
                            get: { $0.selectedMinutesPerRelax },
                            send: { .selectRelaxTime($0) }
                        )) {
                            ForEach(viewStore.minutsPerRelax, id: \.self) { minute in
                                Text("\(minute)분").tag(minute)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        .frame(width: 300)
                    }
                }
                .frame(height: 150)
                
                HStack {
                    Text("Home Team 색상 선택")
                    WithViewStore(colorPickerStore, observe: \.homeTeamSelectedColor) { viewStore in
                        ColorPicker("", selection: viewStore.binding(
                            get: { $0 },
                            send: { .homeSelectColor($0) }
                        ))
                        .padding()
                        .frame(height: 100)
                    }
                }
                .frame(height: 150)
                
                HStack {
                    Text("Away Team 색상 선택")
                    WithViewStore(colorPickerStore, observe: \.awayTeamSelectedColor) { viewStore in
                        ColorPicker("", selection: viewStore.binding(
                            get: { $0 },
                            send: { .awaySelectColor($0) }
                        ))
                        .padding()
                        .frame(height: 100)
                    }
                }
                .frame(height: 150)
                
                HStack {
                    Text("Home Team 인원 설정: \(counterStore.selectedHomeTeampersonnel)명")
                    Spacer()
                    WithViewStore(counterStore, observe: { $0 }) { viewStore in
                        Picker("", selection: viewStore.binding(
                            get: { $0.selectedHomeTeampersonnel },
                            send: { .setUpHomeTeampersonnel($0) }
                        )) {
                            ForEach(viewStore.homeTeampersonnel, id: \.self) { personnel in
                                Text("\(personnel)명").tag(personnel)
                            }
                        }
                        .pickerStyle(.wheel)
                        .padding()
                        .frame(width: 150)
                    }
                    .frame(height: 150)
                }
                
                HStack {
                    Text("Away Team 인원 설정: \(counterStore.selectedAwayTeampersonnel)명")
                    Spacer()
                    WithViewStore(counterStore, observe: { $0 }) { viewStore in
                        Picker("", selection: viewStore.binding(
                            get: { $0.selectedAwayTeampersonnel },
                            send: { .setUpAwayTeampersonnel($0) }
                        )) {
                            ForEach(viewStore.awayTeampersonnel, id: \.self) { personnel in
                                Text("\(personnel)명").tag(personnel)
                            }
                        }
                        .pickerStyle(.wheel)
                        .padding()
                        .frame(width: 150)
                    }
                }
                .frame(height: 150)
                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white) 
                    .imageScale(.large)
            })
        }
    }
}
