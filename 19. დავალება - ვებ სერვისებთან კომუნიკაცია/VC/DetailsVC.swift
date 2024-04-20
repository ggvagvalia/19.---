//
//  DetailsVC.swift
//  19. დავალება - ვებ სერვისებთან კომუნიკაცია
//
//  Created by gvantsa gvagvalia on 4/19/24.
//

import UIKit

class DetailsVC: UIViewController {
    
    // MARK: - Variables
    let news: News.NewsDetails
    
    let newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.image = UIImage(systemName: "questionmark")
        return image
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    let detailsLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.backgroundColor = .quaternarySystemFill
        label.layer.cornerRadius = 20
        label.isSelectable = false
        label.isEditable = false
        label.isScrollEnabled = true
        return label
    }()
    
    // MARK: - LifeCycle
    init(news: News.NewsDetails) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI
    
    func getDetailedInfo() {
        detailsLabel.text = news.title
        timeLabel.text = news.time
        
        if let imageUrl = URL(string: news.photoUrl) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        let imageBackground = UIImage(data: data)
                        self.newsImage.image = imageBackground
                    }
                }
            }.resume()
        }
    }
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Details"
        
        getDetailedInfo()
        view.addSubview(newsImage)
        view.addSubview(timeLabel)
        view.addSubview(detailsLabel)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            newsImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            newsImage.heightAnchor.constraint(equalTo: newsImage.widthAnchor, multiplier: 0.6),
            
            timeLabel.leadingAnchor.constraint(equalTo: detailsLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: detailsLabel.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: detailsLabel.topAnchor, constant: -20),
            timeLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 10),
            
            detailsLabel.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor),
            detailsLabel.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor),
            detailsLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
        ])
    }
}
