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
    }
}

extension HomeViewModel: HomeInterface {
   
    
    func getData() {
        
        datafetcher
            .getJobList()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] value in
                
                guard let self else { return }
                for job in value {
                    
                    self.jobByStatus[job.status, default: []].append(job)
                }
                self.statViews.append(self.convertModel(itemsByStatus: self.jobByStatus, type: .job))
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
                self.statViews.append(self.convertModel(itemsByStatus: self.invoiceByStatus, type: .amount))
            }
            .store(in: &disposables)
    }
}

extension HomeViewModel {
    
    private func convertModel<T: Translatable, U>(itemsByStatus: [T: [U]], type: StatType) -> StatsModel {
        var barModel = [BarModel]()
        var total = 0
        var statusCounts = [T: Int]()
        
        for status in T.allCases {
            let (name, color) = status.getTranslation()
            barModel.append(
                BarModel(
                    name: name,
                    count: itemsByStatus[status]?.count,
                    colour: color
                )
            )
            total += (itemsByStatus[status]?.count ?? 0)
            
        }
        let title = type == .job ? "Job Stats": "Invoice Stats"
        let totalText =  type == .job ? "\(total) Jobs": "Total Value($ \(total))"
        let inProgress = type == .job ? "\(itemsByStatus[JobStatus.completed as! T]?.count ?? 0) of \(total) completed": "\((itemsByStatus[InvoiceStatus.paid as! T]?.count ?? 0)) collected"
        
        return StatsModel(barInfo: barModel, title: title, total: total, totalText: totalText, inProgressText: inProgress)
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

extension JobStatus: Translatable {
    
    func getTranslation() -> (String, Color) {
        
        switch self {
            
        case .yetToStart:
            return ("Yet to Start (%d)", .purple)
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
    
    func getTranslation() -> (String, Color) {
        
        switch self {
            
        case .draft:
            return ("Draft", .yellow)
        case .pending:
            return ("Pending", .cyan)
        case .paid:
            return ("Paid", .green)
        case .badDebt:
            return ("Bad Debt", .red)
        }
    }
}
