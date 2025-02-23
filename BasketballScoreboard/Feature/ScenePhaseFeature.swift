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
    struct State: Equatable {
        var isMenuOpen: Bool = false
    }
    
    enum Action: Equatable  {
        case menuOpen
        case menuClose
    }
    
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
