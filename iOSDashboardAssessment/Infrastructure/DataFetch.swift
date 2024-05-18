//
//  DataFetch.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 17/05/24.
//

import Foundation
import Combine
import SampleData

protocol DataFetchable {
    
    func getJobList() -> AnyPublisher<[JobApiModel], Never>
    func getInvoiceList() -> AnyPublisher<[InvoiceApiModel], Never>
}

class DataFetch: DataFetchable {
    
    func getJobList() -> AnyPublisher<[JobApiModel], Never> {
        
        let jobList = SampleData.generateRandomJobList(size: 5)
        return Just(jobList)
                    .eraseToAnyPublisher()
    }
    
    func getInvoiceList() -> AnyPublisher<[InvoiceApiModel], Never> {
        
        let invoiceList = SampleData.generateRandomInvoiceList(size: 5)
        return Just(invoiceList)
                    .eraseToAnyPublisher()
    }
    
}
