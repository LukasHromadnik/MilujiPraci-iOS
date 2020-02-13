//
//  TrackCollectionViewCell.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit

final class TrackCollectionViewCell: UICollectionViewCell {
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = backgroundColor?.withAlphaComponent(0.7)
            } else {
                backgroundColor = backgroundColor?.withAlphaComponent(1.3)
            }
        }
    }

    private weak var titleLabel: UILabel!

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Components setup

    private func setup() {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(5)
        }
        self.titleLabel = titleLabel
    }
}
