//
//  HorizontalSplitBarView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 17/05/24.
//

import SwiftUI

struct HorizontalSplitBarView: View {
    
    let model: StatsModel
    var body: some View {
        VStack {
            HStack {
                Text(model.totalText)
                Spacer()
                Text(model.inProgressText)
            }
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(model.barInfo.sorted(by: {
                        $0.count ?? 0 > $1.count ?? 0
                    }), id: \.name) { bar in
                        Rectangle()
                            .fill(bar.colour)
                            .frame(width: CGFloat(bar.count ?? 0) * geometry.size.width / CGFloat(model.total))
                    }
                }
            }
            .frame(height: 20)
            .cornerRadius(5)
        }
    }
}

#Preview {
    HorizontalSplitBarView(model: StatsModel(barInfo: barInfo, title: "Job Stats", total: 10, totalText: "total Text", inProgressText: "inProgressText"))
}
