//
//  ContentListManager.swift
//  Silverchips Online
//
//  Created by Matthew on 4/4/20.
//  Copyright © 2020 Technaplex. All rights reserved.
//

import Foundation
import SCOAPIClient

protocol ContentListDelegate: AnyObject {
    func didFailWithError(error: Error)
    func loaded()
    func noMoreContent()
}

class ContentListManager {
    weak var delegate: ContentListDelegate?
    var contentList: [Content] = []
    var nextContent: String?
    var previousContent: String?
    var totalResults: Int = 0
    private var loadedFirstTime = false
    
    init() {
        loadLatestContent()
    }
    
    func loadLatestContent() {
//        ContentAPI.contentList(url: URL(string: "https://silverchips.mbhs.edu/api/stories/?limit=25&offset=25")!) { (contentListResponse, error) in
        ContentAPI.contentList { (contentListResponse, error) in
            if let error = error {
                dump(error)
                self.delegate?.didFailWithError(error: error)
                return
            }
            
            if let contentListResponse = contentListResponse {
                self.contentList = contentListResponse.results
                self.totalResults = contentListResponse.count
                self.nextContent = contentListResponse.next
                self.previousContent = contentListResponse.previous
                self.loadedFirstTime = true
                self.delegate?.loaded()
            }
        }
    }
    
    func loadMoreContent() {
        if let nextContent = nextContent {
            ContentAPI.contentList(url: URL(string: nextContent)!) { (contentListResponse, error) in
                if let error = error {
                    dump(error)
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                
                if let contentListResponse = contentListResponse {
                    self.contentList = contentListResponse.results
                    self.totalResults = contentListResponse.count
                    self.nextContent = contentListResponse.next
                    self.previousContent = contentListResponse.previous
                    self.delegate?.loaded()
                }
            }
        } else if loadedFirstTime {
            self.delegate?.noMoreContent()
        }
            
    }
}
