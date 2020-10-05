//
//  SwiftClientTests.swift
//  SwiftClientTests
//
//  Created by 游宗諭 on 2020/10/5.
//

import XCTest
import SwiftClient

class SwiftClientTests: XCTestCase {

    func test_client_run() {
        let client = Client()
        client.run()
    }
}
