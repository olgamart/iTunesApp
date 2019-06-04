//
//  SearchAppCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Olga Martyanova on 24/04/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation

import UIKit

struct SearchAppCellModel {
    
    let appName: String
    let company: String?
    let averageRating: Float?
    let downloadState: DownloadingApp.DownloadState
}
