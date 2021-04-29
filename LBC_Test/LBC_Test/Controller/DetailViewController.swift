//
//  DetailViewController.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 26/04/2021.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //  MARK: - Variables
    
    var product: Products?
    private let scrollView = DScrollView()
    private let scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 10)
    private let scrollViewContainerElement = DScrollViewElement()
    private let productIdLabel : UILabel = UILabel()
    private let categoryLabel:  UILabel = UILabel()
    private let productDate: UILabel = UILabel()
    private let productPriceLabel: UILabel = UILabel()
    private let productDescriptionLabel: UILabel = UILabel()
    private let productTitleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let productImage: UIImageView = UIImageView()
    private let productUrgencyImage: UIImageView = UIImageView()
    private let categoryImage: UIImageView = UIImageView()
    private let idImage: UIImageView = UIImageView()
    private let calendarImage: UIImageView = UIImageView()
    
    
    //  MARK: - Methods
    
    func label() {
        productIdLabel.setLabel(label: productIdLabel, textAlignment: .center, numberOfLines: 0, ofSize: 15, weight: .light, textColor: UIColor.black)
        categoryLabel.setLabel(label: categoryLabel, textAlignment: .center, numberOfLines: 0, ofSize: 15, weight: .light, textColor: UIColor.black)
        productDate.setLabel(label: productDate, textAlignment: .center, numberOfLines: 0, ofSize: 15, weight: .light, textColor: UIColor.black)
        productPriceLabel.setLabel(label: productPriceLabel, textAlignment: .center, numberOfLines: 0, ofSize: 20, weight: .light, textColor: #colorLiteral(red: 1, green: 0.2776507437, blue: 0.1834815443, alpha: 1))
        productDescriptionLabel.setLabel(label: productDescriptionLabel, textAlignment: .left, numberOfLines: 0, ofSize: 18, weight: .light, textColor: UIColor.black)
        productTitleLabel.setLabel(label: productTitleLabel, textAlignment: .center, numberOfLines: 0, ofSize: 30, weight: .semibold, textColor: UIColor.black)
        descriptionLabel.setLabel(label: descriptionLabel, textAlignment: .left, numberOfLines: 0, ofSize: 21, weight: .semibold, textColor: UIColor.black)
        descriptionLabel.text = "Description"
    }
    
    func imageView() {
        calendarImage.setImageView(image: calendarImage, contentMode: .scaleAspectFit, clips: true, name: "calendar")
        productImage.setImageView(image: productImage, contentMode: .scaleAspectFit, clips: true, name: "")
        productUrgencyImage.setImageView(image: productUrgencyImage, contentMode: .scaleAspectFit, clips: true, name: "alarm2")
        categoryImage.setImageView(image: categoryImage, contentMode: .scaleAspectFit, clips: true, name: "list")
        idImage.setImageView(image: idImage, contentMode: .scaleAspectFit, clips: true, name: "id")
    }
    
    func scrollViewSubViews() {
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
    }
    
    func view() {
        view.addScrollView(scrollView, withSafeArea: .none, hasStatusBarCover: true, statusBarBackgroundColor: .white
                           , container: scrollViewContainer, elements: [scrollViewContainerElement])
        view.backgroundColor = .white
    }
    
    func viewConstraints() {
        productImage.anchor(top: scrollViewContainerElement.topAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productTitleLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        productTitleLabel.anchor(top: productImage.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productUrgencyImage.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        productUrgencyImage.anchor(top: productTitleLabel.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productPriceLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 24, enableInsets: false)
        productPriceLabel.anchor(top: productUrgencyImage.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: descriptionLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 25, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        descriptionLabel.anchor(top: productPriceLabel.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productDescriptionLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingBottom: 5, paddingRight: 0, width:0 , height: 0, enableInsets: false)
        productDescriptionLabel.anchor(top: descriptionLabel.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: calendarImage.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 32, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        calendarImage.anchor(top: productDescriptionLabel.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productDate.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 32, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 24, enableInsets: false)
        productDate.anchor(top: calendarImage.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: idImage.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        idImage.anchor(top: productDate.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: productIdLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 24, enableInsets: false)
        productIdLabel.anchor(top: idImage.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: categoryImage.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        categoryImage.anchor(top: productIdLabel.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: categoryLabel.topAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 24, enableInsets: false)
        categoryLabel.anchor(top: categoryImage.bottomAnchor, left: scrollViewContainerElement.leftAnchor, bottom: scrollViewContainerElement.bottomAnchor, right: scrollViewContainerElement.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    func productData() {
        guard let imageURL = product?.images_url?.thumb else { return }
        guard let price = product?.price else { return }
        guard let id =  product?.id else { return }
        guard let category =  product?.category_id else { return }
        productTitleLabel.text = product?.title
        productDescriptionLabel.text = product?.description
        productPriceLabel.text = "Prix:" + " " + String(price) + " " + "€"
        productIdLabel.text = "Annonce: id" + String(id)
        productsCategories(id: category)
        productImage.loadImageUsingCacheWithUrlString(imageURL)
        productUrgencyImage.image = (product?.is_urgent == true) ? UIImage(named:"alarm2") : UIImage()
    }
    
    func date() {
        let dateFormatter = DateFormatter()
        guard let date =  product?.creation_date else { return }
        
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
    }
    
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
    
    //  MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label()
        imageView()
        view()
        scrollViewSubViews()
        viewConstraints()
        date()
        productData()
    }
}
