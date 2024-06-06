//
//  SectionIndexInSwiftUITextApp.swift
//  SectionIndexInSwiftUIText
//
//  Created by mind on 06/06/24.
//

import SwiftUI

//@main
//struct SectionIndexInSwiftUITextApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView1()
//        }
//    }
//}
//
@main
struct MyApp: App {
    @State private var currentTheme = Theme.light

    var body: some Scene {
        WindowGroup {
            ContentView1()
                .environment(\.theme, currentTheme)
                .onAppear {
                    // Example: Change theme after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        currentTheme = .dark
                    }
                }
        }
    }
}
