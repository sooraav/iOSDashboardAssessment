//
//  StatsView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 17/05/24.
//

import SwiftUI

struct StatsView: View {
    
    private struct ViewTraits {
        
        static let sidePadding: CGFloat = 20.0
        static let cornerRadius: CGFloat = 8.0
    }
    
    let model: StatsModel
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
       
        VStack(alignment: .leading, spacing: 5){
            Text(model.title)
                .padding(.leading, 10)
                .foregroundStyle(.black)
                .bold()
                .font(.subheadline)
            Divider()
            HorizontalSplitBarView(model: model)
                .padding(.horizontal, 10)
            LazyVGrid(columns: columns) {
        
                ForEach(model.barInfo, id: \.name) { barInfo in
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
            .padding(.horizontal, 10)
        }
        .padding(.vertical, 10)
        .addWhiteBackgroundAndCorner(cornerRadius: ViewTraits.cornerRadius)
        
    }
}

let barInfo = [BarModel(name: "Hello (%d)", count: 10, colour: .red),
               BarModel(name: "Hi", count: 5, colour: .blue),
               BarModel(name: "Aloha", count: 3, colour: .green)
]

#Preview {
    StatsView(model: StatsModel(barInfo: barInfo, title: "Job Stats", total: 10, totalText: "total Text", inProgressText: "inProgressText"))
}
