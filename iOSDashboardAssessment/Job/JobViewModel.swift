//
//  JobViewModel.swift
//  iOSDashboardAssessment
//
//  Created by Sourav on 18/05/24.
//
import Foundation
import SwiftUI
import SampleData

protocol JobInterface: ObservableObject {
    
    var segments: [SegmentModel] { get set }
    var selected: SegmentModel? { get set }
    var statsModel: StatsModel { get }
    var jobByState: [JobStatus: [JobApiModel]] { get }
    
    func getSegments()
}

class JobViewModel: JobInterface {
    
    @Published var segments = [SegmentModel]()
    @Published var selected: SegmentModel?
    let statsModel: StatsModel
    let jobByState: [JobStatus : [JobApiModel]]
    
    init(statsModel: StatsModel, jobByState: [JobStatus: [JobApiModel]]) {
        
        self.statsModel = statsModel
        self.jobByState = jobByState
    }
    
    // gets the segments
    func getSegments() {
        
        for state in JobStatus.allCases {
            if let jobs = jobByState[state] {
                segments.append(
                    SegmentModel(
                        status: state,
                        items: jobs,
                        title: String(format: state.getTranslation().0, jobs.count)
                    )
                )
            }
        }
        selected = segments.first
    }
}
