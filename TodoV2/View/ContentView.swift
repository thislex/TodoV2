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
                
                do {
                    try modelContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
        NavigationSplitView {
            ZStack {
                List {
                    ForEach(todoItems) { item in
                        HStack {
                            Text(item.name)
                            
                            Spacer()
                            
                            Text(item.priority)
                        }
                    } //: FOR EACH
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
                
                // MARK: - NO TODO ITEMS
                if todoItems.count == 0 {
                    EmptyListView()
                }
            } //: ZSTACK
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
