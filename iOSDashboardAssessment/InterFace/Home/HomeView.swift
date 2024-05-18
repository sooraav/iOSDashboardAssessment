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
            NavigationView {
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    VStack {
                        Text("Dashboard")
                            .bold()
                    }
                }
            }
            .toolbarBackground(.white)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
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

