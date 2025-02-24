//
//  OverlayBottomView.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/21/25.
//

import ComposableArchitecture
import SwiftUI

struct OverlayBottomView: View {
    let counterStore: StoreOf<CounterFeature>
    let timerStore: StoreOf<TimerFeature>
    let colorPickerStore: StoreOf<ColorPickerFeature>
    var body: some View {
        HStack {
            Spacer()
            VStack {
                if counterStore.quater == 3 || counterStore.quater == 4 {
                    Text("Away")
                           .padding(2)
                           .background(RoundedRectangle(cornerRadius: 5).fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5)))
                                       .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                                       
                       
                       Text(String(format: "%02d", counterStore.awayPoint))
                           .font(.custom("Seven Segment", size: 100))
                           .foregroundStyle(colorPickerStore.awayTeamSelectedColor)
                           .frame(width: 150)
                } else {
                    Text("Home")
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 5).fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5)))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    
                    Text(String(format: "%02d", counterStore.homePoint))
                        .font(.custom("Seven Segment", size: 100))
                        .foregroundStyle(colorPickerStore.homeTeamSelectedColor)
                        .frame(width: 150)
                }
            }
            Spacer()
            VStack {
                Text(String(format: "%02d", timerStore.shotClockTime))
                 .font(.custom("Seven Segment", size: 100))
                 .frame(width: 150)
                 .foregroundStyle(.red)
            }
            Spacer()
            VStack {
                if counterStore.quater == 3 || counterStore.quater == 4 {
                    Text("Home")
                           .padding(2)
                           .background(RoundedRectangle(cornerRadius: 5).fill(colorPickerStore.homeTeamSelectedColor.opacity(0.5)))
                                       .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                       
                       Text(String(format: "%02d", counterStore.homePoint))
                           .font(.custom("Seven Segment", size: 100))
                           .foregroundStyle(colorPickerStore.homeTeamSelectedColor)
                           .frame(width: 150)
                } else {
                    Text("Away")
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 5).fill(colorPickerStore.awayTeamSelectedColor.opacity(0.5)))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    
                    
                    Text(String(format: "%02d", counterStore.awayPoint))
                        .font(.custom("Seven Segment", size: 100))
                        .foregroundStyle(colorPickerStore.awayTeamSelectedColor)
                        .frame(width: 150)
                }
                   
            }
            Spacer()
        }
    }
     
     private func timeString(from seconds: Int) -> String {
         let minutes = seconds / 60
         let seconds = seconds % 60
         return String(format: "%02d:%02d", minutes, seconds)
     }
    
    private func hapticImpact() {
        let style = UIImpactFeedbackGenerator.FeedbackStyle.heavy 
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
