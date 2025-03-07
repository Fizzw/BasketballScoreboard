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
    //MARK: - State
    struct State: Equatable {
        var homePoint: Int = 0
        var awayPoint: Int = 0
        
        var quater: Int = 1
        var quaters = [1, 2, 3, 4]
        var selectedQuater: Int = 1
        
        var homeTeampersonnel: [Int] = [5, 6, 7, 8, 9, 10]
        var awayTeampersonnel: [Int] = [5, 6, 7, 8, 9, 10]
        
        var selectedHomeTeampersonnel: Int = 5
        var selectedAwayTeampersonnel: Int = 5
        
        var homeTeamRotations: String = ""
        var awayTeamRotations: String = ""
        
    }
    
    //MARK: - Action
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
        
        case setUpHomeTeampersonnel(Int)
        case setUpAwayTeampersonnel(Int)
        
        case rotationPersonnel(Int)
    }
    
    //MARK: - Dependency
    @Dependency(\.userDefaultsClient) var userDefaultsClient
    
    //MARK: - Reduce
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
                
            case let .setUpHomeTeampersonnel(personnel):
                state.selectedHomeTeampersonnel = personnel
                
                return .none
                
            case let .setUpAwayTeampersonnel(personnel):
                state.selectedAwayTeampersonnel = personnel
                
                return .none
                
            case let .rotationPersonnel(quater):
                state.homeTeamRotations = quarterRotationFormatString(players: state.selectedHomeTeampersonnel, quarter: quater)
                state.awayTeamRotations = quarterRotationFormatString(players: state.selectedAwayTeampersonnel, quarter: quater)
                
                return .none
            }
        }
    }
    
    //MARK: - private Functions
    private func quarterRotationFormatString(players: Int, quarter: Int) -> String {
        var result: [[Int]] = []
        let rotation = Array(1...players)
        
        var lastIndex = 5
        
        var currentQuarter = Array(rotation.prefix(5))
        result.append(currentQuarter)
        
        for _ in 1..<quarter {
            let nextFive = (0..<5).map { rotation[(lastIndex + $0) % players] }
            result.append(nextFive)
            lastIndex = (lastIndex + 5) % players
        }
        
        if quarter < 1 || quarter > result.count {
            return "해당 쿼터 없음"
        }
        
        return  result[quarter - 1].map { String($0) }.joined(separator: ", ")
    }
}
