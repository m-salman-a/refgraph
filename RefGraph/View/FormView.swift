//
//  FormView.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 29/07/22.
//

import SwiftUI

// TODO: add input error handling
struct FormView: View {
    
    @ObservedObject
    var viewModel: ReferenceGraphViewModel
    @State var title = ""
    @State var link = ""
    @State var description = ""
    @State var tags = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Insert the Title")
            TextField("Title here", text: $title)
                .textFieldStyle(.roundedBorder)
            Text("Add the Link")
            TextField("Link here", text: $link)
                .textFieldStyle(.roundedBorder)
            Text("Add your Brief Description! (optional)")
            TextField("Brief description here", text: $description)
                .textFieldStyle(.roundedBorder)
            Text("Insert the Reference Tags! (separate with ,")
            TextField("Tags here", text: $tags)
                .textFieldStyle(.roundedBorder)
            Spacer()
            AccentButtonView {
                let reference = Reference(
                    title: title,
                    url: URL(string: link),
                    description: description,
                    tags: tags
                        .split(separator: ",")
                        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) })
                
                viewModel.addVertex(with: reference)
                
                presentationMode.wrappedValue.dismiss()
            }
        }.padding(.all)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(viewModel: ReferenceGraphViewModel())
    }
}
