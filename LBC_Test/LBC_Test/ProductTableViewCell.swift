//
//  ProductTableViewCell.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 21/04/2021.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "ProductTableViewCell"
    
    
    private let productLablel: UILabel = {
        let labelProduct = UILabel()
        labelProduct.numberOfLines = 3
        labelProduct.textColor = .black
        labelProduct.font = UIFont.systemFont(ofSize: 16)
        labelProduct.textAlignment = .center
        return labelProduct
    }()
    
    private let productPrice: UILabel = {
        let labelPrice = UILabel()
        labelPrice.numberOfLines = 0
        labelPrice.font = UIFont.systemFont(ofSize: 16)
        return labelPrice
    }()
    
    private let productImage: UIImageView = {
        let productImage = UIImageView()
        productImage.contentMode = .scaleAspectFit
        productImage.clipsToBounds = true
        return productImage
    }()
    
    private let productCategory: UILabel = {
        let labelCategory = UILabel()
        labelCategory.textColor = .lightGray
        labelCategory.textAlignment = .center
        return labelCategory
    }()
    
    private let productUrgencyImage: UIImageView = {
        let productUrgencyImage = UIImageView()
        productUrgencyImage.contentMode = .scaleAspectFit
        productUrgencyImage.clipsToBounds = true
        return productUrgencyImage
    }()
    
    var product: Products?{
        didSet{
            productLablel.text = product?.title ?? ""
            productPrice.text = String(product?.price ?? Int()) + "€"
            productCategory.text = String(product?.category_id ?? Int())
            guard let imageURL = product?.images_url?.thumb else { return }
            if imageURL != "" {

                productImage.loadImageUsingCacheWithUrlString(imageURL)
            } else {
                productImage.backgroundColor = .lightGray

            }
            
            guard let urgency = product?.is_urgent else { return }
            imageUrgency(isUrgent: urgency)
            guard let id  = product?.category_id else { return }
            productsCategories(id: id)
        }
    }
    
    func productsCategories(id:Int){
        switch product?.category_id {
        case 1:
            productCategory.text = "Véhicule"
        case 2:
            productCategory.text = "Mode"
        case 3:
            productCategory.text = "Bricolage"
        case 4:
            productCategory.text = "Maison"
        case 5:
            productCategory.text = "Loisirs"
        case 6:
            productCategory.text = "Immobilier"
        case 7:
            productCategory.text = "Livres/CD/DVD"
        case 8:
            productCategory.text = "Multimédia"
        case 9:
            productCategory.text = "Service"
        case 10:
            productCategory.text = "Animaux"
        case 11:
            productCategory.text = "Enfants"
        default:
            print("bad")
        }
    }
    
    func imageUrgency(isUrgent:Bool){
        if product?.is_urgent == true {
            productUrgencyImage.image = UIImage()
        } else {
            productUrgencyImage.image = UIImage(named: "bell")
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(productLablel)
        contentView.addSubview(productPrice)
        contentView.addSubview(productImage)
        contentView.addSubview(productCategory)
        contentView.addSubview(productUrgencyImage)
        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        productLablel.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: nil, right:nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width * 0.5, height: 0, enableInsets: false)
        productCategory.anchor(top: productLablel.bottomAnchor, left: productImage.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        productPrice.anchor(top: topAnchor, left: productUrgencyImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: 10, paddingBottom: 5, paddingRight: 5, width: 70, height: 0, enableInsets: true)
        productUrgencyImage.anchor(top: topAnchor, left: productLablel.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
