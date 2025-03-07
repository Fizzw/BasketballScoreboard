//
//  OverlayRestTimeView.swift
//  BasketballScoreboard
//
//  Created by 박정우 on 3/6/25.
//

import SwiftUI

import ComposableArchitecture

struct OverlayRestTimeView: View {
    
    //MARK: - Store
    let timerStore: StoreOf<TimerFeature>
    let counterStore: StoreOf<CounterFeature>
    let colorPickerStore: StoreOf<ColorPickerFeature>
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                ZStack {
                    Text("88:88")
                        .font(.system(size: 250).monospacedDigit())
                        .frame(width: 800, height: 300)
                        .opacity(0)
                    
                    Text(timeString(from: timerStore.breakTime))
                        .font(.system(size: 250).monospacedDigit())
                        .tracking(0)
                        .kerning(0)
                        .frame(minWidth: 800, maxWidth: 800, alignment: .center)
                        .frame(height: 300)
                        .background(Color.clear)
                        .lineLimit(1)
                        .minimumScaleFactor(1.0)
                        .baselineOffset(0)
                        .fixedSize(horizontal: true, vertical: true)
                        .foregroundStyle(.white)
                        .animation(nil, value: timerStore.breakTime)
                }
                .frame(width: 800, height: 300)
                .onTapGesture(count: 5) {
                    timerStore.send(.forceStopBreakTimer)
                    hapticImpact()
                }

                HStack {
                    VStack {
                        if counterStore.quater == 3 || counterStore.quater == 4 {
                            VStack {
                                Group {
                                    Text("Away Team Starting Member")
                                    Text("\(counterStore.awayTeamRotations)")
                                }
                                .font(.system(.title2))
                                .font(.system(size: 25))
                                
                                Spacer()
                            }
                        } else {
                            VStack {
                                Group {
                                    Text("Home Team Starting Member")
                                    Text("\(counterStore.homeTeamRotations)")
                                }
                                .font(.system(.title2))
                                .font(.system(size: 25))
                            }
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    HStack {
                        if timerStore.breakTime > 60 {
                            Text("Break time")
                        } else {
                            Text("곧 \(counterStore.quater)쿼터 시작")
                        }
                        BouncingDotsRightView()
                    }
                    Spacer()
                    
                    if counterStore.quater == 3 || counterStore.quater == 4 {
                        VStack {
                            Group {
                                Text("Home Team Starting Member")
                                Text("\(counterStore.homeTeamRotations)")
                            }
                            .font(.system(.title2))
                            .font(.system(size: 25))
                            
                        }
                    } else {
                        VStack {
                            Group {
                                Text("Away Team Starting Member")
                                Text("\(counterStore.awayTeamRotations)")
                            }
                            .font(.system(.title2))
                            .font(.system(size: 25))
                            
                            Spacer()
                        }
                    }
                }
                .onAppear {
                    counterStore.send(.rotationPersonnel(counterStore.quater))
                }
            }
        }
    }
}
