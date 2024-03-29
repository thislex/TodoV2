//
//  AddTodoView.swift
//  TodoV2
//
//  Created by Lexter Tapawan on 05/12/2023.
//

import SwiftUI
import SwiftData

struct AddTodoView: View {
    // MARK: - PROPERTIES
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    let priorities = ["High", "Normal", "Low"]
    
    
    @Query private var todoItems: [TodoItem]
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    
    // MARK: - FUNCTIONS
    
    private func addItem() {
        withAnimation {
            let newItem = TodoItem(name: self.name, priority: self.priority)
            modelContext.insert(newItem)
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - TODO NAME
                    TextField("Todo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 9))
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
                    // MARK: - TODO PRIORITY
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // MARK: - SAVE BUTTON
                    Button("Save") {
                        if self.name != "" {
                            addItem()
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for\nthe new todo item"
                            return
                        }
                        dismiss()
                    }
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 9))
                    .foregroundStyle(Color.white)
                } //: VSTACK
                .padding(.horizontal)
                .padding(.vertical, 30)
                
                Spacer()
            } //: VSTACK
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                }
            })
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW

#Preview {
    AddTodoView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
