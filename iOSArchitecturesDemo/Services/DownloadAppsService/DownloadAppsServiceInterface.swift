//
//  DownloadAppsServiceInterface.swift
//  iOSArchitecturesDemo
//
//  Created by Olga Martyanova on 22/04/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation

protocol DownloadAppsServiceInterface: class {
    
    var downloadingApps: [DownloadingApp] { get }
    
    var onProgressUpdate: (() -> Void)? { get set }
    
    func startDownloadApp(_ app: ITunesApp)
}
