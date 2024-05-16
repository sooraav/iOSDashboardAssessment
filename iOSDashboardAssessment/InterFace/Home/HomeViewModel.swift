//
//  HomeViewModel.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 16/05/24.
//

import Foundation
import Combine
import SampleData

protocol HomeInterface: ObservableObject {
    var greeting: GreetingsModel? { get set }
    init(dataFetcher: DataFetchable)
    func getData()
}

class HomeViewModel {
    
    @Published var greeting : GreetingsModel?
    
    private let datafetcher: DataFetchable
    private var disposables = Set<AnyCancellable>()
    
    required init(dataFetcher: DataFetchable) {
        
        self.datafetcher = dataFetcher
    }
    
    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMMM d'\(daySuffix(from: Date())),' yyyy"
            
        return dateFormatter.string(from: Date())
    }
    
    private func daySuffix(from date: Date) -> String {
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: date)
        
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
}

extension HomeViewModel: HomeInterface {
   
    
    func getData() {
        
        datafetcher
            .getJobList()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] value in
                
            }
            .store(in: &disposables)
        
        
        datafetcher
            .getInvoiceList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                
                self?.greeting = GreetingsModel(name: value.first?.customerName ?? "Unknown_Name", date: self?.getCurrentDate() ?? "Unknown_Date")
            }
            .store(in: &disposables)
    }
}
