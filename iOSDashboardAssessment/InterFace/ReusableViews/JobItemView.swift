//
//  JobItemView.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 18/05/24.
//

import SwiftUI
import SampleData

struct JobItemView: View {
    private struct ViewTraits {
        
        static let cornerRadius: CGFloat = 10
    }
    
    let model: JobApiModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("#\(model.jobNumber)")
                    .font(.headline)
                    .foregroundStyle(.gray)
                    .bold()
                
                Text(model.title)
                    .font(.headline)
                    .bold()
                Text(formatDates(startDateStr:model.startTime, endDateStr:model.endTime))
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .bold()
            }
            Spacer()
        }
        .padding()
        .addWhiteBackgroundAndCorner(cornerRadius: ViewTraits.cornerRadius)
    }
    
    // formats the dates
    func formatDates(startDateStr: String, endDateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let startDate = dateFormatter.date(from: startDateStr),
              let endDate = dateFormatter.date(from: endDateStr) else {
            return "Invalid date format"
        }
        
        let calendar = Calendar.current
        
        if calendar.isDateInToday(startDate) && calendar.isDateInToday(endDate) {
            dateFormatter.dateFormat = "HH:mm"
            let startTime = dateFormatter.string(from: startDate)
            let endTime = dateFormatter.string(from: endDate)
            return "today, \(startTime) - \(endTime)"
        } else if calendar.isDate(startDate, inSameDayAs: endDate) {
            dateFormatter.dateFormat = "dd/MM/yy, HH:mm"
            let startDateTime = dateFormatter.string(from: startDate)
            dateFormatter.dateFormat = "HH:mm"
            let endTime = dateFormatter.string(from: endDate)
            return "\(startDateTime) - \(endTime)"
        } else {
            dateFormatter.dateFormat = "dd/MM/yy, HH:mm"
            let startDateTime = dateFormatter.string(from: startDate)
            let endDateTime = dateFormatter.string(from: endDate)
            return "\(startDateTime) -> \(endDateTime)"
        }
    }
}
