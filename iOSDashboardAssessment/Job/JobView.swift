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
            VStack(alignment: .leading) {
                HorizontalSplitBarView(model: viewModel.statsModel)
                Divider()
                if let selected = viewModel.selected {
                    ScrollView(.horizontal, showsIndicators: false) {
                        CustomSegmentedControl(segments: viewModel.segments, selected: $viewModel.selected)
                    }
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(selected.items, id: \.id) { item in
                                
                                JobItemView(model: item)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.getSegments()
        }
        .navigationTitle("Job")
    }
}
