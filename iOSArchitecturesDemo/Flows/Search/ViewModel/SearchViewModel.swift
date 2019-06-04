//
//  SearchViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Olga Martyanova on 24/04/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import UIKit

final class SearchViewModel {
    
    var searchResults = Observable<[SearchAppCellModel]>([])
    var isLoading = Observable<Bool>(false)
    var showEmptyResults = Observable<Bool>(false)
    var error = Observable<Error?>(nil)
    
    weak var viewController: UIViewController?
    
    private var apps: [ITunesApp] = []
    
    private let searchService: SearchServiceIntarface
    private let downloadAppsService: DownloadAppsServiceInterface
    
    //MARK: - Init
    
    init(searchService: SearchServiceIntarface, downloadAppsService: DownloadAppsServiceInterface){
        self.searchService = searchService
        self.downloadAppsService = downloadAppsService
        downloadAppsService.onProgressUpdate = {[weak self] in
            guard let self = self else {return}
            self.searchResults.value = self.cellModels()
        }
    }
    
    //MARK: - ViewModel
    func performSearch(with query: String) {
        self.isLoading.value = true
        self.searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            result
                .withValue { apps in
                    self.apps = apps
                    self.searchResults.value = self.cellModels()
                    self.showEmptyResults.value = apps.isEmpty
                    self.error.value = nil
                    
                }
                .withError {
                    self.apps = []
                    self.searchResults.value = []
                    self.showEmptyResults.value = true
                    self.error.value = $0
  
            }
        }
    }
    
    
    func viewDidSelectApp(_ cellModel: SearchAppCellModel) {
        guard let app = self.app(with: cellModel) else { return }
        let appDetaillViewController = AppDetailViewController(app: app)
        
        self.viewController?.navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
    
    func didTapDownloadApp(_ cellModel: SearchAppCellModel) {
        guard let app = self.app(with: cellModel) else { return }
        self.downloadAppsService.startDownloadApp(app)
    }
    
    // MARK: - Private
    
    private func cellModels() -> [SearchAppCellModel] {
        return self.apps.compactMap { app -> SearchAppCellModel in
            let downloadingApp = self.downloadAppsService.downloadingApps.first { downloadingApp -> Bool in
                return downloadingApp.app.appName == app.appName
            }
            return SearchAppCellModel(appName: app.appName,
                                      company: app.company,
                                      averageRating: app.averageRating,
                                      downloadState: downloadingApp?.downloadState ?? .notStarted)
        }
    }
    
    private func app(with cellModel: SearchAppCellModel) -> ITunesApp? {
        return self.apps.first { cellModel.appName == $0.appName }
    }
}
