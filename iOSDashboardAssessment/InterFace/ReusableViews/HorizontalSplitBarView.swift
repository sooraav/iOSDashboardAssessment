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
        VStack(spacing: 0) {
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
            .padding(.bottom, 5)
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
            .frame(height: 15)
            .cornerRadius(3.5)
            .padding(.top, 5)
        }
    }
}

#Preview {
    HorizontalSplitBarView(model: StatsModel(barInfo: barInfo, title: "Job Stats", total: 10, totalText: "total Text", inProgressText: "inProgressText"))
}
