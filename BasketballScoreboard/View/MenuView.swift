//
//  MenuView.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/25.
//

import SwiftUI

import ComposableArchitecture

struct MenuView: View {
    let scenePhaseStore: StoreOf<ScenePhaseFeature>
    let counterStore: StoreOf<CounterFeature>
    let colorPickerStore: StoreOf<ColorPickerFeature>
    let timerStore: StoreOf<TimerFeature>
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
