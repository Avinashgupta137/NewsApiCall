//
//  ViewController.swift
//  News
//
//  Created by IPS-149 on 15/03/23.
//

import UIKit
import Kingfisher
class ViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    
    var articlesArray: [Articles] = []
    var json: Json4Swift_Base?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.title = "HEADLINES"
//        self.navigationController?.navigationBar.barTintColor = .black
//        self.navigationController?.navigationBar.backgroundColor = .black
        
        getJson() { [self] (json) in
            DispatchQueue.main.sync {
                if let articles = json.articles {
                    for article in articles {
                        self.articlesArray.append(article)
                        tblView.reloadData()
                    }
                }
            }
            
        }
    }
    
    //MARK: - ApiCall
    func getJson(completion: @escaping (Json4Swift_Base)-> ()) {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2023-02-15&sortBy=publishedAt&apiKey=593f5a82de084c33afe3c1955d829e8d"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) {data, res, err in
                if let data = data {
                    do {
                        let json: Json4Swift_Base = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
                        completion(json)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
    
    
}
//MARK: - TableView

extension ViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.lblDate.text = articlesArray[indexPath.row].publishedAt
        cell.lblcnn.text = articlesArray[indexPath.row].source?.name
        cell.lbltitle.text = articlesArray[indexPath.row].title
        //cell.img.image = UIImage(named: articlesArray[indexPath.row].urlToImage!)
        
        if let imageUrlString = articlesArray[indexPath.row].urlToImage, let imageUrl = URL(string: imageUrlString) {
            cell.img.kf.setImage(with: imageUrl)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = articlesArray[indexPath.row]
        performSegue(withIdentifier: "showdetail", sender: selectedData)
    }
    
    //MARK: - SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showdetail" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.data = sender as? Articles
        }
    }
}
