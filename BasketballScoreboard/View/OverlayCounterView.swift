//
//  OverlayCounterView.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/210.
//

import ComposableArchitecture

import SwiftUI

struct OverlayCounterView: View {
    
    //MARK: - Store
    let counterStore: StoreOf<CounterFeature>
    let colorPickerStore: StoreOf<ColorPickerFeature>
    let timerStore: StoreOf<TimerFeature>
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                if counterStore.quater == 1 || counterStore.quater == 2 {
                    Button(action: {
                        counterStore.send(.detuctHomePoint)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("-1점")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Button(action: {
                        counterStore.send(.getOnePointsHomeTeam)
                        timerStore.send(.stopBothTimers)
                        timerStore.send(.startShotClock(24))
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("1점")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Button(action: {
                        counterStore.send(.getThreePointsHomeTeam)
                        timerStore.send(.stopBothTimers)
                        timerStore.send(.startShotClock(24))
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("3점")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Button(action: {
                        counterStore.send(.getTwoPointsHomeTeam)
                        timerStore.send(.stopBothTimers)
                        timerStore.send(.startShotClock(24))
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("2점")
                                .foregroundStyle(.white)
                        }
                    }
                } else {
                    Button(action: {
                        counterStore.send(.detuctAwayPoint)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("-1점")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Button(action: {
                        counterStore.send(.getOnePointsAwayTeam)
                        timerStore.send(.stopBothTimers)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("1점")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Button(action: {
                        counterStore.send(.getThreePointsAwayTeam)
                        timerStore.send(.stopBothTimers)
                        timerStore.send(.startShotClock(24))
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("3점")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Button(action: {
                        counterStore.send(.getTwoPointsAwayTeam)
                        timerStore.send(.stopBothTimers)
                        timerStore.send(.startShotClock(24))
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("2점")
                                .foregroundStyle(.white)
                        }
                    }
                }
                Spacer()
                
                ZStack {
                   RoundedRectangle(cornerRadius: 6)
                       .fill(Color.gray.opacity(0.2))
                       .frame(width: 80, height: 40)

                    HStack {
                       Button {
                           timerStore.send(.playBuzzer)
                       } label: {
                           Image(systemName: "speaker.wave.2")
                               .foregroundStyle(.white)
                       }
                       .frame(width: 60, height: 40)

                   }
               }
               .padding(.horizontal, 20)
                
                ZStack {
                   RoundedRectangle(cornerRadius: 6)
                       .fill(Color.gray.opacity(0.2))
                       .frame(width: 80, height: 40)

                    HStack {
                        Button("14초") {
                            timerStore.send(.startShotClock(14))
                        }
                        .frame(width: 60, height: 40)
                        .foregroundColor(.white)
                   }
               }
               .padding(.horizontal, 20)
                
                ZStack {
                   RoundedRectangle(cornerRadius: 6)
                       .fill(Color.gray.opacity(0.2))
                       .frame(width: 80, height: 40)

                    HStack {
                        Button("reset") {
                            timerStore.send(.startShotClock(24))
                        }
                        .frame(width: 60, height: 40)
                        .foregroundColor(.green)
                   }
               }
               .padding(.horizontal, 20)
                
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
                
                Spacer()
                
                if counterStore.quater == 1 || counterStore.quater == 2 {
                    Button(action: {
                        counterStore.send(.getTwoPointsAwayTeam)
                        timerStore.send(.stopBothTimers)
                        timerStore.send(.startShotClock(24))
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("2점")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    
                    Button(action: {
                        counterStore.send(.getThreePointsAwayTeam)
                        timerStore.send(.stopBothTimers)
                        timerStore.send(.startShotClock(24))
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("3점")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Button(action: {
                        counterStore.send(.getOnePointsAwayTeam)
                        timerStore.send(.stopBothTimers)
                        timerStore.send(.startShotClock(24))
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("1점")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Button(action: {
                        counterStore.send(.detuctAwayPoint)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5))
                                .frame(width: 40, height: 40)
                            Text("-1점")
                                .foregroundStyle(.white)
                        }
                    }
                } else {
                        Button(action: {
                            counterStore.send(.getTwoPointsHomeTeam)
                            timerStore.send(.stopBothTimers)
                            timerStore.send(.startShotClock(24))
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5))
                                    .frame(width: 40, height: 40)
                                Text("2점")
                                    .foregroundStyle(.white)
                            }
                        }
                        
                        
                        Button(action: {
                            counterStore.send(.getThreePointsHomeTeam)
                            timerStore.send(.stopBothTimers)
                            timerStore.send(.startShotClock(24))
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5))
                                    .frame(width: 40, height: 40)
                                Text("3점")
                                    .foregroundStyle(.white)
                            }
                        }
                        
                        Button(action: {
                            counterStore.send(.getOnePointsHomeTeam)
                            timerStore.send(.stopBothTimers)
                            timerStore.send(.startShotClock(24))
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5))
                                    .frame(width: 40, height: 40)
                                Text("1점")
                                    .foregroundStyle(.white)
                            }
                        }
                        
                        Button(action: {
                            counterStore.send(.detuctHomePoint)
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5))
                                    .frame(width: 40, height: 40)
                                Text("-1점")
                                    .foregroundStyle(.white)
                            }
                        }
                }
            }
        }
    }
}
