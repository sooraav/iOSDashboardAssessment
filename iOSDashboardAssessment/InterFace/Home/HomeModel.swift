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

struct StatsModel {
    let barInfo: [BarModel]
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

