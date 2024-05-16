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
                
                self?.greeting = GreetingsModel(name: value.first?.customerName ?? "Unknown_Name", date: "today's date")
            }
            .store(in: &disposables)
    }
}
