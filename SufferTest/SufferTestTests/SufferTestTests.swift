//
//  SufferTestTests.swift
//  SufferTestTests
//
//  Created by 朴 基馥 on 2018/03/22.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import XCTest
@testable import SufferTest

class SufferTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testResultState() {
        let stateOver = TopViewModel.ResultState(result: 110)
        XCTAssertEqual(stateOver, TopViewModel.ResultState.over)
        let stateFull = TopViewModel.ResultState(result: 100)
        XCTAssertEqual(stateFull, TopViewModel.ResultState.full)
        let state90 = TopViewModel.ResultState(result: 90)
        XCTAssertEqual(state90, TopViewModel.ResultState.full)
        let state80 = TopViewModel.ResultState(result: 80)
        XCTAssertEqual(state80, TopViewModel.ResultState.full)
        let state70 = TopViewModel.ResultState(result: 70)
        XCTAssertEqual(state70, TopViewModel.ResultState.soso)
        let state60 = TopViewModel.ResultState(result: 60)
        XCTAssertEqual(state60, TopViewModel.ResultState.soso)
        let state50 = TopViewModel.ResultState(result: 50)
        XCTAssertEqual(state50, TopViewModel.ResultState.soso)
        let state40 = TopViewModel.ResultState(result: 40)
        XCTAssertEqual(state40, TopViewModel.ResultState.soso)
        let state30 = TopViewModel.ResultState(result: 30)
        XCTAssertEqual(state30, TopViewModel.ResultState.warning)
        let state20 = TopViewModel.ResultState(result: 20)
        XCTAssertEqual(state20, TopViewModel.ResultState.warning)
        let state10 = TopViewModel.ResultState(result: 10)
        XCTAssertEqual(state10, TopViewModel.ResultState.warning)
        let state0 = TopViewModel.ResultState(result: 0)
        XCTAssertEqual(state0, TopViewModel.ResultState.warning)
        let stateMinus = TopViewModel.ResultState(result: -10)
        XCTAssertEqual(stateMinus, TopViewModel.ResultState.end)
    }
    
}
