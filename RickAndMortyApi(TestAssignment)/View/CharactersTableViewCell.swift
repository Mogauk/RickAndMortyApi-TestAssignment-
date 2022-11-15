//
//  CharactersTableViewCell.swift
//  RickAndMortyApi(TestAssignment)
//
//  Created by Alexey on 11/15/22.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    @IBOutlet var imageCharacters: UIImageView! {
        didSet {
            imageCharacters.layer.cornerRadius = 30
            imageCharacters.clipsToBounds = true
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!{
        didSet {
            statusLabel.layer.cornerRadius = 10
            statusLabel.layer.masksToBounds = true
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
