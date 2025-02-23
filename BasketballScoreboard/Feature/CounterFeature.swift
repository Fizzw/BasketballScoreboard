//
//  CounterFeature.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/25.
//

import ComposableArchitecture

@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable {
        var homePoint: Int = 0
        var awayPoint: Int = 0
        var quater: Int = 1
        var quaters = [1, 2, 3, 4]
        var selectedQuater: Int = 1
    }
    
    enum Action : Equatable {
        case getOnePointsHomeTeam
        case getTwoPointsHomeTeam
        case getThreePointsHomeTeam
        
        case getOnePointsAwayTeam
        case getTwoPointsAwayTeam
        case getThreePointsAwayTeam
        
        case detuctHomePoint
        case detuctAwayPoint
        
        case nextQuater
        
        case selectQuater(Int)
        case loadSavedQuater
    }
    
    @Dependency(\.userDefaultsClient) var userDefaultsClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .getOnePointsHomeTeam:
                state.homePoint += 1
                
                return .none
                
            case .getTwoPointsHomeTeam:
                state.homePoint += 2
                
                return .none
                
            case .getThreePointsHomeTeam:
                state.homePoint += 3
                return .none
                
            case .getOnePointsAwayTeam:
                state.awayPoint += 1
                return .none
                
            case .getTwoPointsAwayTeam:
                state.awayPoint += 2
                
                return .none
                
            case .getThreePointsAwayTeam:
                state.awayPoint += 3
                
                return .none
            case .detuctHomePoint:
                state.homePoint -= 1
                return .none
                
            case .detuctAwayPoint:
                state.awayPoint -= 1
                
                return .none
                
            case .nextQuater:
                state.quater = (state.quater % state.selectedQuater) + 1
                if state.quater == 1 {
                    state.homePoint = 0
                    state.awayPoint = 0
                }
                return .none
                
            case let .selectQuater(quater):
                state.selectedQuater = quater
                userDefaultsClient.setQuarterCount(quater)
                
                return .none

            case .loadSavedQuater:
                if let savedQuater = userDefaultsClient.getQuarterCount() {
                    state.selectedQuater = savedQuater
                }
                
                return .none
            }
        }
    }
}
