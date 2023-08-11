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
    
    @PresentationState
    var alert: AlertState<Action.Alert>?
    
    var contacts: IdentifiedArrayOf<Contact> = []
  }
  
  enum Action: Equatable {
    case addButtonTapped
    case addContact(PresentationAction<AddContactFeature.Action>)
    case alert(PresentationAction<Alert>)
    case deleteButtonTapped(id: Contact.ID)
    enum Alert: Equatable {
      case confirmDelection(id: Contact.ID)
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        state.addContact = AddContactFeature.State(
          contact: Contact(id: UUID(), name: "")
        )
        print("add button tapped \(state.addContact)")
        return .none
        
      case .addContact(.presented(.delegate(.cancel))):
        state.addContact = nil
        print("cancel contact the addContact \(state.addContact)")
        return .none
      
      case let .addContact(.presented(.delegate(.saveContact(contact)))):
        state.contacts.append(contact)
        state.addContact = nil
        print("save contact the addContact \(state.addContact)")
//        guard let contact = state.addContact?.contact else { return .none }
//        state.contacts.append(contact)
//        state.addContact = nil
        return .none
        
      case .addContact:
        return .none
      
      case let .alert(.presented(.confirmDelection(id: id))):
        state.contacts.remove(id: id)
        return .none
        
      case .alert:
        return .none
        
      case let .deleteButtonTapped(id: id):
        state.alert = AlertState(title: {
          TextState("Are you sure?")
        }, actions: {
          ButtonState(role: .destructive, action: .confirmDelection(id: id)) {
            TextState("Delete")
          }
        })
        return .none
      }
    }
//    ._printChanges()
    /*
     when a child action comes into the system, and runs the parent reducer on all actions.
     */
    .ifLet(\.$addContact, action: /Action.addContact) {
      AddContactFeature()
    }
    .ifLet(\.$alert, action: /Action.alert)
  }
}
