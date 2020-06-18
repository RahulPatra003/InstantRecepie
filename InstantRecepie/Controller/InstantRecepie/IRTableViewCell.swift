//
//  IRTableViewCell.swift
//  InstantRecepie
//
//  Created by MAC on 17/06/20.
//  Copyright © 2020 Techangouts. All rights reserved.
//

import UIKit
import IBAnimatable

class IRTableViewCell: UITableViewCell {

    @IBOutlet weak var img: AnimatableImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    
    var cellData : Result? {
        didSet{
            self.img.sd_setImage(with: URL(string: cellData?.thumbnail ?? ""), placeholderImage: UIImage(named: ""))
            self.titleLbl.text = (cellData?.title ?? "").capitalized
            self.desLbl.text = (cellData?.ingredients ?? "").capitalized
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
