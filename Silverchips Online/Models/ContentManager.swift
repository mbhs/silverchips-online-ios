//
//  ContentManager.swift
//  Silverchips Online
//
//  Created by Matthew on 4/5/20.
//  Copyright © 2020 Technaplex. All rights reserved.
//

import Foundation
import SCOAPIClient

protocol ContentDelegate: AnyObject {
    func didFailWithError(error: Error)
    func loadedContent(html: String)
    func noContent()
}

class ContentManager {
    weak var delegate: ContentDelegate?
    var selectedContent: Content
    
    init(content: Content) {
        selectedContent = content
    }
    
    func loadContent() {
        if let selectedContent = selectedContent as? Story {
            self.delegate?.loadedContent(html: selectedContent.text)
        } else {
            self.delegate?.noContent()
        }
        
    }
}
