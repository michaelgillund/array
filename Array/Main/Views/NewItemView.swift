//
//  NewItemView.swift
//  Array
//
//  Created by Michael Gillund on 11/3/22.
//

import SwiftUI

import SwiftUI

struct NewItemView: View {

    var todo: ViewModel

    @State var title = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            ZStack {
                List{
                    TextField("New Task", text: $title)
                    
                }
                .navigationTitle("New Task")
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .foregroundColor(.blue).opacity(0.1)
                                .frame(width: 100, height: 100)
                            Circle()
                                .foregroundColor(.blue).opacity(0.2)
                                .frame(width: 70, height: 70)
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                        }
                        .animation(.spring())
                    }
                }
                .padding(.bottom, 20)
                .padding(.trailing, 20)
                .onTapGesture {
                    let newItem = TodoItem(title: self.title)
                    self.todo.addItem(newItem: newItem)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}



struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(todo: ViewModel())
    }
}
