//
//  ContentView.swift
//  Array
//
//  Created by Michael Gillund on 11/2/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                ListView()
                    .navigationBarTitle("Todo")
                AddButton()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewModel())
    }
}
