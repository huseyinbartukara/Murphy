//
//  InfoItemTabView.swift
//  Murphy
//
//  Created by Bartu Kara on 3.10.2023.
//

import SwiftUI

struct InfoItemTabView: View {
    var body: some View {
        TabView{
            ForEach(infos) {info in
                InfoItemView(info: info)
                    .padding(.top, 10)
                    .padding(.horizontal ,15)
            }//: Loop
        }//: Tab
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

#Preview {
    InfoItemTabView()
}
