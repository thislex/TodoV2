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
    
    let priorities = ["High", "Normal", "Low"]
    
    @Query private var items: [Item]
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
                Form {
                    // MARK: - TODO NAME
                    TextField("Todo", text: $name)
                    
                    // MARK: - TODO PRIORITY
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // MARK: - SAVE BUTTON
                    Button("Save") {
                        addItem()
                    }
                } //: FORM
                
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
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW

#Preview {
    AddTodoView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
