//
//  DetailViewController.swift
//  News
//
//  Created by avinash on 15/03/23.
//

import UIKit

class DetailViewController: UIViewController {

    var data: Articles?
  
    
    @IBOutlet var imageimg: UIImageView!
    @IBOutlet var lbltitl: UILabel!
    @IBOutlet var lbldate :UILabel!
    @IBOutlet var lblCnn: UILabel!
    @IBOutlet var lbldesc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbldesc.text = data?.description
        lbltitl.text = data?.title
        lblCnn.text = data?.source?.name
        lbldate.text = data?.publishedAt
       // imageimg.image = data?.urlToImage
        if let urlString = data?.urlToImage, let url = URL(string: urlString) {
                   imageimg.load(url: url)
               }
        
       
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
