//
//  StatsView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 17/05/24.
//

import SwiftUI

struct StatsView: View {
    
    private struct ViewTraits {
        
        static let sidePadding: CGFloat = 10.0
        static let titlePadding: CGFloat = 10.0
        static let splitBarPadding: CGFloat = 10.0
        
        static let cornerRadius: CGFloat = 8.0
        
        static let vStackSpacing: CGFloat = 5.0
    }
    
    let model: StatsModel
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        
        VStack(alignment: .center, spacing: ViewTraits.vStackSpacing) {
            HStack{
                Text(model.title)
                    .padding([.leading, .bottom], ViewTraits.titlePadding)
                    .foregroundStyle(.black)
                    .bold()
                    .font(.subheadline)
                Spacer()
            }
            Divider()
            HorizontalSplitBarView(model: model)
                .padding([.horizontal, .bottom], ViewTraits.splitBarPadding)
            VStack(alignment: .center) {
                
                ForEach(0..<model.barInfo.count, id: \.self) { index in
                    if index % 2 == 0 {
                        HStack {
                            BarKeyView(barInfo: model.barInfo[index])
                            if index + 1 < model.barInfo.count {
                                BarKeyView(barInfo: model.barInfo[index + 1])
                            }
                        }
                    }
                }
            }
        }
        .padding(.vertical, ViewTraits.sidePadding)
        .addWhiteBackgroundAndCorner(cornerRadius: ViewTraits.cornerRadius)
        
    }
}

struct BarKeyView: View {
    
    
    var barInfo: BarModel
    var body: some View {
        VStack {
            if let count = barInfo.count {
                
                HStack {
                    barInfo.colour
                        .frame(width: 10, height: 10)
                        .cornerRadius(2.5)
                    Text(String(format: barInfo.name, count))
                        .foregroundStyle(Color(.systemGray))
                        .bold()
                        .font(.caption)
                    
                }
            }
        }
        
    }
}

let barInfo = [BarModel(name: "Hello (%d)", count: 10, colour: .red),
               BarModel(name: "Hi", count: 5, colour: .blue),
               BarModel(name: "Aloha", count: 3, colour: .green)
]

#Preview {
    StatsView(model: StatsModel(barInfo: barInfo, title: "Job Stats", total: 10, totalText: "total Text", inProgressText: "inProgressText", type: .job))
}
