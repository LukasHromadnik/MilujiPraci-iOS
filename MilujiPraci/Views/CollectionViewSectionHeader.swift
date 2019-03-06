//
//  CollectionViewSectionHeader.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit

final class CollectionViewSectionHeader: UICollectionReusableView {

    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
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
        backgroundColor = UIColor(white: 0, alpha: 0.1)

        let titleLabel = UILabel()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
        }
        self.titleLabel = titleLabel

        let topBorder = UIView()
        topBorder.backgroundColor = .borderColor
        addSubview(topBorder)
        topBorder.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(1)
        }

        let bottomBorder = UIView()
        bottomBorder.backgroundColor = .borderColor
        addSubview(bottomBorder)
        bottomBorder.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

}
