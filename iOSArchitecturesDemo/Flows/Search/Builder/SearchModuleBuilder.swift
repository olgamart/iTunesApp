//
//  SearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Olga Martyanova on 06/04/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import UIKit

final class SearchModuleBuilder {
    
    static func build()-> UIViewController {
        let searchService = ITunesSearchService()
        let downloadAppsService = FakeDownloadAppsService()
        let viewModel = SearchViewModel(searchService: searchService, downloadAppsService: downloadAppsService)
        let viewController = SearchViewController(viewModel: viewModel)
        viewModel.viewController = viewController
        return viewController
    }
}
