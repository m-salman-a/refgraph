//
//  FormView.swift
//  RefGraph
//
//  Created by Mohammad Alfarisi on 29/07/22.
//

import SwiftUI

// TODO: add input error handling
struct ReferenceFormView: View {
    
    var onSubmit: ((Reference) -> Void)
    
    @State var title = ""
    @State var link = ""
    @State var description = ""
    @State var tags = ""
    @Environment(\.presentationMode) var presentationMode
    
    var canSubmit: Bool {
        !title.isEmpty
    }
    
    var body: some View {
        ScrollView {
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
                Text("Insert the Reference Tags! (separate with ,)")
                TextField("Tags here", text: $tags)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                AccentButtonView(color: canSubmit ? .green : .gray) {
                    let reference = Reference(
                        title: title,
                        url: URL(string: link),
                        description: description,
                        tags: tags
                            .split(separator: ",")
                            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) })
                    
                    presentationMode.wrappedValue.dismiss()
                    onSubmit(reference)
                }.disabled(!canSubmit)
            }.padding(.all)
        }
    }
}

struct ReferenceFormView_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceFormView { _ in }
    }
}
