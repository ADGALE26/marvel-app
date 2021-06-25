//
//  LoadingCell.swift
//  MarvelCharacters
//
//  Created by Adrián García Ledesma on 24/6/21.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
