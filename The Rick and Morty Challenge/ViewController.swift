//
//  ViewController.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 16/08/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    let data: [Test] = [
        Test(title: "test 1"),
        Test(title: "test 2"),
        Test(title: "test 3"),
        Test(title: "test 4"),
        Test(title: "test 5"),
        Test(title: "test 6")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = item.title
        return cell
    }

}

struct Test {
    let title: String
}

