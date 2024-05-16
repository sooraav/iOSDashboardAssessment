//
//  GreetingsView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 16/05/24.
//

import SwiftUI

struct GreetingsView: View {
    
    private struct ViewTraits {
        
        static let sidePadding: CGFloat = 20.0
        static let cornerRadius: CGFloat = 8.0
    }
    
    let model: GreetingsModel
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
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
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: ViewTraits.cornerRadius))
        .overlay {
            RoundedRectangle(cornerRadius: ViewTraits.cornerRadius)
                .strokeBorder(Color.black)
        }
        .padding(20)
    }
}


#Preview {
    GreetingsView(model: GreetingsModel(name: "Sourav", date: "17th July"))
}
