//
//  HorizontalSplitBarView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 17/05/24.
//

import SwiftUI

struct HorizontalSplitBarView: View {
    
    private struct ViewTraits {
        static let textBottomPadding: CGFloat = 10
        
        static let barHeight: CGFloat = 15
        static let barCornerRadius: CGFloat = 3.5
    }
    let model: StatsModel
    var body: some View {
        VStack(spacing: .zero) {
            HStack {
                Text(model.totalText)
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray))
                    .bold()
                Spacer()
                Text(model.inProgressText)
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray))
                    .bold()
            }
            .padding(.bottom, ViewTraits.textBottomPadding)
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
            .frame(height: ViewTraits.barHeight)
            .cornerRadius(ViewTraits.barCornerRadius)
        }
    }
}

#Preview {
    HorizontalSplitBarView(model: StatsModel(barInfo: barInfo, title: "Job Stats", total: 10, totalText: "total Text", inProgressText: "inProgressText", type: .job))
}
