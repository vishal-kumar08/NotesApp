import Foundation
import Combine

class NoteManager: ObservableObject {
    @Published var items: [Note] = []  // Notes array
    
    private let userDefaultsKey = "Mykey"
    
    init() {
        loadNotes()  // Load notes when the NoteManager is initialized
    }
    
    // Add a new note
    func addNotes(NewNote: Note) {
        items.append(NewNote)
        saveNotes()  // Save updated notes
    }
    
    // Save notes to UserDefaults
    private func saveNotes() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }
    
    // Load notes from UserDefaults
        func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedNotes = try? JSONDecoder().decode([Note].self, from: data) {
            self.items = decodedNotes
        }
    }
    

    
    func deleteNotes(at offsets: IndexSet) {
            items.remove(atOffsets: offsets)
          saveNotes()
    }
}

