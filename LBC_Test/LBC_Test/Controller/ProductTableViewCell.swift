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
        labelProduct.font = UIFont.systemFont(ofSize: 18)
        labelProduct.textAlignment = .center
        return labelProduct
    }()
    
    private let productPrice: UILabel = {
        let labelPrice = UILabel()
        labelPrice.numberOfLines = 0
        labelPrice.textAlignment = .center
        labelPrice.font = UIFont.systemFont(ofSize: 14)
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var product: Products?{
        didSet{
            productLablel.text = product?.title ?? ""
            productPrice.text = String(product?.price ?? Int()) + "€"
            productCategory.text = String(product?.category_id ?? Int())
            guard let imageURL = product?.images_url?.thumb else { return }
            productImage.loadImageUsingCacheWithUrlString(imageURL)
//            if product?.images_url?.thumb != "" {
//                productImage.loadImageUsingCacheWithUrlString(product?.images_url?.thumb ?? "")
//            } else {
//                productImage.image = UIImage(named: "camera")
//            }
            productUrgencyImage.image = (product?.is_urgent == true) ? UIImage(named:"urgent2") : UIImage()
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(productLablel)
        contentView.addSubview(productPrice)
       contentView.addSubview(productImage)
      contentView.addSubview(productCategory)
    contentView.addSubview(productUrgencyImage)
        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: productLablel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        productLablel.anchor(top: productImage.topAnchor, left: productImage.rightAnchor, bottom: productUrgencyImage.topAnchor, right:productPrice.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        productUrgencyImage.anchor(top: productLablel.bottomAnchor, left: productImage.rightAnchor, bottom: productCategory.topAnchor, right: productPrice.leftAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 0, height: 14, enableInsets: false)
        productCategory.anchor(top: productUrgencyImage.bottomAnchor, left: productImage.rightAnchor, bottom:nil, right: productPrice.leftAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        productPrice.anchor(top: topAnchor, left: productLablel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:70, height: 0, enableInsets: false)
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.lightGray.cgColor
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
}
