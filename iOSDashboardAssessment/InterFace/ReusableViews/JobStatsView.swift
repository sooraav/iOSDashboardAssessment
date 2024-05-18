//
//  StatsView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 17/05/24.
//

import SwiftUI

struct StatsView: View {
    
    let model: StatsModel
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
       
        VStack(alignment: .leading){
            Text(model.type == .job ? "Job Stats": "InVoiceStats")
                .padding(.leading, 10)
            Divider()
            
            LazyVGrid(columns: columns) {
        
                ForEach(model.barInfo, id: \.name) { barInfo in
                    if let count = barInfo.count {
                        let countText = model.type == .job ? " (\(count))" : " ($\(count))"
                        HStack {
                            barInfo.colour
                                .frame(width: 20, height: 20)
                                .cornerRadius(5)
                            Text(barInfo.name + countText)
                            
                        }
                    }
                    
                }
                
            }
        }
        
    }
}

let barInfo = [BarModel(name: "Hello", count: 10, colour: .red),
               BarModel(name: "Hi", count: 5, colour: .blue),
               BarModel(name: "Aloha", count: 3, colour: .green)
]
#Preview {
    StatsView(model: StatsModel(barInfo: barInfo, type: .job))
}
