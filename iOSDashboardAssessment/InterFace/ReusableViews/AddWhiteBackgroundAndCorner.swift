//
//  whiteBackgroundAndCorner.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 19/05/24.
//

import SwiftUI

struct AddWhiteBackgroundAndCorner: ViewModifier {
    let cornerRadius: CGFloat
    func body(content: Content) -> some View {
        
        content
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(Color(.systemGray5))
            }
            .background(.white)
            .cornerRadius(cornerRadius)
    }
}
extension View {
    func addWhiteBackgroundAndCorner(cornerRadius: CGFloat) -> some View {
        modifier(AddWhiteBackgroundAndCorner(cornerRadius: cornerRadius))
    }
}
