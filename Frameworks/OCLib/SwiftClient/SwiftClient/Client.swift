//
//  Client.swift
//  SwiftClient
//
//  Created by 游宗諭 on 2020/10/5.
//

import Foundation
import OCLib
public struct Client {
    public init() {}
    public func run() {
        let point = OCPoint()
        dump(point)
        print(point.x)
        print(point.y)
        point.x = 1
        point.y = 2
        print(point.x)
        print(point.y)
    }
}
