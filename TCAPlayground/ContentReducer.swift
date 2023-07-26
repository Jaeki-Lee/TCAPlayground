//
//  ContentReducer.swift
//  TCAPlayground
//
//  Created by jae on 2023/07/26.
//

import Foundation
import ComposableArchitecture

struct Item: Equatable {
  var name: String = ""
  var price: Int = 0
}

public struct ContentReducer: ReducerProtocol {
  public struct State: Equatable {
    var item: Item = .init()
  }
  
  public enum Action: Equatable {
    case updateItemName(String)
    case updateItemPrice(Int)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .updateItemName(name):
        state.item.name = name
        return .none
        
      case let .updateItemPrice(price):
        state.item.price = price
        return .none
        
      }
    }
  }
  
}
