//
//  ProductTableViewCell.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 21/04/2021.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    
    //  MARK: - Variables
    
    static let identifier = "ProductTableViewCell"
    private let productLabel: UILabel = UILabel()
    private let productPrice: UILabel = UILabel()
    private let productCategory: UILabel = UILabel()
    private let productImage: UIImageView = UIImageView()
    private let productUrgencyImage: UIImageView = UIImageView()
    var product: Products?{
        didSet{
            setData()
        }
    }
    
    //  MARK: - Methods
    
    func setData(){
        productLabel.text = product?.title ?? ""
        productPrice.text = String(product?.price ?? Int()) + "€"
        productCategory.text = String(product?.category_id ?? Int())
        guard let imageURL = product?.images_url?.thumb else { return }
        if product?.images_url?.thumb == "" {
            productImage.image = UIImage(named: "camera")
        } else {
            productImage.loadImageUsingCacheWithUrlString(imageURL)
        }
        productUrgencyImage.image = (product?.is_urgent == true) ? UIImage(named:"alarm2") : UIImage()
        guard let id  = product?.category_id else { return }
        productsCategories(id: id)
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
    
    func cellConstraints() {
        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: productLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        productLabel.anchor(top: productImage.topAnchor, left: productImage.rightAnchor, bottom: productUrgencyImage.topAnchor, right:productPrice.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        productUrgencyImage.anchor(top: productLabel.bottomAnchor, left: productImage.rightAnchor, bottom: productCategory.topAnchor, right: productPrice.leftAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 0, height: 24, enableInsets: false)
        productCategory.anchor(top: productUrgencyImage.bottomAnchor, left: productImage.rightAnchor, bottom:nil, right: productPrice.leftAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        productPrice.anchor(top: topAnchor, left: productLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:70, height: 0, enableInsets: false)
    }
    
    func label() {
        productPrice.setLabel(label: productPrice, textAlignment: .center, numberOfLines: 0, ofSize: 14, weight:.regular , textColor: UIColor.black)
        productLabel.setLabel(label: productLabel, textAlignment: .center, numberOfLines: 3, ofSize: 18, weight:.regular, textColor: UIColor.black)
        productCategory.setLabel(label: productCategory, textAlignment: .center, numberOfLines: 0, ofSize: 15, weight: .regular, textColor: UIColor.lightGray)
    }
    
    func imageView() {
        productImage.setImageView(image: productImage, contentMode: .scaleAspectFit, clips: true, name: "")
        productUrgencyImage.setImageView(image: productUrgencyImage, contentMode: .scaleAspectFit, clips: true, name: "")
    }
    
    func contentSubviews() {
        contentView.addSubview(productLabel)
        contentView.addSubview(productPrice)
        contentView.addSubview(productImage)
        contentView.addSubview(productCategory)
        contentView.addSubview(productUrgencyImage)
    }
    
    func setCell() {
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.lightGray.cgColor
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
    
    //  MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label()
        imageView()
        contentSubviews()
        cellConstraints()
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
}
