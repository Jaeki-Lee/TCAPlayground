//
//  AReducer.swift
//  TCAPlayground
//
//  Created by jae on 2023/07/29.
//

import Foundation
import ComposableArchitecture

public struct AReducer: Reducer {
  public struct State: Equatable {
    public init() {}
    
    var userModel: UserModel = .init(userName: "", userInfo: "")
    
    var bState: BReducer.State = .init()
    
    var isBottomSheetOpen: Bool = false
  }
  
  public enum Action: Equatable {
    case bAction(BReducer.Action)
    case toggleBottomSheetOpen(Bool)
  }
  
  public var body: some Reducer<State, Action> {
    Scope(state: \.bState,
          action: /Action.bAction) {
      BReducer()
    }
    
    Reduce { state, action in
      switch action {
      
      case let .toggleBottomSheetOpen(isOpen):
        state.isBottomSheetOpen = isOpen
        return .none
        
      case let .bAction(.updateUserModel(userModel)):
        state.userModel = userModel
        state.isBottomSheetOpen = false
        return .none
        
      default: return .none
      }
    }
  }
  
}
