//
//  ViewController.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 21/04/2021.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let productTableView = UITableView()
    let productService = ProductService()
    private var product: Products?
    var productArray = [Products]()
    private var productId = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(productTableView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        productTableView.rowHeight = UITableView.automaticDimension
        productService.getProducts { (success,products ) in
            if success {
                guard let products = products else { return }
                self.productArray = products
                self.productTableView.reloadData()
            } else {
                print("error")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        productTableView.frame = view.bounds
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        cell.product = productArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Liste des produits"
    }
    
}

