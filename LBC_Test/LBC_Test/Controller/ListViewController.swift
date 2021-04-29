//
//  ViewController.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 21/04/2021.
//

import UIKit


final class ListViewController: UIViewController {
    
    //  MARK: - Variables
    
    private let productTableView = UITableView()
    private let productService = ProductService()
    private var product: Products?
    private var productArray = [Products]()
    private var productId = Int()
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0.6178823709, green: 0.8497449756, blue: 1, alpha: 1)
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refreshControl
    }()
    private let segmentedControl: UISegmentedControl = {
        let items  = ["Toutes", "Vehicules", "Mode", "Bricolage", "Maison",  "Loisirs", "Immobilier", "Livres/CD/DVD", "Multimédia","Service","Animaux","Enfants"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action:#selector(handleSegmentedControl) , for: .valueChanged)
        return segmentedControl
    }()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    //  MARK: - Methods
    
    func getProductsInfos() {
        productService.getProducts { (success,products ) in
            DispatchQueue.main.async {
                if success {
                    guard let products = products else { return }
                    self.productArray = products
                    self.productTableView.reloadData()
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(alert:.alertNetworkMessage)
                    }
                }
                
            }
        }
    }
    
    @objc func requestData(){
        let deadline = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            self.productTableView.reloadData()
            self.refresher.endRefreshing()
        }
    }
    
    @objc func handleSegmentedControl (){
        productTableView.reloadData()
    }
    
    func SetSegmentedControl() {
        let font = UIFont.systemFont(ofSize: 16)
        let normalAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.black]
        segmentedControl.setTitleTextAttributes(normalAttribute, for: .normal)
        let selectedAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: #colorLiteral(red: 0.2366621494, green: 0.5430950522, blue: 1, alpha: 1)]
        segmentedControl.setTitleTextAttributes(selectedAttribute, for: .selected)
        segmentedControl.tintColor = .white
        segmentedControl.setWidth(180, forSegmentAt: 0)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    func navigationController() {
        title = "Liste des annonces"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.6178823709, green: 0.8497449756, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20) as Any]
    }
    
    //  MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductsInfos()
        navigationController()
        SetSegmentedControl()
        scrollView.backgroundColor = .white
        scrollView.addSubview(segmentedControl)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(productTableView)
        view.backgroundColor = .white
        view.addSubview(scrollView)
        productTableView.refreshControl = refresher
        productTableView.rowHeight = UITableView.automaticDimension
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.translatesAutoresizingMaskIntoConstraints = false
        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        NSLayoutConstraint.activate([
            productTableView.topAnchor.constraint(equalTo:view.topAnchor,constant: 130),
            productTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            productTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            productTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 40),
            segmentedControl.topAnchor.constraint(equalTo: scrollView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
    }
}

// MARK: - UITableView

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            return productArray.count
        case 1:
            let vehiculesArray = productArray.filter { $0.category_id == 1 }
            return vehiculesArray.count
        case 2:
            let fashionArray = productArray.filter { $0.category_id == 2 }
            return fashionArray.count
        case 3:
            let toolsArray = productArray.filter { $0.category_id == 3 }
            return toolsArray.count
        case 4:
            let homeArray = productArray.filter { $0.category_id == 4 }
            return homeArray.count
        case 5:
            let entertainementArray = productArray.filter { $0.category_id == 5 }
            return entertainementArray.count
        case 6:
            let eastateArray = productArray.filter { $0.category_id == 6 }
            return eastateArray.count
        case 7:
            let booksArray = productArray.filter { $0.category_id == 7 }
            return booksArray.count
        case 8:
            let techArray = productArray.filter { $0.category_id == 8 }
            return techArray.count
        case 9:
            let serviceArray = productArray.filter { $0.category_id == 9 }
            return serviceArray.count
        case 10:
            let petsArray = productArray.filter { $0.category_id == 10 }
            return petsArray.count
        case 11:
            let kidsArray = productArray.filter { $0.category_id == 11 }
            return kidsArray.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        let productsArraySortedByDate = productArray.sorted{ $0.creation_date! > $1.creation_date!}
        let productsArraySortedByDateAndPriority = productsArraySortedByDate.sorted{ $0.is_urgent! && !$1.is_urgent!}
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            cell.product = productsArraySortedByDateAndPriority[indexPath.row]
        case 1:
            let vehiculesArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 1 }
            cell.product = vehiculesArray[indexPath.row]
        case 2:
            let fashionArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 2 }
            cell.product = fashionArray[indexPath.row]
        case 3:
            let toolsArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 3 }
            cell.product = toolsArray[indexPath.row]
        case 4:
            let homeArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 4 }
            cell.product = homeArray[indexPath.row]
        case 5:
            let entertainementArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 5 }
            cell.product = entertainementArray[indexPath.row]
        case 6:
            let eastateArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 6 }
            cell.product = eastateArray[indexPath.row]
        case 7:
            let booksArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 7 }
            cell.product = booksArray[indexPath.row]
        case 8:
            let techArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 8 }
            cell.product = techArray[indexPath.row]
        case 9:
            let serviceArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 9 }
            cell.product = serviceArray[indexPath.row]
        case 10:
            let petsArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 10 }
            cell.product = petsArray[indexPath.row]
        case 11:
            let kidsArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 11 }
            cell.product = kidsArray[indexPath.row]
        default:
            break
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productsArraySortedByDate = productArray.sorted{ $0.creation_date! > $1.creation_date!}
        let productsArraySortedByDateAndPriority = productsArraySortedByDate.sorted{ $0.is_urgent! && !$1.is_urgent!}
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            product = productsArraySortedByDateAndPriority[indexPath.row]
        case 1:
            let vehiculesArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 1 }
            product = vehiculesArray[indexPath.row]
        case 2:
            let fashionArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 2 }
            product = fashionArray[indexPath.row]
        case 3:
            let toolsArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 3 }
            product = toolsArray[indexPath.row]
        case 4:
            let homeArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 4 }
            product = homeArray[indexPath.row]
        case 5:
            let entertainementArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 5 }
            product = entertainementArray[indexPath.row]
        case 6:
            let eastateArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 6 }
            product = eastateArray[indexPath.row]
        case 7:
            let booksArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 7 }
            product = booksArray[indexPath.row]
        case 8:
            let techArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 8 }
            product = techArray[indexPath.row]
        case 9:
            let serviceArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 9 }
            product = serviceArray[indexPath.row]
        case 10:
            let petsArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 10 }
            product = petsArray[indexPath.row]
        case 11:
            let kidsArray = productsArraySortedByDateAndPriority.filter { $0.category_id == 11 }
            product = kidsArray[indexPath.row]
        default:
            break
        }
        let destination = DetailViewController()
        destination.product = product
        present(destination, animated: true, completion: nil)
    }
}

