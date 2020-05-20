//
//  XCTestManifests.swift
//  SplitView
//
//  Created by Grigory Avdyushin on 20/05/2020.
//  Copyright © 2020 Grigory Avdyushin. All rights reserved.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SplitViewTests.allTests),
    ]
}
#endif
