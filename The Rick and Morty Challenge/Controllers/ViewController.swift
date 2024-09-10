//
//  ViewController.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 16/08/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        Task {
            await loadCharacterData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.characters[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Navega prox tela
//        self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
    private func loadCharacterData() async {
        await viewModel.loadCharacters()
        table.reloadData()
    }
}

struct Test {
    let title: String
}

