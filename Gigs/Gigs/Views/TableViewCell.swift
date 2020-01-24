//
//  TableViewCell.swift
//  Gigs
//
//  Created by alfredo on 1/20/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    //MARK: - Properties
    
    var gig: Gig?{
        didSet{
            updateViews()
        }
    }
    
    //MARK: - Methods
    
    func updateViews(){
        guard let _ = gig else { return }
        
        self.titleLabel.text = gig!.title
        self.subtitleLabel.text = gig!.description
    }
    
}
