//
//  LandingView.swift
//  Schroders
//
//  Created by Jonathan Aguele on 03/02/2021.
//

import UIKit

class CommitsView: UIView {

    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.register(CommitsTableViewCell.self, forCellReuseIdentifier: CommitsTableViewCell.identifier)
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension CommitsView: UIIdentifying {}
