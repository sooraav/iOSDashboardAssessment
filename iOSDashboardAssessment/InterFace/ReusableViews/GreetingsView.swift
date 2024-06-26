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
        
        static let imageSize: CGFloat = 50
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
            Image("ProfilePhoto")
                .resizable()
                .frame(width: ViewTraits.imageSize, height: ViewTraits.imageSize)
        }
        .padding()
        .addWhiteBackgroundAndCorner(cornerRadius: ViewTraits.cornerRadius)
        
    }
}


#Preview {
    GreetingsView(model: GreetingsModel(name: "Sourav", date: "17th July"))
}
