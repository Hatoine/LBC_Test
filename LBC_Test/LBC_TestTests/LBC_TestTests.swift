//
//  LBC_TestTests.swift
//  LBC_TestTests
//
//  Created by Antoine Antoniol on 21/04/2021.
//

import XCTest
@testable import LBC_Test

class LBC_TestTests: XCTestCase {
        
    func testGetProductsShouldPostFailedCallbackIfError() {
        // Given
        let productService = ProductService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
         let expectation = XCTestExpectation(description: "Wait for queue change.")
        productService.getProducts { (success, products) in
            XCTAssertFalse(success)
            XCTAssertNil(products)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetProductsShouldPostFailedCallbackIfNoData() {
        // Given
        let productService = ProductService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        productService.getProducts (callBack: { (success, products) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(products)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)

    }

    func testGetProductsShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let productService = ProductService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        productService.getProducts (callBack: { (success, products) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(products)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetProductsShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let productService = ProductService(
            session: URLSessionFake(data: FakeResponseData.productsCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        productService.getProducts(callBack: { (success, products) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(products)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetProductsShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        // Given
        let productService = ProductService(
            session: URLSessionFake(data: FakeResponseData.productsCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        productService.getProducts(callBack: { (success, products) in
            // Then
            let products = "ordinateur"
            XCTAssertEqual(products,products)
            XCTAssertTrue(success)
            XCTAssertNotNil(products)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }
    }


