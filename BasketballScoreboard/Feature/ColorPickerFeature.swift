//
//  ColorPickerFeature.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/22/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct ColorPickerFeature {
    @ObservableState
    struct State: Equatable {
        var homeTeamSelectedColor: Color = .red
        var awayTeamSelectedColor: Color = .red
    }

    enum Action {
        case homeSelectColor(Color)
        case awaySelectColor(Color)
        case loadSavedColor
    }

    @Dependency(\.userDefaultsClient) var userDefaultsClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .homeSelectColor(color):
                state.homeTeamSelectedColor = color
                userDefaultsClient.homeSetColor(color)
                
                return .none
                
            case let .awaySelectColor(color):
                state.awayTeamSelectedColor = color
                userDefaultsClient.awaySetColor(color)
                
                return .none

            case .loadSavedColor:
                if let savedColor = userDefaultsClient.homeGetColor() {
                    state.homeTeamSelectedColor = savedColor
                }
                
                if let savedColor = userDefaultsClient.awayGetColor() {
                    state.awayTeamSelectedColor = savedColor
                }
                
                return .none
            }
        }
    }
}
