//
//  TimerFeature.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct TimerFeature {
    @ObservableState
    // MARK: - State
    struct State: Equatable {
        static func == (lhs: State, rhs: State) -> Bool {
           return lhs.remainingTime == rhs.remainingTime &&
                  lhs.isRunning == rhs.isRunning
       }
        
        var remainingTime: Int = 0
        var isRunning: Bool = false
        var isQuaterTimeRunning: Bool = false
        var buzzerSound: BuzzerSound = .init()
        var shotClockTime: Int = 0
        var currentTime: String = ""
        
        var selectedMinutesPerQuater: Int = 8
        var selectedMinutesPerRelax: Int = 2
        var minutsPerQuater = [8, 10]
        var minutsPerRelax = [2, 5]
        var isShotClockTimerRunning: Bool = false
        var isbreakTime: Bool = false
    }
    
    @Dependency(\.userDefaultsClient) var userDefaultsClient

    // MARK: - Action
    enum Action: Equatable {
        case startTimer
        case startBreakTimer
        case startShotClock(Int)
        case restartTimer
        case tick
        
        case shotClockTick
        case breakTimeClockTick
        case stopTimer
        case playBuzzer
        
        case startBothTimers(Bool)
        case stopBothTimers
        case restartBothTimers
        
        case updateCurrentTime(String)
        case startCurrentTimer
        
        case selectQuaterTime(Int)
        case selectRelaxTime(Int)
        case loadSavedTime
        
        case stopQuaterTimeRunning
    }
    
    struct TimerID: Hashable {}
    struct ShotClockID: Hashable {}
    struct BreakTimerID: Hashable {}
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case let .startBothTimers(restart):
                
                if restart {
                    state.remainingTime = state.selectedMinutesPerQuater * 60
                    state.shotClockTime = 24
                    state.isRunning = false
                    state.isShotClockTimerRunning = false
                    
                    return .none
                } else {
                    state.remainingTime = state.selectedMinutesPerQuater * 60
                    state.shotClockTime = 24
                    state.isRunning = true
                    state.isShotClockTimerRunning = true
                    
                    return .merge(
                        startCountdown(),
                        startShotClockCountdown()
                    )
                }
                
            case .startBreakTimer:
                state.remainingTime = state.selectedMinutesPerRelax * 60
                state.isbreakTime = true
                
                return .merge(
                    startBreakTimeCountDown()
                )
            case .stopBothTimers:
                state.isRunning = false
                state.isShotClockTimerRunning = false
                return .merge(
                    .cancel(id: TimerID()),
                    .cancel(id: ShotClockID())
                )

            case .restartBothTimers:
                guard state.remainingTime > 0 else { return .none }
                state.isRunning = true
                state.isShotClockTimerRunning = true
                return .merge(
                    startCountdown(),
                    startShotClockCountdown()
                )

            case .tick:
                if state.remainingTime > 0 {
                    state.remainingTime -= 1
                } else {
                    state.isRunning = false
                    return .concatenate(
                        .cancel(id: TimerID()),
                        .send(.playBuzzer)
                    )
                }
                
                return .none

            case .shotClockTick:
                if state.shotClockTime > 0 {
                    state.shotClockTime -= 1
                } else {
                    state.shotClockTime = 24
                    
                    return .run { send in
                        await send(.stopBothTimers)
                    }
                }
                
                return .none
            case .startTimer:
                state.remainingTime = state.selectedMinutesPerQuater * 60
                state.isRunning = true
                state.isQuaterTimeRunning = true

                return .run { send in
                    for await _ in Timer.publish(every: 1, on: .main, in: .common).autoconnect().values {
                        await send(.tick)
                        await send(.stopQuaterTimeRunning)
                    }
                }
                .cancellable(id: TimerID(), cancelInFlight: true)

            case let .startShotClock(shotClockTime):
                state.shotClockTime = shotClockTime
                
                return .run { send in
                    await send(.stopBothTimers)
                }
                
            case .breakTimeClockTick:
                
                return .run { send in
                    await send(.stopBothTimers)
                }
                
                
                
            case .restartTimer:
                          guard state.remainingTime > 0 else { return .none } // 남은 시간이 있을 때만 실행
                          state.isRunning = true
                state.isQuaterTimeRunning = true
                          return startCountdown()

            case .tick:
                print("tick")
                if state.remainingTime > 0 {
                    state.remainingTime -= 1
                    
                } else {
                    state.isRunning = false
                    return .concatenate(
                        .cancel(id: TimerID()), // 타이머 정지
                        .send(.playBuzzer) // 부저 소리 재생
                    )
                }
                
                return .none
                
            case .shotClockTick:
                if state.shotClockTime > 0 {
                    state.shotClockTime -= 1
                    if state.shotClockTime == 0 {
                        state.shotClockTime = 24
                        return .run { send in
                            await send(.stopTimer)
                        }
                    }
                } else {
                    state.isShotClockTimerRunning = false
                    return .concatenate(
                        .cancel(id: TimerID()),
                        .send(.playBuzzer)
                    )
                }
                return .none
                

            case .stopTimer:
                state.isRunning = false
                
                return .cancel(id: TimerID())

            case .playBuzzer:
                state.buzzerSound.play()
                
                return .none
                
            case let .updateCurrentTime(time):
                state.currentTime = time
        
                return .none

            case .startCurrentTimer:
                return .run { send in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm:ss"

                    for await _ in Timer.publish(every: 1, on: .main, in: .common).autoconnect().values {
                        let newTime = formatter.string(from: Date())
                        await send(.updateCurrentTime(newTime))
                    }
                }
                
            case let .selectQuaterTime(quaterTime):
                state.selectedMinutesPerQuater = quaterTime
                userDefaultsClient.setQuarterTime(quaterTime)
                
                return .none
     
                
            case let .selectRelaxTime(relaxTime):
                state.selectedMinutesPerRelax = relaxTime
                userDefaultsClient.setQuarterBreakTime(relaxTime)
                
                return .none

            case .loadSavedTime:
                if let savedQuaterTime = userDefaultsClient.getQuarterTime() {
                    state.selectedMinutesPerQuater = savedQuaterTime
                }
                if let savedRelaxTime = userDefaultsClient.getQuarterBreakTime() {
                    state.selectedMinutesPerRelax = savedRelaxTime
                }
                
                return .none
                
            case .stopQuaterTimeRunning:
                if state.remainingTime == 0 {
                    state.isQuaterTimeRunning = false
                }
                
                return .none
            }
        }
    }
    private func startCountdown() -> Effect<Action> {
        .run { send in
            for await _ in Timer.publish(every: 1, on: .main, in: .common).autoconnect().values {
                await send(.tick)
            }
        }
        .cancellable(id: TimerID(), cancelInFlight: true)
    }

    private func startShotClockCountdown() -> Effect<Action> {
        .run { send in
            for await _ in Timer.publish(every: 1, on: .main, in: .common).autoconnect().values {
                await send(.shotClockTick)
            }
        }
        .cancellable(id: ShotClockID(), cancelInFlight: true)
    }
    
    private func startBreakTimeCountDown() -> Effect<Action> {
        .run { send in
            for await _ in Timer.publish(every: 1, on: .main, in: .common).autoconnect().values {
                await send(.shotClockTick)
            }
        }
        .cancellable(id: BreakTimerID(), cancelInFlight: true)
    }
}



