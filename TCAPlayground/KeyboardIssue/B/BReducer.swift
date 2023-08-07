//
//  BReducer.swift
//  TCAPlayground
//
//  Created by jae on 2023/07/29.
//

import Foundation
import ComposableArchitecture

public struct BReducer: Reducer {
  
  public struct State: Equatable {
    public init() {}
    
    @BindingState
    var userName: String = ""
    
    @BindingState
    var userInfo: String = ""
    
    @BindingState
    var readyToEdit: Bool = false
  }
  
  public enum Action: BindableAction, Equatable {
   case binding(BindingAction<BReducer.State>)
   case updateUserModel(UserModel)
  }
  
  public var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding(\.$userName):
        if !state.userName.isEmpty && !state.userInfo.isEmpty {
          state.readyToEdit = true
        } else {
          state.readyToEdit = false
        }
        return .none
      
      case .binding(\.$userInfo):
        if !state.userName.isEmpty && !state.userInfo.isEmpty {
          state.readyToEdit = true
        } else {
          state.readyToEdit = false
        }
        return .none
        
      default: return .none
      }
    }
  }
  
}
