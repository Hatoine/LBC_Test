//
//  DetailViewController.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 26/04/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailProduct: Products?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(productImage)
        view.addSubview(productTitleLabel)
        view.addSubview(productDescriptionTextView)
        view.addSubview(productPriceLabel)
        view.addSubview(productDate)
        productImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: productTitleLabel.topAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 25, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        productTitleLabel.anchor(top: nil, left: view.leftAnchor, bottom: productPriceLabel.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        productDescriptionTextView.anchor(top: productDate.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        productPriceLabel.anchor(top: productTitleLabel.topAnchor, left: view.leftAnchor, bottom: productDate.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        productDate.anchor(top: productPriceLabel.bottomAnchor, left: view.leftAnchor, bottom: productDescriptionTextView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        guard let imageURL = detailProduct?.images_url?.small else { return }
        guard let price = detailProduct?.price else { return }
        guard let date =  detailProduct?.creation_date else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"

        if let date = dateFormatter.date(from: date) {
            dateFormatter.locale = Locale(identifier: "fr")
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd'T'HH:mm:ssZZZZ", options: .zero, locale: dateFormatter.locale)

            let frenchDate = dateFormatter.string(from: date)
            print(frenchDate)
        } else {
            print("invalid input date")
        }
        productImage.loadImageUsingCacheWithUrlString(imageURL)
        productTitleLabel.text = detailProduct?.title
        productDescriptionTextView.text = detailProduct?.description
        productPriceLabel.text = String(price) + " " + "€"
      //  productDate.text = "Date:" + String(Date(format.date(from: "2016-08-26T12:39:00Z")) )
    }

    
    let productImage: UIImageView = {
        let productImage = UIImageView()
        productImage.contentMode = .scaleAspectFit
        return productImage
    }()
    
    let productTitleLabel: UILabel = {
        let productTitle = UILabel()
        productTitle.numberOfLines = 0
        productTitle.textAlignment = .center
        productTitle.font = UIFont.systemFont(ofSize: 30)
        return productTitle
    }()
    
    let productDescriptionTextView: UITextView = {
        let productDescriptionTextView = UITextView()
        productDescriptionTextView.isEditable = false
        productDescriptionTextView.textAlignment = .center
        productDescriptionTextView.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return productDescriptionTextView
    }()
    
    let productPriceLabel: UILabel = {
        let productPriceLabel = UILabel()
        productPriceLabel.textAlignment = .center
        productPriceLabel.font = UIFont.systemFont(ofSize: 25, weight: .light)
        productPriceLabel.textColor = .red
        return productPriceLabel
    }()
    
    let productDate: UILabel = {
        let productDate = UILabel()
        productDate.textAlignment = .center
        productDate.textColor = .lightGray
        productDate.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return productDate
    }()
}
