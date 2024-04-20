//
//  ViewController.swift
//  19. დავალება - ვებ სერვისებთან კომუნიკაცია
//
//  Created by gvantsa gvagvalia on 4/19/24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    var newsArray: [News.NewsDetails] = []
    
    let newsTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
        view.separatorStyle = .none
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.dataSource = self
        newsTableView.delegate = self
        getNewsInfo()
        setupUI()
    }
    
    func getNewsInfo() {
        
        let urlString = "https://imedinews.ge/api/categorysidebarnews/get"
        guard let urlObject = URL(string: urlString) else {
            print("no url")
            return
        }
        
        URLSession.shared.dataTask(with: urlObject) { data, response, error in
            
            guard let data = data else {
                print("no data recieved")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(News.self, from: data)
                self.newsArray = decodedData.list
                
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            } catch {
                print("error decoding json \(error.localizedDescription)")
            }
            
        }.resume()
    }
    // MARK: - UI
    func setupUI() {
        view.addSubview(newsTableView)
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Panicka News"
        
        NSLayoutConstraint.activate([
            newsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            newsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        let newsDetails = newsArray[indexPath.row]
        
        if let imageUrl = URL(string: newsDetails.photoUrl) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        let imageBackground = UIImage(data: data)
                        cell.backgrounImage.image = imageBackground
                        cell.applyCustomBlurEffect()
                    }
                }
            }.resume()
        }
        
        cell.timeLabel.text = newsDetails.time
        cell.newsTitleLabel.text = newsDetails.title
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedRaw = newsArray[indexPath.row]
        let detailsVC = DetailsVC(news: selectedRaw)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
