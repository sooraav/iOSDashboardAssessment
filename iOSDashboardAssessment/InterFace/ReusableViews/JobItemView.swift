//
//  JobItemView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 18/05/24.
//

import SwiftUI
import SampleData

struct JobItemView: View {
    
    let model: JobApiModel
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("#\(model.jobNumber)")
            Text(model.title)
            Text("\(model.startTime) -> \(model.endTime)")
        }
    }
}
