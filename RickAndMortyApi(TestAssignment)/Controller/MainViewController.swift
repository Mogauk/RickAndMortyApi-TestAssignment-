//
//  MainViewController.swift
//  RickAndMortyApi(TestAssignment)
//
//  Created by Alexey on 11/15/22.
//

import UIKit

class MainViewController: UIViewController {
    
    var characters = [Characters]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        tableView.separatorStyle = .none
        
        parseJSON { data in
            self.characters = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func parseJSON(completion: @escaping ([Characters]) -> ()) {
        
        let urlString = "https://rickandmortyapi.com/api/character"
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("error")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil, data != nil {
                let decoder = JSONDecoder()
                
                do {
                    let parsingData = try decoder.decode(Result.self, from: data!)
                    completion(parsingData.results)
                } catch {
                    print("Parsing error")
                }
            }
        }
        
        dataTask.resume()
    }
    
}
    
    extension MainViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return characters.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharactersTableViewCell.self), for: indexPath) as! CharactersTableViewCell
            
            cell.nameLabel.text = characters[indexPath.row].name
            cell.speciesLabel.text = characters[indexPath.row].species?.appending(",")
            cell.genderLabel.text = characters[indexPath.row].gender?.lowercased()
            cell.locationLabel.text = characters[indexPath.row].origin.name
            cell.statusLabel.text = characters[indexPath.row].status?.uppercased()
            if characters[indexPath.row].status == "Alive" {
                cell.statusLabel.backgroundColor = UIColor(red: 193/256, green: 233/256, blue: 176/256, alpha: 1.0)
                cell.statusLabel.textColor = UIColor(red: 75/256, green: 144/256, blue: 46/256, alpha: 1.0)
                
            } else if characters[indexPath.row].status == "Dead" {
                cell.statusLabel.backgroundColor = UIColor(red: 253/256, green: 241/256, blue: 230/256, alpha: 1.0)
                cell.statusLabel.textColor = UIColor(red: 237/256, green: 116/256, blue: 47/256, alpha: 1.0)
                
            } else {
                cell.statusLabel.backgroundColor = .lightGray
                cell.statusLabel.textColor = .gray
                cell.statusLabel.text = characters[indexPath.row].status?.lowercased()
            }
            
            if let url = URL(string: characters[indexPath.row].image!) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.imageCharacters.image = image
                            }
                        }
                    }
                }
            }
            
            return cell
        }
    }

