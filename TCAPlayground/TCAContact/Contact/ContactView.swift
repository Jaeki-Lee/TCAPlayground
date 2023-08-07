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
      WithViewStore(self.store, observe: \.contacts) { viewStore in
        List {
          ForEach(viewStore.state) { contact in
            Text(contact.name)
          }
        }
        .navigationTitle("Contacts")
        .toolbar {
          ToolbarItem {
            Button {
              viewStore.send(.addButtonTapped)
            } label: {
              Image(systemName: "plus")
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
