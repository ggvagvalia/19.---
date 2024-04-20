//
//  NewsTableViewCell.swift
//  19. დავალება - ვებ სერვისებთან კომუნიკაცია
//
//  Created by gvantsa gvagvalia on 4/19/24.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        return containerView
    }()
    
    let backgrounImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Error"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Error"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
        return label
    }()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    func setupUI() {
        addSubview(containerView)
        containerView.addSubview(backgrounImage)
        containerView.addSubview(timeLabel)
        containerView.addSubview(newsTitleLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            
            newsTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            newsTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            newsTitleLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            newsTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            backgrounImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgrounImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            backgrounImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgrounImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    func applyCustomBlurEffect() {
        guard let image = backgrounImage.image,
              let ciImage = CIImage(image: image) else {
            return
        }
        let blurRadius: CGFloat = 3.5
        let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: [kCIInputImageKey: ciImage, kCIInputRadiusKey: blurRadius])
        
        if let outputImage = blurFilter?.outputImage {
            let context = CIContext(options: nil)
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                let blurredImage = UIImage(cgImage: cgImage)
                backgrounImage.image = blurredImage
            }
        }
    }
    
}
