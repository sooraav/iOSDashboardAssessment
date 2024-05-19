//
//  HomeModel.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 16/05/24.
//

import Foundation
import SwiftUI

struct GreetingsModel {
    let name: String
    let date: String
}

struct StatsModel: Identifiable {
    let id = UUID()
    let barInfo: [BarModel]
    let title: String
    let total: Int
    let totalText: String
    let inProgressText: String
    let type: StatType
}

struct BarModel {
    let name: String
    let count: Int?
    let colour: Color
}

enum StatType {
    case job, amount
}

