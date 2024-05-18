//
//  CustomSegmentedControl.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 18/05/24.
//

import SwiftUI

struct CustomSegmentedControl: View {
    
    let segments: [SegmentModel]
    @Binding var selected: SegmentModel?
    @Namespace var name
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(segments, id: \.title) { segment in
                Button {
                    selected = segment
                } label: {
                    VStack {
                        Text(segment.title)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundColor(selected?.title == segment.title ? .black : Color(uiColor: .systemGray))
                            .padding(.horizontal, 10)
                        ZStack {
                            Divider()
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 4)
                            if selected?.title == segment.title {
                                Capsule()
                                    .fill(Color.purple)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
        }
    }
}
