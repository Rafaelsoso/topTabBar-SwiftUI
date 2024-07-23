//
//  BoundsPreferenceKey.swift
//  topTabBar-SwiftUI
//
//  Created by anh.nguyen3 on 23/07/2024.
//

import SwiftUI

// MARK: - BoundsAnchor

struct BoundsAnchor {
    var idx: Int
    var bounds: Anchor<CGRect>
}

// MARK: - BoundsPreferenceKey

struct BoundsPreferenceKey: PreferenceKey {
    static var defaultValue: [BoundsAnchor] = []

    static func reduce(value: inout [BoundsAnchor], nextValue: () -> [BoundsAnchor]) {
        value.append(contentsOf: nextValue())
    }
}

