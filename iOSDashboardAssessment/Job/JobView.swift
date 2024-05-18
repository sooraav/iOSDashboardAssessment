//
//  JobView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 18/05/24.
//

import SwiftUI

struct JobView<Model>: View where Model: JobInterface {
    
    @StateObject var viewModel: Model

    var body: some View {
        NavigationView {
            VStack {
                HorizontalSplitBarView(model: viewModel.statsModel)
                Divider()
                ScrollView(.horizontal, showsIndicators: false) {
                    CustomSegmentedControl(segments: viewModel.segments, selected: $viewModel.selected)
                }
                Spacer()
            }
        }
        .onAppear {
            viewModel.getSegments()
        }
        .navigationTitle("Job")
    }
}
