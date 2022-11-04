//
//  ArrayApp.swift
//  Array
//
//  Created by Michael Gillund on 11/2/22.
//

import SwiftUI

@main
struct ArrayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
        }
    }
}
