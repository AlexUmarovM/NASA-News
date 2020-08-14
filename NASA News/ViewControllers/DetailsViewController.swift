//
//  DetailsViewController.swift
//  NASA News
//
//  Created by Александр Умаров on 14.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//
import UIKit
import SDWebImage

final class DetailsViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextVIew: UITextView!
    var titleText: String!
    var imageURL: String!
    var newsText: String!
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let titleLabel = titleLabel else {return}
        titleLabel.text = titleText
        
        guard let descriptionTextVIew = descriptionTextVIew else {return}
        descriptionTextVIew.text = newsText
        
        self.imageCell.sd_setImage(with: URL(string: imageURL),
                                   placeholderImage: UIImage(named: Appearance.StringValues.placeholderImageName),
                                   options: SDWebImageOptions(),
                                   completed: { (image, error, cacheType, imageURL) -> Void in print("loaded") })
    }
}
