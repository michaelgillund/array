//
//  RowView.swift
//  Array
//
//  Created by Michael Gillund on 11/3/22.
//

import SwiftUI

import SwiftUI

struct RowView: View {
    
    @EnvironmentObject
    var todo: ViewModel
    
    @Environment(\.colorScheme)
    var colorScheme
    
    // is item edit view presented?
    @State var sheetIsPresented = false
    // is item dragged enought to be deleted?
    @State var readyToBeDeleted = false
    // is alert presented?
    @State var alertIsPresented = false
    // is current item deleted?
    @State var deleting = false
    // drag gesture state
    @State var viewState = CGSize.zero
    // is long press finished?
    @State var completedLongPress = false
    // is user currently pressing
    @GestureState var isDetectingLongGesture = false

    func hapticSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func hapticWarning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }

    var valueToBeDeleted: CGFloat = -75
    
    var itemId: UUID
    var item: TodoItem? {
        return todo.getItemById(itemId: itemId)
    }

    var body: some View {
        HStack {
            Image(systemName: item?.isDone ?? false ? "circle.fill" : "circle")
                .font(.system(size: 10, weight: .black))
                .foregroundColor(.blue)

            Text(item?.title ?? "Sample Note")
                .foregroundColor(.primary)
                .strikethrough(item?.isDone ?? false)
            Spacer()
        }
        .contentShape(Rectangle())
        .offset(x: self.viewState.width < 0 ? self.viewState.width : 0)
        .scaleEffect((self.isDetectingLongGesture || self.viewState.width < 0) ? 0.95 : (self.deleting ? 0 : 1))
        .animation(.default)
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.viewState = value.translation
                    self.readyToBeDeleted = self.viewState.width < self.valueToBeDeleted ? true : false
                }
                .onEnded { _ in
                    if self.viewState.width < self.valueToBeDeleted {
                        self.alertIsPresented = true
                        self.hapticWarning()
                    }
                    self.viewState = .zero
                    self.readyToBeDeleted = false
                }
        )
        .gesture(
            LongPressGesture(minimumDuration: 0)
                .onEnded {_ in
                    self.todo.toggleItem(itemId: self.itemId)
                    self.hapticSuccess()
        })

        .alert(isPresented: self.$alertIsPresented) {
            Alert(
                title: Text("Delete Task"),
                primaryButton: .destructive(Text("Yes"), action: {
                    self.deleting = true
                    self.todo.deleteItem(itemId: self.itemId)
                }),
                secondaryButton: .cancel())
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(itemId: UUID()).environmentObject(ViewModel())
    }
}

