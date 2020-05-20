# SplitView

Split View component for SwiftUI that allows to have two manually resizable views.

<img src="https://raw.githubusercontent.com/avdyushin/SplitView/master/Assets/SplitView.gif" width="200px" />

### How to use?

Create `SliderControlViewModel` with middle position as protortion of full height
and range for maximum and minumum expand.

```swift
let viewModel = SliderControlViewModel(
    middle: 0.5, // 50%
    range: 0.2...0.8 // 20%...80%
)
```

This view model has middle postion at half of full height of container.

Minimum position is 20% of height and maximum is 80% of height.

Create `SplitView` with `viewModel` and this three views:

1. `controlView` is content view of the slider itself;
1. `topView` is content view of the top view;
1. `bottomView` is content view of the bottom view.

```swift
let view = SplitView(
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
```

### How to add it to Xcode project?

1. In Xcode select **File ⭢ Swift Packages ⭢ Add Package Dependency...**
1. Copy-paste repository URL: **https://github.com/avdyushin/SplitView**
1. Hit **Next** two times, under **Add to Target** select your build target.
1. Hit **Finish**
