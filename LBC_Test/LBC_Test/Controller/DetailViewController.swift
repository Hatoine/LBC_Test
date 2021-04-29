//
//  DetailViewController.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 26/04/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var product: Products?
    let scrollView = DScrollView()
    let scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 10)
    lazy var scrollViewContainerElement = DScrollViewElement()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addScrollView(scrollView, withSafeArea: .none, hasStatusBarCover: true, statusBarBackgroundColor: .white
                           , container: scrollViewContainer, elements: [scrollViewContainerElement])
        view.backgroundColor = .white
        scrollViewContainerElement.addSubview(productImage)
        scrollViewContainerElement.addSubview(productTitleLabel)
        scrollViewContainerElement.addSubview(productPriceLabel)
        scrollViewContainerElement.addSubview(productDate)
        scrollViewContainerElement.addSubview(productDescriptionLabel)
        scrollViewContainerElement.addSubview(productIdLabel)
        scrollViewContainerElement.addSubview(categoryLabel)
        scrollViewContainerElement.addSubview(descriptionLabel)
        scrollViewContainerElement.addSubview(calendarImage)
        scrollViewContainerElement.addSubview(idImage)
        scrollViewContainerElement.addSubview(categoryImage)
        scrollViewContainerElement.addSubview(productUrgencyImage)


        productImage.anchor(top: scrollViewContainerElement.topAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productTitleLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0, enableInsets: false)

        productTitleLabel.anchor(top: productImage.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productUrgencyImage.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
       productUrgencyImage.anchor(top: productTitleLabel.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productPriceLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 20, enableInsets: false)

        productPriceLabel.anchor(top: productUrgencyImage.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: descriptionLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 25, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        descriptionLabel.anchor(top: productPriceLabel.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productDescriptionLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingBottom: 5, paddingRight: 0, width:0 , height: 0, enableInsets: false)

        productDescriptionLabel.anchor(top: descriptionLabel.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: nil, right: scrollViewContainerElement.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 32, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
        calendarImage.anchor(top: productDescriptionLabel.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productDate.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 32, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 24, enableInsets: false)

        productDate.anchor(top: calendarImage.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: idImage.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        idImage.anchor(top: productDate.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productIdLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 24, enableInsets: false)

        productIdLabel.anchor(top: idImage.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: categoryImage.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        categoryImage.anchor(top: productIdLabel.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: categoryLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 24, enableInsets: false)

        categoryLabel.anchor(top: categoryImage.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: scrollViewContainerElement.bottomAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)

        guard let imageURL = product?.images_url?.thumb else { return }
        guard let price = product?.price else { return }
        guard let date =  product?.creation_date else { return }
        guard let id =  product?.id else { return }
        guard let category =  product?.category_id else { return }


        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"

        if let date = dateFormatter.date(from: date) {
            dateFormatter.locale = Locale(identifier: "fr")
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd'T'HH:mm:ssZZZZ", options: .zero, locale: dateFormatter.locale)
            let frenchDate = dateFormatter.string(from: date)
            productDate.text = "Date de l'annonce:" + " " + frenchDate
        } else {
            print("invalid input date")
        }
        productImage.loadImageUsingCacheWithUrlString(imageURL)
        productTitleLabel.text = product?.title
        productDescriptionLabel.text = product?.description
        productPriceLabel.text = "Prix:" + " " + String(price) + " " + "€"
        productIdLabel.text = "Annonce: id" + String(id)
        productsCategories(id: category)
        productUrgencyImage.image = (product?.is_urgent == true) ? UIImage(named:"urgent2") : UIImage()
        
    }
  
    let productImage: UIImageView = {
        let productImage = UIImageView()
        productImage.contentMode = .scaleAspectFit
        productImage.clipsToBounds = true
        return productImage
    }()
    
     let productUrgencyImage: UIImageView = {
        let productUrgencyImage = UIImageView()
        productUrgencyImage.contentMode = .scaleAspectFit
        productUrgencyImage.image = UIImage(named: "urgent2")
        productUrgencyImage.clipsToBounds = true
        return productUrgencyImage
    }()
    
    let categoryImage: UIImageView = {
        let categoryImage = UIImageView()
        categoryImage.contentMode = .scaleAspectFit
        categoryImage.clipsToBounds = true
        categoryImage.image = UIImage(named: "list")
        return categoryImage
    }()
    
    let idImage: UIImageView = {
        let idImage = UIImageView()
        idImage.contentMode = .scaleAspectFit
        idImage.clipsToBounds = true
        idImage.image = UIImage(named: "id")
        return idImage
    }()
    
    let calendarImage: UIImageView = {
        let calendarImage = UIImageView()
        calendarImage.contentMode = .scaleAspectFit
        calendarImage.clipsToBounds = true
        calendarImage.image = UIImage(named: "calendar")
        return calendarImage
    }()

   let productTitleLabel: UILabel = {
        let productTitle = UILabel()
        productTitle.numberOfLines = 0
        productTitle.textAlignment = .center
    productTitle.font = UIFont.systemFont(ofSize: 30,weight: .semibold)
        return productTitle
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        descriptionLabel.text = "Description:"
        return descriptionLabel
    }()
    
    let productDescriptionLabel: UILabel = {
        let productDescriptionLabel = UILabel()
        productDescriptionLabel.textAlignment = .left
        productDescriptionLabel.numberOfLines = 0
        productDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        return productDescriptionLabel
    }()

    let productPriceLabel: UILabel = {
        let productPriceLabel = UILabel()
        productPriceLabel.textAlignment = .center
        productPriceLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        productPriceLabel.textColor = #colorLiteral(red: 1, green: 0.2776507437, blue: 0.1834815443, alpha: 1)
        return productPriceLabel
    }()

    let productDate: UILabel = {
        let productDate = UILabel()
        productDate.textAlignment = .center
        productDate.numberOfLines = 0
        productDate.textColor = .black
        productDate.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return productDate
    }()
    
    let productIdLabel: UILabel = {
        let productIdLabel = UILabel()
        productIdLabel.textAlignment = .center
        productIdLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return productIdLabel
    }()
    
    let categoryLabel:  UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return categoryLabel
    }()
    
    func productsCategories(id:Int){
        switch product?.category_id {
        case 1:
            categoryLabel.text = "Véhicule"
        case 2:
            categoryLabel.text = "Mode"
        case 3:
            categoryLabel.text = "Bricolage"
        case 4:
            categoryLabel.text = "Maison"
        case 5:
            categoryLabel.text = "Loisirs"
        case 6:
            categoryLabel.text = "Immobilier"
        case 7:
            categoryLabel.text = "Livres/CD/DVD"
        case 8:
            categoryLabel.text = "Multimédia"
        case 9:
            categoryLabel.text = "Service"
        case 10:
            categoryLabel.text = "Animaux"
        case 11:
            categoryLabel.text = "Enfants"
        default:
            print("bad")
        }
    }
}
