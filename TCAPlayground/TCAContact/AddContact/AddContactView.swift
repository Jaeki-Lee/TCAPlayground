//
//  AddContactView.swift
//  TCAPlayground
//
//  Created by jae on 2023/08/07.
//

import SwiftUI
import ComposableArchitecture

struct AddContactView: View {
  let store: StoreOf<AddContactFeature>
  
    var body: some View {
      WithViewStore(self.store, observe: { $0 }) { viewStore in
        Form {
          TextField("Name",
                    text: viewStore.binding(
            get: \.contact.name,
            send: { .setName($0) }
          ))
          Button("Save") {
            viewStore.send(.saveButtonTapped)
          }
        }
        .toolbar {
          ToolbarItem {
            Button("Cancel") {
              viewStore.send(.cancelButtonTapped)
            }
          }
        }
      }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(
          store: Store(
            initialState: AddContactFeature.State(
              contact: Contact(
                id: UUID(),
                name: "Blob"
              )
            ),
            reducer: {
              AddContactFeature()
            }
          )
        )
    }
}
