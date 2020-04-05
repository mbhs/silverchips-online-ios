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
        showSpinner(onView: self.view)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contentListManager?.selectContent(index: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case K.Segues.contentListToContent:
            guard let viewController = segue.destination as? ContentViewController else {
                fatalError("Segue sent to unexpected view controller")
            }
            
            if let content = contentListManager?.content {
                viewController.contentManager = ContentManager(content: content)
            }
            
            
        default:
            fatalError("Unknown segue")
        }
    }
}

extension ContentTableViewController: ContentListDelegate {
    func loadContent() {
        performSegue(withIdentifier: K.Segues.contentListToContent, sender: self)
    }
    
    func didFailWithError(error: Error) {
        dump(error)
    }
    
    func loaded() {
        print("LOADED CONTENT \(contentListManager!.contentList[0].title)")
        tableView.reloadData()
        removeSpinner()
    }
    
    func noMoreContent() {
        print("NO MORE CONTENT")
    }
}
