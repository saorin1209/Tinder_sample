//
//  ListViewController.swift
//  sample_Tinder
//
//  Created by staff on 2018/09/16.
//  Copyright © 2018年 staff. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
    var likedName = [String]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indexPath = cellの番号
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = likedName[indexPath.row]
        return cell
    }
}
