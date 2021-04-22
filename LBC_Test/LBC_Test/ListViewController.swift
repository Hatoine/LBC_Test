//
//  ViewController.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 21/04/2021.
//

import UIKit


class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
                let arr = self.productArray.filter { $0.category_id == 1 }
                let array = self.productArray.filter{$0.is_urgent == true}
                let ar = self.productArray.sorted{ $0.is_urgent! && !$1.is_urgent! }
                print(ar)
                print(array)
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
        let productsArraySortedByDate = productArray.sorted{ $0.creation_date! > $1.creation_date!}
        let productsArraySortedByDateAndPriority = productsArraySortedByDate.sorted{ $1.is_urgent! && !$0.is_urgent! }
        cell.product = productsArraySortedByDateAndPriority[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Liste des produits"
    }
    
}

