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
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
               refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refreshControl
    }()
    
    @objc func requestData(){
        let deadline = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            self.productTableView.reloadData()
            self.refresher.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.refreshControl = refresher
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        view.addSubview(productTableView)
        productTableView.translatesAutoresizingMaskIntoConstraints = false
        productTableView.topAnchor.constraint(equalTo:view.topAnchor,constant: 90).isActive = true
        productTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        productTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        productTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    
    fileprivate func getProductsInfos() {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getProductsInfos()
        productTableView.rowHeight = UITableView.automaticDimension
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(segmentedControl)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
                 scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                 scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                 scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                 scrollView.heightAnchor.constraint(equalToConstant: 50),
                 
             ])
         }
    
    
    let segmentedControl: UISegmentedControl = {
        let items  = ["Toutes", "Vehicules", "Mode", "Bricolage", "Maison",  "Loisirs", "Immobilier", "Livres/CD/DVD", "Multimédia","Service","Animaux","Enfants"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action:#selector(handleSegmentedControl) , for: .valueChanged)
        return segmentedControl
    }()
    
    @objc func handleSegmentedControl (){
        productTableView.reloadData()
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
  
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
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        let productsArraySortedByDate = productArray.sorted{ $0.creation_date! > $1.creation_date!}
        let productsArraySortedByDateAndPriority = productsArraySortedByDate.sorted{ $1.is_urgent! && !$0.is_urgent!}
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
            
        return cell
        }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Liste des produits"
    }
  
//    let items  = ["Toutes", "Mode", "Bricolage", "Maison",  "Loisirs", "Immobilier", "Livres/CD/DVD", "Multimédia","Service","Animaux","Enfants"]
    
//    let all = UIButton().createSegmentedControlButton(setTitle: "Toutes")
//
//    let fashion = UIButton().createSegmentedControlButton(setTitle: "Mode")
//
//    let tools = UIButton().createSegmentedControlButton(setTitle: "Bricolage")
//
//    let home = UIButton().createSegmentedControlButton(setTitle: "Maison")
//
//    let entertainment = UIButton().createSegmentedControlButton(setTitle: "Loisirs")
//
//    let realEastate = UIButton().createSegmentedControlButton(setTitle: "Immobilier")
//
//    let books = UIButton().createSegmentedControlButton(setTitle: "Livres/CD/DVD")
//
//    let tech = UIButton().createSegmentedControlButton(setTitle: "Multimédia")
//
//    let service = UIButton().createSegmentedControlButton(setTitle: "Service")
//
//    let pets = UIButton().createSegmentedControlButton(setTitle: "Animaux")
//
//    let kids = UIButton().createSegmentedControlButton(setTitle: "Enfants")
//
//    let segmentedControlBackgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
//
//    lazy var segmentedControl = UISegmentedControl(items: items)
//
//
//    @objc func handleSegmentedControlButtons(sender: UIButton) {
//        let segmentedControlButtons: [UIButton] = [
//            all,
//            fashion,
//            tools,
//            home,
//            entertainment,
//            realEastate,
//            books,
//            tech,
//            service,
//            pets,
//            kids
//        ]
//
//        productTableView.reloadData()
//
//        for button in segmentedControlButtons {
//            if button == sender {
//                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) {
//                    button.backgroundColor = .white
//                }
//            } else {
//                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) { [weak self] in
//                    button.backgroundColor = self?.segmentedControlBackgroundColor
//                }
//            }
//        }
//    }
//
//    func configureCustomSegmentedControl() {
//        let segmentedControlButtons: [UIButton] = [
//            all,
//            fashion,
//            tools,
//            home,
//            entertainment,
//            realEastate,
//            books,
//            tech,
//            service,
//            pets,
//            kids
//        ]
//
//        segmentedControlButtons.forEach {$0.addTarget(self, action: #selector(handleSegmentedControlButtons(sender:)), for: .valueChanged)}
//
//        let stackView = UIStackView(arrangedSubviews: segmentedControlButtons)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//
//        let scrollView = UIScrollView()
//        scrollView.contentSize = CGSize(width: .zero, height: 50)
//        scrollView.backgroundColor = segmentedControlBackgroundColor
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//
//        scrollView.addSubview(stackView)
//
//        view.addSubview(scrollView)
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.heightAnchor.constraint(equalToConstant: 50),
//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            stackView.heightAnchor.constraint(equalToConstant: 40)
//        ])
//    }
//
//    func configureScrollableSegmentedControl() {
//
//        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
//
//        let scrollView = UIScrollView()
//        scrollView.contentSize = CGSize(width: .zero, height:50)
//
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//
//        scrollView.addSubview(segmentedControl)
//        view.addSubview(scrollView)
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.heightAnchor.constraint(equalToConstant: 50),
//
//            segmentedControl.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            segmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            segmentedControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
//        ])
//
//    }
//}
//
//extension UIButton {
//    func createSegmentedControlButton(setTitle to: String) -> UIButton {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle(to, for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
//        button.layer.cornerRadius = 6
//        button.layer.borderWidth = 0.2
//        button.layer.borderColor = UIColor.black.cgColor
//        return button
//    }
    
}

