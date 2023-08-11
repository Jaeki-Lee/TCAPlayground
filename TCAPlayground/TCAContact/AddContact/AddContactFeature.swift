//
//  AddContactFeature.swift
//  TCAPlayground
//
//  Created by jae on 2023/08/07.
//

import ComposableArchitecture

struct AddContactFeature: Reducer {
  struct State: Equatable {
    var contact: Contact
  }
  
  enum Action: Equatable {
    case cancelButtonTapped
    case saveButtonTapped
    case setName(String)
    case delegate(Delegate)
    
    /*
     A better pattern is to use so-called “delegate actions” for the child feature to directly tell the parent what it wants done.
     */
    enum Delegate: Equatable {
      case cancel
      case saveContact(Contact)
    }
  }
  
  /*
   This is a value that allows child features to dismiss themselves without any direct contact with the parent feature.
   */
  @Dependency(\.dismiss) var dismiss
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .cancelButtonTapped:
      return .run { send in
        await send(.delegate(.cancel))
//        await self.dismiss()
      }
//      return .send(.delegate(.cancel))
//      return .run { _ in await self.dismiss() }
      
    case .saveButtonTapped:
//      return .send(.delegate(.saveContact(state.contact)))
      return .run { [contact = state.contact] send in
        //Mutable capture of 'inout' parameter 'state' is not allowed in concurr
//        await send(.delegate(.saveContact(state.contact)))
        await send(.delegate(.saveContact(contact)))
//        await self.dismiss()
      }
      
    case let .setName(name):
      state.contact.name = name
      return .none
      
    case .delegate:
      return .none
    }
  }
}
