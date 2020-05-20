//
//  SplitViewTests.swift
//  SplitView
//
//  Created by Grigory Avdyushin on 20/05/2020.
//  Copyright © 2020 Grigory Avdyushin. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SplitView

final class SplitViewTests: XCTestCase {

    func testViewModel() {
        let viewModel = SliderControlViewModel(middle: 0.5, range: 0.2...0.8)
        XCTAssertEqual(viewModel.current, 0)
        XCTAssertEqual(viewModel.previous, 0)
        XCTAssertFalse(viewModel.isMax)
        XCTAssertFalse(viewModel.isMin)
    }

    func testView() {
        let viewModel = SliderControlViewModel(middle: 0.5, range: 0.2...0.8)
        _ = SplitView(
            viewModel: viewModel,
            controlView: {
                Group {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill()
                            .frame(width: 24, height: 6)
                    }
                }
                .foregroundColor(Color.green)
                .frame(minWidth: 0, maxWidth: .infinity)
        },
            topView: { Text("Top View") },
            bottomView: { Text("Bottom View") }
        )
    }

    static var allTests = [
        ("testViewModel", testViewModel),
        ("testView", testView)
    ]
}
