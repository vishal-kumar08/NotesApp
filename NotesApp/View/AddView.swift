import SwiftUI

struct AddView: View {
    @State private var title: String = ""
    @State private var content: String = ""
    @ObservedObject var notes: NoteManager  // Use @ObservedObject to observe the same instance of NoteManager
 //   @State var TextfieldColor:Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                   
                    TextField("Title", text: $title)
                        .foregroundColor(.black)
                        .frame(height: 50)
                        .padding(.horizontal, 10)
                        .background(Color(red: 0.7, green: 0.7, blue: 0.7))
                        .cornerRadius(10)
                    
                    TextField("Content", text: $content)
                        .foregroundColor(.black)
                        .frame(height: 100)
                        .padding(.horizontal, 10)
                        .background(Color(red: 0.7, green: 0.7, blue: 0.7))
                        .cornerRadius(10)
                    
                    // Save button
                    Button(action: {
                        let newNote = Note(title: title, content: content)
                        notes.addNotes(NewNote: newNote)  // Add the new note
                        title = ""  // Clear the input fields
                        content = ""
                    }) {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .bold()
                            .foregroundColor(.white)
                            .background(.linearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 40)
            }
            .navigationTitle("Add Notes 📝")
        }
    }
}

#Preview {
    AddView(notes: NoteManager())  // Pass the notes object
}
