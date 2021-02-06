//
//  CommitsTableViewCell.swift
//  SchrodersApp
//
//  Created by Jonathan Aguele on 04/02/2021.
//

import UIKit
import SnapKit
import Kingfisher

protocol CommitsTableViewCellPresenter {
    var name: String { get }
    var message: String { get }
    var imageURL: String? { get }
    var commitDateString: String? { get }
}

extension CommitsTableViewCellPresenter {
    var commitDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        return formatter
    }
}

class CommitsTableViewCell: UITableViewCell {

    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = 4
        view.axis = .vertical
        view.addArrangedSubview(authorNameLabel)
        view.addArrangedSubview(commitMessage)
        view.addArrangedSubview(commitDateLabel)
        return view
    }()

    lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .blue
        return label
    }()

    lazy var commitMessage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .orange
        return label
    }()

    lazy var commitDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .purple
        return label
    }()

    lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.kf.indicatorType = .activity
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        layoutAvatarImage()
        layoutStackView()
    }

    private func layoutAvatarImage() {
        contentView.addSubview(avatarImageView)
        avatarImageView.backgroundColor = .blue
        avatarImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
    }

    private func layoutStackView() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(20)
        }
    }

    func update(with presenter: CommitsTableViewCellPresenter) {
        authorNameLabel.text = presenter.name
        commitMessage.text = presenter.message
        avatarImageView.kf.setImage(with: URL(string: presenter.imageURL ?? ""))
        commitDateLabel.text = presenter.commitDateString
    }
}

extension CommitsTableViewCell: UIIdentifying {}
