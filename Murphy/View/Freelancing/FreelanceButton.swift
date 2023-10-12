//
//  FreelanceButton.swift
//  Murphy
//
//  Created by Bartu Kara on 9.10.2023.
//

import SwiftUI

struct FreelanceButton: View {
    // MARK: - Properties
    
    let label : String
    let buttonColor : Color
    let textColor : Color
    
    // MARK: - Body
    var body: some View {
        Text(label)
            .foregroundStyle(textColor)
            .padding(.vertical, 15)
            .padding(.horizontal, 50)
            .background(buttonColor)
            .clipShape(.buttonBorder)
            .font(.title)
    }
}

#Preview {
    FreelanceButton(label: "Start", buttonColor: red, textColor: .white)
}
