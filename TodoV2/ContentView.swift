//
//  ContentView.swift
//  TodoV2
//
//  Created by Lexter Tapawan on 05/12/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var todoItems: [TodoItem]
    
    @State private var showingAddTodoView: Bool = false
    
    // MARK: - FUNCTIONS
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(todoItems[index])
            }
        }
    }

    // MARK: - BODY
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(todoItems) { item in
                    NavigationLink {
                        Text("Item at \(item.name)")
                    } label: {
                        Text(item.name)
                        Spacer()
                        Text(item.priority)
                    }
                }
                .onDelete(perform: deleteItems)
            }//: LIST
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus")
                    } //: ADD BUTTON
                    .sheet(isPresented: $showingAddTodoView) {
                        AddTodoView()
                    }
                }
            }
        } //: NAVIGATION
    detail: {
            Text("Select an item")
        }
    }
}
// MARK: - PREVIEW

#Preview {
    ContentView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
