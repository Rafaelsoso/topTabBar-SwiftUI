//
//  ContentView.swift
//  topTabBar-SwiftUI
//
//  Created by anh.nguyen3 on 23/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int = 0

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            TopTabBar(selection: $selection, tags: ["Segment1", "Segment2"])
        }
        .padding()
    }
}

struct TopTabBar: View {
    @Binding var selection: Int
    let tags: [String]

    var body: some View {
        GeometryReader { geometry in
            HStack() {
                ForEach(tags.indices, id: \.self) { index in
                    HStack {
                        Text(tags[index])
                            .foregroundStyle(index == selection ? .blue : .black)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selection = index
                            }
                            .anchorPreference(
                                key: BoundsPreferenceKey.self,
                                value: .bounds,
                                transform: {
                                    [BoundsAnchor(idx: index, bounds: $0)]
                                }
                            )
                            .id(index)
                    }
                    .frame(width: tags.count > 0 ? (geometry.size.width / CGFloat(tags.count)) : geometry.size.width)
                    
                }
            }
            .backgroundPreferenceValue(BoundsPreferenceKey.self) { anchors in
                GeometryReader { geometry in
                    selectedLine(geometry, anchors)
                }
            }
        }
    }
    
    private func selectedLine(_ parent: GeometryProxy, _ anchors: [BoundsAnchor]) -> some View {
        let anchor = anchors.first(where: { $0.idx == selection })
        let bounds = {
            if let anchor {
                return parent[anchor.bounds]
            } else {
                return .zero
            }
        }()
        let width = bounds.size.width * 0.80
        let height = 4.0
        let offsetX = bounds.midX - width / 2
        let offsetY = bounds.maxY - height / 2
        let spacing = 4.0
        return RoundedRectangle(cornerRadius: 2)
            .foregroundColor(.red)
            .frame(width: width, height: height)
            .offset(x: offsetX, y: offsetY + spacing)
            .animation(.easeInOut, value: selection)
    }
}
