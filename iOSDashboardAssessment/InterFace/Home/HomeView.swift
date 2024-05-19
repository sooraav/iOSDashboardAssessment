//
//  HomeView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 16/05/24.
//

import SwiftUI

struct HomeView <Model>: View where Model: HomeInterface {
    
    @StateObject var viewModel: Model
    var body: some View {
        NavigationStack {
                ScrollView(.vertical) {
                    VStack {
                        if let greeting = viewModel.greeting {
                            GreetingsView(model: greeting)
                        }
                        ForEach(viewModel.statViews) { statsModel in
                            NavigationLink()  {
                                JobView(viewModel: JobViewModel(statsModel: statsModel, jobByState: viewModel.jobByStatus))
                            }label: {
                                
                                StatsView(model: statsModel)
                            }
                        }
                        Spacer()
                    }
                    .padding(20)
                    
                }
                .background(Color(.systemGray6))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    VStack {
                        Text("Dashboard")
                            .bold()
                            .foregroundStyle(.black)
                    }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.white, for: .navigationBar)
            .onAppear {
                viewModel.getData()
            }
        }
    }
}
/*
#Preview {
    HomeView()
}
 */

