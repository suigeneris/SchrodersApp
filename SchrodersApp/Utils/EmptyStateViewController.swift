//
//  EmptyStateViewController.swift
//  SchrodersApp
//
//  Created by Jonathan Aguele on 06/02/2021.
//

import UIKit

final class EmptyStateViewController: UIViewController {

    private let titleLabel = UILabel()
    
    var error: Error? {
        didSet {
            titleLabel.text = error?.localizedDescription
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        layout()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    private func layout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }

    private func setup() {
        titleLabel.textAlignment = .center
        titleLabel.text = "No Resutls"
    }
}
