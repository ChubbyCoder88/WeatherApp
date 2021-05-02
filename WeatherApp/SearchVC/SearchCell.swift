//
//  SearchCell.swift
//  WeatherApp
//
//  Created by Matthew on 30/4/21.
//

import UIKit

    class SearchCell: UITableViewCell {
        var searchTable: SearchVC?
        override func layoutSubviews() {
        super.layoutSubviews()
            searchLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
            searchLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
            searchLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            searchLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        }
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
            self.contentView.isUserInteractionEnabled = true
            addSubview(searchLabel)
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        var searchLabel: UILabel = {
            var label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.layer.zPosition = 1
            label.font = UIFont(name: Fonts.common, size: 18)
            label.textColor = UIColor.white
            label.text = ""
            label.backgroundColor = UIColor.clear
            label.clipsToBounds = true
            label.sizeToFit()
            return label
        }()
        override func awakeFromNib() {
            super.awakeFromNib()
        }
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    }
