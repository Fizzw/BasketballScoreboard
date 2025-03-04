//
//  OverlayScoreView.swift
//  BasketballScoreboard
//
//  Created by 박정우 on 3/3/25.
//

import SwiftUI

import ComposableArchitecture

struct OverlayScoreView: View {
    let colorPickerStore: StoreOf<ColorPickerFeature>
    let counterStore: StoreOf<CounterFeature>
    
    var body: some View {
        HStack {
            VStack {
                if counterStore.quater == 3 || counterStore.quater == 4 {
                    Text("Away")
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 5).fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5)))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    
                    
                    Text(String(format: "%02d", counterStore.awayPoint))
                        .font(.custom("Seven Segment", size: 150))
                        .foregroundStyle(colorPickerStore.awayTeamSelectedColor)
                        .frame(width: 200)
                } else {
                    Text("Home")
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 5).fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5)))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    
                    Text(String(format: "%02d", counterStore.homePoint))
                        .font(.custom("Seven Segment", size: 150))
                        .foregroundStyle(colorPickerStore.homeTeamSelectedColor)
                        .frame(width: 200)
                }
            }
            
            Spacer()
            VStack {
                if counterStore.quater == 3 || counterStore.quater == 4 {
                    Text("Home")
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 5).fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5)))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    
                    Text(String(format: "%02d", counterStore.homePoint))
                        .font(.custom("Seven Segment", size: 150))
                        .foregroundStyle(colorPickerStore.homeTeamSelectedColor)
                        .frame(width: 200)
                } else {
                    Text("Away")
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 5).fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5)))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    
                    
                    Text(String(format: "%02d", counterStore.awayPoint))
                        .font(.custom("Seven Segment", size: 150))
                        .foregroundStyle(colorPickerStore.awayTeamSelectedColor)
                        .frame(width: 200)
                }
            }
        }
    }
}
