//
//  UserDefaultsClient.swift
//  BasketballCounter
//
//  Created by 박정우 on 2/22/25.
//



import SwiftUI
import UIKit

import ComposableArchitecture

struct UserDefaultsClient {
    var homeSetColor: (Color) -> Void
    var homeGetColor: () -> Color?
    var awaySetColor: (Color) -> Void
    var awayGetColor: () -> Color?

    var setQuarterCount: (Int) -> Void
    var getQuarterCount: () -> Int?
    var setQuarterTime: (Int) -> Void
    var getQuarterTime: () -> Int?
    var setQuarterBreakTime: (Int) -> Void
    var getQuarterBreakTime: () -> Int?
}

extension UserDefaultsClient: DependencyKey {
    static let liveValue = UserDefaultsClient(
        homeSetColor: { color in
            let uiColor = UIColor(color)
            let codableColor = CodableColor(color: uiColor)
            if let data = try? JSONEncoder().encode(codableColor) {
                UserDefaults.standard.set(data, forKey: "homeTeamSelectedColor")
            }
        },
        homeGetColor: {
            guard let data = UserDefaults.standard.data(forKey: "homeTeamSelectedColor"),
                  let codableColor = try? JSONDecoder().decode(CodableColor.self, from: data) else {
                return nil
            }
            return Color(codableColor.toUIColor())
        },
        awaySetColor: { color in
            let uiColor = UIColor(color)
            let codableColor = CodableColor(color: uiColor)
            if let data = try? JSONEncoder().encode(codableColor) {
                UserDefaults.standard.set(data, forKey: "awayTeamSelectedColor")
            }
        },
        awayGetColor: {
            guard let data = UserDefaults.standard.data(forKey: "awayTeamSelectedColor"),
                  let codableColor = try? JSONDecoder().decode(CodableColor.self, from: data) else {
                return nil
            }
            return Color(codableColor.toUIColor())
        },
        setQuarterCount: { count in
            UserDefaults.standard.set(count, forKey: "quarterCount")
        },
        getQuarterCount: {
            UserDefaults.standard.integer(forKey: "quarterCount")
        },
        setQuarterTime: { time in
            UserDefaults.standard.set(time, forKey: "quarterTime")
        },
        getQuarterTime: {
            UserDefaults.standard.integer(forKey: "quarterTime")
        },
        setQuarterBreakTime: { time in
            UserDefaults.standard.set(time, forKey: "quarterBreakTime")
        },
        getQuarterBreakTime: {
            UserDefaults.standard.integer(forKey: "quarterBreakTime")
        }
    )
}

extension DependencyValues {
    var userDefaultsClient: UserDefaultsClient {
        get { self[UserDefaultsClient.self] }
        set { self[UserDefaultsClient.self] = newValue }
    }
}

struct CodableColor: Codable {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat

    init(color: UIColor) {
        let components = color.cgColor.components ?? [0, 0, 0, 1]
        self.red = components[0]
        self.green = components.count > 2 ? components[1] : components[0]
        self.blue = components.count > 2 ? components[2] : components[0]
        self.alpha = components.count > 3 ? components[3] : 1.0
    }

    func toUIColor() -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension CodableColor {
    static let predefinedColors: [Color] = [
        .red, .green, .blue, .yellow, .orange,
        .purple, .pink, .cyan, .brown, .gray,
        Color(UIColor.systemTeal), Color(UIColor.systemIndigo)
    ]
}
