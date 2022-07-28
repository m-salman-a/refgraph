//
//  AccentButtonView.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 29/07/22.
//

import SwiftUI

struct AccentButtonView: View {
    
    let buttonAction: (() -> Void)
    let color = Color.green
    let buttonText = "Submit"
    
    var body: some View {
        Button(action: buttonAction, label: {
            Text(buttonText)
                .bold()
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
        }).background(color)
            .cornerRadius(8)
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding()
    }
}

struct AccentButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AccentButtonView {
            
        }
    }
}
