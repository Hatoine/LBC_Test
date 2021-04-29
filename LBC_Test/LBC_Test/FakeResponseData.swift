//
//  FakeResponse Data.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 29/04/2021.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Data
    
    static var productsCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Products", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let incorrectData = "error".data(using: .utf8)
    
    
    // MARK: - Respons
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    
    // MARK: - Error
    
    class FakeError: Error {}
    static let error = FakeError()
}

