//
//  SettingsView.swift
//  TodoV2
//
//  Created by Lexter Tapawan on 06/12/2023.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    
    var body: some View {
        NavigationSplitView {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - FORM
                
                Form {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                } //: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK: - FOOTER
                
                Text("Copyright © All rights reserved.\nBetter Apps ♡ Less Code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundStyle(Color.secondary)
            } //: VSTACK
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("ColorBackground"))
            //.ignoresSafeArea(edges: .all)
        } //: NAVIGATION
    detail: {
        Text("Settings")
    }
    }
}

// MARK: - PREVIEW

#Preview {
    SettingsView()
}
