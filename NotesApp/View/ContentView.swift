import SwiftUI

struct ContentView: View {
    @StateObject var notes = NoteManager()  // Use @StateObject to initialize and keep the same instance
    @State var menuItems:Bool = false
    @State var animate:Bool = false
    
    var body: some View {
        NavigationView{
            //                withAnimation{
            //                    Button(action:{
            //
            //                        animate.toggle()
            //                    }){
            VStack {
                if notes.items.isEmpty {
                    // Show animation when there are no notes
                    VStack {
                        Spacer()
                        Text("No notes yet! 📒")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .padding()
                            .padding(.horizontal, animate ? 0 : 170)
                        // circle with animation...
                            Circle()
                            .trim(from: 0, to: animate ? 1 : 0)
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .foregroundColor(.purple)
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(animate ? 360 : 0))
                            .onAppear {
                                withAnimation(.easeInOut(duration: 3.4).repeatForever(autoreverses: false)) {
                                    animate.toggle()
                                }
                            }
                    }
                    .transition(.opacity)
                   // Spacer()
                } else {
                    // List view when notes are available
                    List {
                        
                        ForEach(notes.items) { note in
                            VStack(alignment:.leading, spacing: 10) {
                                Text(note.title)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                
                                Text(note.content)
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom, 15)
                            }
                            
                        }
                        .onDelete(perform: deleteNote)
                        .contextMenu(menuItems: {
                            Button(action:{
                                menuItems.toggle()
                                
                            }){
                                Label("Like", systemImage: "heart.fill")
                                
                            }
                        })
                    } // list
                }
                
                //                }// animation
                //                .scaleEffect(animate ? 0.9 : 0.7)
                //                .opacity(animate ? 1.9 : 0.6)
                //                .animation(.easeInOut(duration: 0.7), value: animate)
                //                .transition(.push(from: .bottom))
                //   .rotationEffect(Angle(degrees: animate ? 0 : 40)
                
                
            }
                    .navigationTitle("Keep Notes..📒")
                    .navigationBarItems(
                        leading: EditButton(),
                        trailing: NavigationLink("Add", destination: AddView(notes: notes))
                    )
                
            }// nav
            .onAppear {
                notes.loadNotes()
            }
            
        }// body
        
          func deleteNote(at offsets: IndexSet) {
            notes.deleteNotes(at: offsets)  // Delete the notes from the NoteManager
        }
    }

#Preview {
    ContentView()
}
