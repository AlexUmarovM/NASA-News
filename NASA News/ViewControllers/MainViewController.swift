//
//  ViewController.swift
//  NASA News
//
//  Created by Александр Умаров on 14.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

final class MainViewController: UITableViewController {
    
    //MARK: - Properties
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var news = [Model]()
    var networkManager = NetworkManager()
    
    //Mark: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        networkManager.fetchData()
        activityIndicator.startAnimating()
        delay(1) {
            self.news = self.networkManager.newsList
            if self.news.isEmpty {
                self.networkAlert()
            } else {
                self.loadData()
            }
        }
        navigationController?.navigationBar.barStyle = .black
        title = Appearance.StringValues.mainVCTitle
    }
    //MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Appearance.StringValues.cellName) as! NewsDataCell
        cell.titleLabel?.text = news[indexPath.row].title
        cell.date_createdLabel?.text = news[indexPath.row].date_created
        cell.imageCell?.sd_setImage(with: URL(string: news[indexPath.row].href!),
                                    placeholderImage: UIImage(named: news[indexPath.row].href!)
        )
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let indexPath = self.tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.titleText = self.news[selectedRow].title
            detailsVC.imageURL = self.news[indexPath.row].href
            detailsVC.newsText = self.news[indexPath.row].description
        }
    }
}

