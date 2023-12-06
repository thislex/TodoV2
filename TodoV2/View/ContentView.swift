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
    @State private var animatingButton: Bool = false
    
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
                    }
                }
                
                // MARK: - NO TODO ITEMS
                if todoItems.count == 0 {
                    EmptyListView()
                }
            } //: ZSTACK
            .sheet(isPresented: $showingAddTodoView) {
                AddTodoView()
            }
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(.easeOut(duration: 2).repeatForever(autoreverses: true), value: animatingButton)
                    
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                } //: BUTTON
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                } //: ZSTACK
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
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
