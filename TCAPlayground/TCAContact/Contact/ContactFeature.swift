//
//  Contact.swift
//  TCAPlayground
//
//  Created by jae on 2023/08/07.
//

import Foundation
import ComposableArchitecture

struct Contact: Equatable, Identifiable {
  var id: UUID
  var name: String
}

struct ContactFeature: Reducer {
  struct State: Equatable {
    @PresentationState
    var addContact: AddContactFeature.State?
    var contacts: IdentifiedArrayOf<Contact> = []
  }
  
  enum Action: Equatable {
    case addButtonTapped
    case addContact(PresentationAction<AddContactFeature.Action>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        state.addContact = AddContactFeature.State(
          contact: Contact(id: UUID(), name: "")
        )
        return .none
        
      case .addContact(.presented(.delegate(.cancel))):
        state.addContact = nil
        return .none
      
      case let .addContact(.presented(.delegate(.saveContact(contact)))):
        state.contacts.append(contact)
//        state.addContact = nil
        
//        guard let contact = state.addContact?.contact else { return .none }
//        state.contacts.append(contact)
//        state.addContact = nil
        return .none
        
      case .addContact:
        return .none
      }
    }
    ._printChanges()
    /*
     when a child action comes into the system, and runs the parent reducer on all actions.
     */
    .ifLet(\.$addContact, action: /Action.addContact) {
      AddContactFeature()
    }
  }
}
