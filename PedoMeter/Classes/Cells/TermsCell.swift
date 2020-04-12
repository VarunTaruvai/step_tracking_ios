//
//  TermsCell.swift
//  PedoMeter
//
//  Created by Ankit  Jain on 10/04/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
import WebKit

class TermsCell: UITableViewCell {

    @IBOutlet weak var webHgt: NSLayoutConstraint!
    @IBOutlet weak var webView: WKWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
