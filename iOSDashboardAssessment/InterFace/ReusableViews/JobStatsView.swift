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
       
        VStack(alignment: .leading){
            Text(model.title)
                .padding(.leading, 10)
            Divider()
            HorizontalSplitBarView(model: model)
            LazyVGrid(columns: columns) {
        
                ForEach(model.barInfo, id: \.name) { barInfo in
                    if let count = barInfo.count {
                        HStack {
                            barInfo.colour
                                .frame(width: 20, height: 20)
                                .cornerRadius(5)
                            Text(String(format: barInfo.name, count))
                            
                        }
                    }
                    
                }
                
            }
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: ViewTraits.cornerRadius))
        .overlay {
            RoundedRectangle(cornerRadius: ViewTraits.cornerRadius)
                .strokeBorder(Color.black)
        }
        
    }
}

let barInfo = [BarModel(name: "Hello (%d)", count: 10, colour: .red),
               BarModel(name: "Hi", count: 5, colour: .blue),
               BarModel(name: "Aloha", count: 3, colour: .green)
]

#Preview {
    StatsView(model: StatsModel(barInfo: barInfo, title: "Job Stats", total: 10, totalText: "total Text", inProgressText: "inProgressText"))
}
