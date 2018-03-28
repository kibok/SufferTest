//
//  APITest.swift
//  SufferTestTests
//
//  Created by 朴 基馥 on 2018/03/22.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import XCTest
@testable import SufferTest

class APITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLogin() {
        AuthFetcher.login(email: "test@test.com", password: "000000") { error in
            HistoryFetcher.readProject(completion: { error in
                XCTAssertNil(error)
            })
        }
    }
    
    func testReadHistory() {
        HistoryFetcher.readProject { error in
            XCTAssertNil(error)
        }
    }
    
}
