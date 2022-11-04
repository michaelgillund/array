//
//  ListView.swift
//  Array
//
//  Created by Michael Gillund on 11/3/22.
//

import SwiftUI

struct ListView: View {

    @EnvironmentObject
    var todo: ViewModel

    var body: some View {
        List{
            ForEach(self.todo.items) { item in
                RowView(itemId: item.id)
            }
        }
        .task {
            todo.loadItems()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(ViewModel())
    }
}
