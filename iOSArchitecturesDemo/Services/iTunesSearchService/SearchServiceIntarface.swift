//
//  SearchServiceIntarface.swift
//  iOSArchitecturesDemo
//
//  Created by Olga Martyanova on 15/04/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Alamofire

public typealias CompletionApps = (Result<[ITunesApp]>) -> Void
public typealias CompletionSongs = (Result<[ITunesSong]>) -> Void

protocol SearchServiceIntarface: class {
    
    func getApps(forQuery query: String, then completion: CompletionApps?)
    func getSongs(forQuery query: String, completion: CompletionSongs?)
}
