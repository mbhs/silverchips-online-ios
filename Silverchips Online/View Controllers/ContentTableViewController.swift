//
//  ContentTableViewController.swift
//  Silverchips Online
//
//  Created by Matthew on 4/4/20.
//  Copyright © 2020 Technaplex. All rights reserved.
//

import UIKit

class ContentTableViewController: UITableViewController {
    var contentListManager: ContentListManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentListManager = ContentListManager()
        contentListManager?.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentListManager?.contentList.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as? ContentTableViewCell else {
            fatalError("The dequeued cell is not an instance of ContentViewCell.")
        }

        if let contentListManager = contentListManager {
            cell.titleLabel.text = contentListManager.contentList[indexPath.row].title
        }

        return cell
    }
}

extension ContentTableViewController: ContentListDelegate {
    func didFailWithError(error: Error) {
        dump(error)
    }
    
    func loaded() {
        print("LOADED CONTENT \(contentListManager!.contentList[0].title)")
        tableView.reloadData()
    }
    
    func noMoreContent() {
        print("NO MORE CONTENT")
    }
}
