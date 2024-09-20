//
//  ViewController.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 16/08/24.
//

import UIKit

class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
//
//
//class TabViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
//    
//    @IBOutlet weak var table: UITableView!
//    var viewModel: ViewModel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        table.dataSource = self
//        table.delegate = self
//        Task {
//            await loadCharacterData()
//        }
//        
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.characters.count
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 164
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = viewModel.characters[indexPath.row]
//        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
////        cell.label.text = item.name
//        cell.prepareView(item)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //Navega prox tela
//        if let detailVC = UIStoryboard(name: "DetailCharacter", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
//            detailVC.character = viewModel.characters[indexPath.row]
//            self.navigationController?.pushViewController(detailVC, animated: true)
//        }
//    }
//    
//    private func loadCharacterData() async {
//        await viewModel.loadCharacters()
//        table.reloadData()
//    }
//}
