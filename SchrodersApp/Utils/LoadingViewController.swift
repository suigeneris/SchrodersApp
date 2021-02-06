//
//  LoadingViewController.swift
//  SchrodersApp
//
//  Created by Jonathan Aguele on 06/02/2021.
//

import UIKit

class LoadingViewController: UIViewController {

    private lazy var activityIndicatorView = UIActivityIndicatorView(style: .large)

    init() {
        super.init(nibName: nil, bundle: nil)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    private func layout() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    override func didMove(toParent parent: UIViewController?) {
        if let _ = parent {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}
