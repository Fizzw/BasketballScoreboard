//
//  OverlayCounterView.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/210.
//

import SwiftUI
import ComposableArchitecture

struct OverlayCounterView: View {
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
                       .frame(width: 160, height: 40)

                   HStack(spacing: 20) {
                       Button("14초") {
                           timerStore.send(.startShotClock(14))
                       }
                       .foregroundColor(.white)
                       Divider()
                           .frame(height: 40)
                       Button("reset") {
                           timerStore.send(.startShotClock(24))
                       }
                       .foregroundColor(.green)
                   }
               }
               .padding(.horizontal, 20)
                
                Spacer()
                
                if counterStore.quater == 1 || counterStore.quater == 2 {
                    Button(action: {
                        counterStore.send(.getTwoPointsAwayTeam)
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
