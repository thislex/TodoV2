//
//  FormRowStaticView.swift
//  TodoV2
//
//  Created by Lexter Tapawan on 06/12/2023.
//

import SwiftUI

struct FormRowStaticView: View {
    // MARK: - PROPERTIES
    
    var icon: String
    var firstText: String
    var secondText: String
    
    // MARK: - BODY
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - PREVIEW

#Preview {
    FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
}
