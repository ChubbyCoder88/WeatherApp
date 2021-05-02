//
//  DetailedViewCell.swift
//  WeatherApp
//
//  Created by Matthew on 30/4/21.
//

import UIKit

class DetailedViewCell: UITableViewCell {
    var detailTable: DetailedViewVC?
    override func layoutSubviews() {
    super.layoutSubviews()
        weatherImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        weatherImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        weatherImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        weatherImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        darkLabel.topAnchor.constraint(equalTo: weatherImage.topAnchor, constant: 0).isActive = true
        darkLabel.leftAnchor.constraint(equalTo: weatherImage.leftAnchor, constant: 0).isActive = true
        darkLabel.rightAnchor.constraint(equalTo: weatherImage.rightAnchor, constant: 0).isActive = true
        darkLabel.bottomAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 0).isActive = true
        
        cityNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        cityNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        cityNameLabel.heightAnchor.constraint(equalToConstant: 37).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 7).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tempLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 13).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        tempLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        degreesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 13).isActive = true
        degreesLabel.leftAnchor.constraint(equalTo: tempLabel.rightAnchor, constant: 0).isActive = true
        degreesLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        lowLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 7).isActive = true
        lowLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        lowLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        humidityLabel.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 7).isActive = true
        humidityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        humidityLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        pressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 7).isActive = true
        pressureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        pressureLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        CancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        CancelButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        CancelButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        CancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        AddButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        AddButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        AddButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        AddButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        addSubview(weatherImage)
        addSubview(darkLabel)
        addSubview(cityNameLabel)
        addSubview(descriptionLabel)
        addSubview(tempLabel)
        addSubview(degreesLabel)
        addSubview(lowLabel)
        addSubview(CancelButton)
        addSubview(AddButton)
        addSubview(humidityLabel)
        addSubview(pressureLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var cityNameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.zPosition = 3
        label.font = UIFont(name: Fonts.common, size: 34)
        label.textColor = UIColor.white
        label.text = ""
        label.backgroundColor = UIColor.clear
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.zPosition = 3
        label.font = UIFont(name: Fonts.common, size: 19)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()
    var tempLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.zPosition = 3
        label.font = UIFont(name: Fonts.common, size: 100)
        label.textColor = UIColor.white
        label.text = "°"
        label.backgroundColor = UIColor.clear
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()
    var degreesLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.zPosition = 3
        label.font = UIFont(name: Fonts.common, size: 100)
        label.textColor = UIColor.white
        label.text = "°"
        label.backgroundColor = UIColor.clear
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()
    var lowLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.zPosition = 3
        label.font = UIFont(name: Fonts.common, size: 18)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()
    lazy var CancelButton: UIButton = {
        let label = UIButton()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.layer.zPosition = 11
        label.setTitle("Cancel", for: .normal)
        label.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        label.setTitleColor(UIColor.white, for: .normal)
        label.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        label.contentHorizontalAlignment = .left
        label.clipsToBounds = true
        return label
    }()
    lazy var AddButton: UIButton = {
        let label = UIButton()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.layer.zPosition = 11
        label.setTitle("add", for: .normal)
        label.addTarget(self, action: #selector(add), for: .touchUpInside)
        label.setTitleColor(UIColor.white, for: .normal)
        label.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        label.contentHorizontalAlignment = .right
        label.clipsToBounds = true
        return label
    }()
    let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        let image = UIImage(named: "")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.zPosition =  1
        return imageView
    }()
    var darkLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 2
        label.backgroundColor = UIColor.black
        label.alpha = 0.4
        label.clipsToBounds = true
        return label
    }()
    var humidityLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.zPosition = 3
        label.font = UIFont(name: Fonts.common, size: 18)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()
    var pressureLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.zPosition = 3
        label.font = UIFont(name: Fonts.common, size: 18)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()
    @objc func cancel() {
        print("cancel")
        detailTable?.cancelCity()
    }
    @objc func add() {
        print("add")
        detailTable?.addCity()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
