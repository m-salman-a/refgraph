//
//  AccentButtonView.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 29/07/22.
//

import SwiftUI

struct AccentButtonView: View {
    
    let buttonAction: (() -> Void)
    let buttonText = "Submit"
    var color = Color.green
    
    init(_ buttonAction: @escaping (() -> Void)) {
        self.buttonAction = buttonAction
    }
    
    init(color: Color, _ buttonAction: @escaping (() -> Void)) {
        self.color = color
        self.buttonAction = buttonAction
    }
    
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
