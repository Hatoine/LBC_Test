//
//  ProductService.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 21/04/2021.
//

import Foundation



final class ProductService {
    
    // MARK: - Properties
    
    private var task: URLSessionDataTask?
    private let session: URLSession
    
    // MARK: - Initialization
    
    init(session:URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Methods
    
    /// Network call to get currencies symbols
    
    func getProducts(callBack: @escaping (Bool, [Products]?)->Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else { return }
        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                    callBack(false, nil)
                    return }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil)
                    return }

                guard let responseJSON = try? JSONDecoder().decode([Products].self, from: data) else {
                    callBack(false, nil)
                    return }
                DispatchQueue.main.async {
                    callBack(true, responseJSON)
                }
            }
        
        task?.resume()
    }
    
//    func getProductsCategories(callBack: @escaping (Bool, [ID]?)->Void) {
//        task?.cancel()
//        let session = URLSession.shared
//        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json") else { return }
//        
//        task = session.dataTask(with: url) { (data, response, error) in
//
//            guard let data = data, error == nil else {
//                callBack(false, nil)
//                return }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                callBack(false, nil)
//                return }
//
//            guard let responseJSON = try? JSONDecoder().decode([ID].self, from: data) else {
//                callBack(false, nil)
//                return }
//            
//            DispatchQueue.main.async {
//                callBack(true, responseJSON)
//            }
//            print(responseJSON)
//        }
//        task?.resume()
//    }

}
