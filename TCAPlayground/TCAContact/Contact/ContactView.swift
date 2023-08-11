//
//  ContactView.swift
//  TCAPlayground
//
//  Created by jae on 2023/08/07.
//

import SwiftUI
import ComposableArchitecture

struct ContactView: View {
  let store: StoreOf<ContactFeature>
  
  var body: some View {
    NavigationStack {
      WithViewStore(self.store, observe: { $0 }) { viewStore in
        List {
          ForEach(viewStore.state.contacts) { contact in
            HStack {
              Text(contact.name)
              Spacer()
              Button {
                viewStore.send(.deleteButtonTapped(id: contact.id))
              } label: {
                Image(systemName: "trash")
                  .foregroundColor(.red)
              }

            }
          }
        }
        .navigationTitle("Contacts")
        .toolbar {
          ToolbarItem {
//            Button {
//              viewStore.send(.addButtonTapped)
//            } label: {
//              Image(systemName: "plus")
//            }
            Image(systemName: "plus")
              .onTapGesture {
                print("plus button tapped")
                viewStore.send(.addButtonTapped)
              }
          }
        }
        .sheet(
          store: self.store.scope(
            state: \.$addContact,
            action: { .addContact($0) }
          )
        ) { addContactStore in
          NavigationStack {
            AddContactView(store: addContactStore)
          }
        }
        .alert(
          store: self.store.scope(
            state: \.$alert,
            action: { .alert($0) }
          )
        )
      }
    }
  }
}

struct ContactView_Previews: PreviewProvider {
  static var previews: some View {
    ContactView(
      store: Store(
        initialState: {
        ContactFeature.State(
          contacts: [
            Contact(id: UUID(), name: "Blob"),
            Contact(id: UUID(), name: "Blob Jr"),
            Contact(id: UUID(), name: "Blob Sr"),
          ]
        )
      }(),
        reducer: {
        ContactFeature()
      })
    )
  }
}
