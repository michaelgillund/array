//
//  ViewModel.swift
//  Array
//
//  Created by Michael Gillund on 11/3/22.
//

import Foundation
import Combine

struct TodoItem: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var isDone: Bool = false
}

class ViewModel: ObservableObject {

    @Published var items = [TodoItem] ()

    init() {
        loadItems()
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func loadItems() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode([TodoItem].self, from: data)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }

    func getItemById(itemId: UUID) -> TodoItem? {
        return items.first(where: { $0.id == itemId }) ?? nil
    }
    
    func addItem(newItem: TodoItem) {
        items.append(newItem)
        saveItems()
    }
    
    func deleteItem(itemId: UUID) {
        items.removeAll(where: {$0.id == itemId})
        saveItems()
    }
    
    func editItem(item: TodoItem) {
        if let id = items.firstIndex(where: { $0.id == item.id }) {
            items[id] = item
            saveItems()
        }
    }
    
    func toggleItem(itemId: UUID) {
        if let id = items.firstIndex(where: { $0.id == itemId }) {
            items[id].isDone.toggle()
            saveItems()
        }
    }

    func documentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    func dataFilePath() -> URL {
        documentsDirectory().appendingPathComponent("Todo.plist")
    }
}
