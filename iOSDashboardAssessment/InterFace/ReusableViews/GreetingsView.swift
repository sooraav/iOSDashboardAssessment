//
//  GreetingsView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 16/05/24.
//

import SwiftUI

struct GreetingsView: View {
    
    let model: GreetingsModel
    var body: some View {
        
        HStack {
            VStack {
                Text("Hello, \(model.name)! 👋")
                    .font(.headline)
                Text(model.date)
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.gray)
            }
            Spacer()
            Image(systemName: "person")
                .resizable()
                .frame(width: 50, height: 50)
        }
        .padding(20)
    }
}


#Preview {
    GreetingsView(model: GreetingsModel(name: "Sourav", date: "17th July"))
}
