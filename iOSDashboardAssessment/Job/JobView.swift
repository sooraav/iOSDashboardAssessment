//
//  JobView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 18/05/24.
//

import SwiftUI

struct JobView<Model>: View where Model: JobInterface {
    
    @StateObject var viewModel: Model
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Divider()
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
            .background(Color(.systemGray6))
        }
        .onAppear {
            viewModel.getSegments()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading)  {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .bold()
                            .foregroundColor(.black)
                    })
                    
                    Text ("Jobs")
                        .bold()
                        .foregroundStyle(.black)
                }
                
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.white, for: .navigationBar)
    }
}
