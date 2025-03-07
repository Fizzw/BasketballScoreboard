//
//  ScenePhaseFeature.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/25.
//

import ComposableArchitecture

@Reducer
struct ScenePhaseFeature {
    
    @ObservableState
    //MARK: - State
    struct State: Equatable {
        var isMenuOpen: Bool = false
    }
    
    //MARK: - Action
    enum Action: Equatable  {
        case menuOpen
        case menuClose
    }
    
    //MARK: - Reduce
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .menuOpen:
                state.isMenuOpen = true
                
                return .none
                
            case .menuClose:
                state.isMenuOpen = false
                
                return .none
            }
        }
    }
}
