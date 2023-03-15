//
//  TableViewCell.swift
//  News
//
//  Created by IPS-149 on 15/03/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblcnn: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
