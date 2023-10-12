//
//  InfoItemView.swift
//  Murphy
//
//  Created by Bartu Kara on 3.10.2023.
//

import SwiftUI

struct InfoItemView: View {
    // MARK: - Properties
    
    let info : InfoModel
    
    // MARK: - Body
    var body: some View {
        Image(info.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(20)
    }
}

// MARK: - Preview
#Preview {
    InfoItemView(info: infos[0])
}
