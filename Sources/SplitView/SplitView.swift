//
//  SplitView.swift
//  SplitView
//
//  Created by Grigory Avdyushin on 20/05/2020.
//  Copyright © 2020 Grigory Avdyushin. All rights reserved.
//

import SwiftUI

public class SliderControlViewModel: ObservableObject {

    @Published public var current: CGFloat = 0
    @Published public var previous: CGFloat = 0

    @Published public var isMax = false
    @Published public var isMin = false

    public var middle: CGFloat
    public var range: ClosedRange<CGFloat>

    public init(middle: CGFloat = 0.5, range: ClosedRange<CGFloat> = 0.2...0.8) {
        self.middle = middle
        self.range = range
    }
}

struct SliderControl<Content: View>: View {

    @ObservedObject var viewModel: SliderControlViewModel

    var geometry: GeometryProxy
    let content: () -> Content

    var body: some View {
        VStack {
            content()
        }
        .offset(y: geometry.size.height * (0.5 - viewModel.middle) + viewModel.current)
        .gesture(
            DragGesture()
                .onChanged(onDragChanged)
                .onEnded(onDragEnded)
        )
    }

    fileprivate var maxLimit: CGFloat {
        geometry.size.height * (viewModel.middle - viewModel.range.upperBound)
    }

    fileprivate var minLimit: CGFloat {
        geometry.size.height * (viewModel.middle - viewModel.range.lowerBound)
    }

    fileprivate func onDragChanged(_ gesture: DragGesture.Value) {
        let height = viewModel.previous + gesture.translation.height

        viewModel.current = max(maxLimit, min(minLimit, height))
        viewModel.isMax = viewModel.current == maxLimit
        viewModel.isMin = viewModel.current == minLimit
    }

    fileprivate func onDragEnded(_ gesture: DragGesture.Value) {
        viewModel.previous = viewModel.current
    }
}

public struct SplitView<ControlView: View, TopContent: View, BottomContent: View>: View {

    @ObservedObject public var viewModel: SliderControlViewModel

    public var controlView: () -> ControlView
    public var topView: () -> TopContent
    public var bottomView: () -> BottomContent

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Group {
                        self.topView()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    }
                    Group {
                        self.bottomView()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .frame(height: geometry.size.height * self.viewModel.middle - self.viewModel.current)
                    }
                }
                SliderControl(viewModel: self.viewModel, geometry: geometry) {
                    Group {
                        self.controlView()
                    }
                }
            } // ZStack
        } // GeometryReader
    }
}
