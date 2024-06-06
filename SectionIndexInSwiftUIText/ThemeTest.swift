//
//  ThemeTest.swift
//  SectionIndexInSwiftUIText
//
//  Created by mind on 06/06/24.
//

import SwiftUI

struct Theme {
    var primaryColor: Color
    var secondaryColor: Color
    var backgroundColor: Color
    var textColor: Color
}

extension Theme {
    static let light = Theme(
        primaryColor: .blue,
        secondaryColor: .green,
        backgroundColor: .white,
        textColor: .black
    )
    
    static let dark = Theme(
        primaryColor: .purple,
        secondaryColor: .orange,
        backgroundColor: .black,
        textColor: .white
    )
}

// Define the Environment Key
struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .light
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}



// Content View
struct ContentView1: View {
    @Environment(\.theme) var theme

    var body: some View {
        VStack {
            Text("Hello, World!")
                .foregroundColor(theme.textColor)
                .padding()
                .background(theme.primaryColor)
            
            Button(action: {
                // Example action
            }) {
                Text("Press Me")
                    .foregroundColor(theme.textColor)
                    .padding()
                    .background(theme.secondaryColor)
            }
        }
        .padding()
        .background(theme.backgroundColor)
    }
}

// Preview
struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        ContentView1()
            .environment(\.theme, .light)
    }
}
