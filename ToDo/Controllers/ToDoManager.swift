//
//  ToDoManager.swift
//  ToDo
//
//  Created by Zachary Buffington on 9/8/21.
//

import Foundation

class ToDoNoteManager {
    var todoNotes: [TodoNote] = []
    var fileURL: URL {
    var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        url.appendPathComponent("notes")
        url.appendPathComponent("json")
        return url
    
       }
    
    init() {
        loadNotes()
    }
    
    func createTodo(title: String, subtitle: String) {
        let note = TodoNote(title: title, subtitle: subtitle)
        todoNotes.append(note)
        
        saveNotes()
    }
    
    func deleteTodo(note: TodoNote) {
        // get the index
        guard let index = todoNotes.firstIndex(of: note) else { return }
        
        todoNotes.remove(at: index)
        
        
        
    }
    func saveNotes() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(todoNotes)
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
        
    }
    func loadNotes() {
        do {
          let decoder = JSONDecoder()
            let data = try Data(contentsOf: fileURL)
            let todoNotes = try decoder.decode([TodoNote].self, from: data)
            self.todoNotes = todoNotes
        } catch {
            print(error)
        }
        
    }
}
