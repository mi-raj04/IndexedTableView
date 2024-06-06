//
//  ContentView.swift
//  SectionIndexInSwiftUIText
//
//  Created by mind on 06/06/24.
//

import SwiftUI

let database: [String: [String]] = [
  "A": [
    "Apple", "Asus", "Amazon"
  ],
  "I": [
    "iPad", "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad 6", "iPad 7", "iPad Air", "iPad Air 2", "iPad Air 3", "iPad Mini", "iPad Mini 2", "iPad Mini 3", "iPad Mini 4", "iPad Mini 5", "iPad Pro 9.7-inch", "iPad Pro 10.5-inch", "iPad Pro 11-inch", "iPad Pro 11-inch 2", "iPad Pro 12.9-inch", "iPad Pro 12.9-inch 2", "iPad Pro 12.9-inch 3", "iPad Pro 12.9-inch 4"
  ],
  "B": [
    "Banana", "Book", "Boom"
  ],
  "S": [
    "S Watch", "S Watch Series 1", "S Watch Series 2", "S Watch Series 3", "S Watch Series 4", "S Watch Series 5"
  ],
  "H": [
    "HomePod"
  ]
]

struct HeaderView: View {
  let title: String
  var body: some View {
    Text(title)
      .font(.title)
      .fontWeight(.bold)
  }
}

struct RowView: View {
  let text: String
  var body: some View {
    Text(text)
  }
}

struct ContentView: View {
  let devices: [String: [String]] = database

  var body: some View {
    ScrollViewReader { proxy in
      List {
        devicesList
      }
      .listStyle(InsetGroupedListStyle())
      .overlay(sectionIndexTitles(proxy: proxy).padding(.trailing,8))
    }
    .navigationBarTitle("Apple Devices")
  }

  var devicesList: some View {
    ForEach(devices.sorted(by: { (lhs, rhs) -> Bool in
      lhs.key < rhs.key
    }), id: \.key) { categoryName, devicesArray in
      HeaderView(title: categoryName)
      ForEach(devicesArray, id: \.self) { name in
        RowView(text: name)
      }
    }
  }

  func sectionIndexTitles(proxy: ScrollViewProxy) -> some View {
    SectionIndexTitles(proxy: proxy, titles: devices.keys.sorted())
      .frame(maxWidth: .infinity, alignment: .trailing)
      .padding()
  }
}

struct SectionIndexTitles: View {
  let proxy: ScrollViewProxy
  let titles: [String]
  @GestureState private var dragLocation: CGPoint = .zero

  var body: some View {
    VStack {
      ForEach(titles, id: \.self) { title in
          SectionIndexTitle(string: title)
          .background(dragObserver(title: title))
      }
    }
    .gesture(
      DragGesture(minimumDistance: 0, coordinateSpace: .global)
        .updating($dragLocation) { value, state, _ in
          state = value.location
        }
    )
  }

  func dragObserver(title: String) -> some View {
    GeometryReader { geometry in
      dragObserver(geometry: geometry, title: title)
    }
  }

  func dragObserver(geometry: GeometryProxy, title: String) -> some View {
    if geometry.frame(in: .global).contains(dragLocation) {
      DispatchQueue.main.async {
        proxy.scrollTo(title, anchor: .center)
      }
    }
    return Rectangle().fill(Color.clear)
  }
}

struct SectionIndexTitle: View {
  let string: String
  var body: some View {
    RoundedRectangle(cornerRadius: 8, style: .continuous)
      .foregroundColor(Color.gray.opacity(0.1))
      .frame(width: 40, height: 40)
      .overlay(
        Text(string)
          .foregroundColor(.blue)
      )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ContentView()
    }
  }
}
