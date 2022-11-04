//
//  NewItemButton.swift
//  Array
//
//  Created by Michael Gillund on 11/3/22.
//

import SwiftUI

struct AddButton: View {

    @EnvironmentObject
    var todo: ViewModel

    @State
    var sheet = false
    
    @GestureState
    var gesture = false
    
    func haptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    var body: some View {
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
                .scaleEffect(self.gesture ? 0.8 : 1)
                .animation(.spring())
            }
        }
        .padding(.bottom, 20)
        .padding(.trailing, 20)
        
        .gesture(
            LongPressGesture(minimumDuration: 0.5)
                .updating($gesture) { currentState, gestureState, transaction in
                    gestureState = currentState
                }
                .onEnded {_ in
                    self.sheet = true
                    self.haptic()
                }
        )
        
        .gesture(
            LongPressGesture(minimumDuration: 0)
                .onEnded {_ in
                    self.sheet = true
                    self.haptic()
            }
        )
        .sheet(isPresented: self.$sheet) {
            NewItemView(todo: self.todo)
                .presentationDetents([.medium, .large])
        }
    }
}

struct NewItemButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton().environmentObject(ViewModel())
    }
}
