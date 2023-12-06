//
//  FormRowLinkView.swift
//  TodoV2
//
//  Created by Lexter Tapawan on 06/12/2023.
//

import SwiftUI

struct FormRowLinkView: View {
    
    // MARK: - PROPERTIES
    
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(text).foregroundStyle(Color.gray)
            
            Spacer()
            
            Button(action: {
                // OPEN A LINK
                guard let url = URL(string: self.link),
                      UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
            }) {
              Image(systemName: "chevron-right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            .foregroundStyle(Color.accentColor)
        }
    }
}

// MARK: - PREVIEW

#Preview {
    FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://swiftmasterclass.com")
}
