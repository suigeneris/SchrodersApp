//
//  LandingViewController.swift
//  SchrodersApp
//
//  Created by Jonathan Aguele on 03/02/2021.
//

import UIKit

class LandingViewController: UIViewController {

    let viewModel: LandingViewModel

    init(viewModel: LandingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: LandingView.identifier, bundle: Bundle.main)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func fetchButtonPressed(_ sender: Any) {
        viewModel.fetch()
    }
}
