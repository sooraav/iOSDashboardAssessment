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
            VStack {
                if let greeting = viewModel.greeting {
                    GreetingsView(model: greeting)
                }
            }
            
        }
        .onAppear {
            viewModel.getData()
        }
        .navigationTitle("Dashboard")
        .navigationBarTitleDisplayMode(.inline)
    }
}
/*
#Preview {
    HomeView()
}
 */

