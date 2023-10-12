//
//  TimerButton.swift
//  Murphy
//
//  Created by Bartu Kara on 7.10.2023.
//

import SwiftUI

struct TimerButton: View {
    // MARK: - Properties
    
    let label : String
    let buttonColor : Color
    let textColor : Color
    
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
    TimerButton(label: "Start", buttonColor: .white, textColor: grayWhite)
}
