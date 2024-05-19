//
//  HomeViewModel.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 16/05/24.
//

import Foundation
import Combine
import SampleData
import SwiftUI

protocol HomeInterface: ObservableObject {
    var greeting: GreetingsModel? { get set }
    var statViews: [StatsModel] { get set }
    var jobByStatus: [JobStatus: [JobApiModel]] { get set }
    init(dataFetcher: DataFetchable)
    func getData()
}

protocol Translatable: CaseIterable {
    func getTranslation() -> (String, Color)
}

class HomeViewModel {
    
    @Published var greeting : GreetingsModel?
    @Published var statViews = [StatsModel]()
    
    var jobByStatus = [JobStatus: [JobApiModel]]()
    var invoiceByStatus = [InvoiceStatus: [InvoiceApiModel]]()
    
    private let datafetcher: DataFetchable
    private var disposables = Set<AnyCancellable>()
    
    required init(dataFetcher: DataFetchable) {
        
        self.datafetcher = dataFetcher
        getData()
    }
}

extension HomeViewModel: HomeInterface {
   
    // gets data from data fetch and populates using combine
    func getData() {
        
        datafetcher
            .getJobList()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] value in
                
                guard let self else { return }
                for job in value {
                    
                    self.jobByStatus[job.status, default: []].append(job)
                }
                self.statViews.append(getJobStatModel())
            }
            .store(in: &disposables)
        
        
        datafetcher
            .getInvoiceList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                for job in value {
                    
                    self.invoiceByStatus[job.status, default: []].append(job)
                }
                self.greeting = GreetingsModel(name: value.first?.customerName ?? "Unknown_Name", date: self.getCurrentDate())
                self.statViews.append(getInvoiceStatModel())
            }
            .store(in: &disposables)
    }
}

extension HomeViewModel {
    
    // creates job statmodel from recieved data
    private func getJobStatModel() -> StatsModel {
        var barModel = [BarModel]()
        var total = 0
        for status in JobStatus.allCases {
            let (name, color) = status.getTranslation()
            let count = jobByStatus[status]?.count
            barModel.append(
                BarModel(
                    name: name,
                    count: count,
                    colour: color
                )
            )
            total += count ?? 0
        }
        
        let title = "Job Stats"
        let totalText =  "\(total) Jobs"
        let inProgress = "\(jobByStatus[JobStatus.completed]?.count ?? 0) of \(total) completed"
        
        return StatsModel(barInfo: barModel, title: title, total: total, totalText: totalText, inProgressText: inProgress, type: .job)
    }
    // creates invoice statmodel from recieved data
    private func getInvoiceStatModel() -> StatsModel {
        var barModel = [BarModel]()
        var total = 0
        for status in InvoiceStatus.allCases {
            let (name, color) = status.getTranslation()
            let count = invoiceByStatus[status]?.reduce(0) { $0 + $1.total
            }
            barModel.append(
                BarModel(
                    name: name,
                    count: count,
                    colour: color
                )
            )
            total += count ?? 0
        }
        
        let title = "Invoice Stats"
        let totalText = "Total Value($ \(total))"
        let inProgress = "\((invoiceByStatus[InvoiceStatus.paid]?.count ?? 0)) collected"
        
        return StatsModel(barInfo: barModel, title: title, total: total, totalText: totalText, inProgressText: inProgress, type: .amount)
    }
    
    // gets current date string
    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMMM d'\(daySuffix(from: Date())),' yyyy"
            
        return dateFormatter.string(from: Date())
    }
    
    // returns the day suffix for the date
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

extension JobStatus: Translatable {
    
    // returns translation and colour for jobStatus
    func getTranslation() -> (String, Color) {
        
        switch self {
            
        case .yetToStart:
            return ("Yet to start (%d)", .purple)
        case .inProgress:
            return ("In-Progress (%d)", .cyan)
        case .canceled:
            return ("Cancelled (%d)", .yellow)
        case .completed:
            return ("Completed (%d)", .green)
        case .incomplete:
            return ("In-Complete (%d)", .red)
        }
    }
}

extension InvoiceStatus: Translatable {
    
    // returns translation and colour for invoiceStatus
    func getTranslation() -> (String, Color) {
        
        switch self {
            
        case .draft:
            return ("Draft ($%d)", .yellow)
        case .pending:
            return ("Pending ($%d)", .cyan)
        case .paid:
            return ("Paid ($%d)", .green)
        case .badDebt:
            return ("Bad Debt ($%d)", .red)
        }
    }
}
