//
//  ContentView.swift
//  TCAPlayground
//
//  Created by jae on 2023/07/26.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
  let store: Store<ContentReducer.State, ContentReducer.Action>
  
  @State
  var item: String = ""
  
  @State
  var price: String = ""
  
    var body: some View {
      WithViewStore(self.store, observe: { $0 }) { viewStore in
        VStack(alignment: .center, spacing: .zero) {
          TextField("", text: $item, prompt: Text("Item"))
            .background(.gray)
            .padding()
          
          TextField("", text: $price, prompt: Text("Price"))
            .background(.gray)
            .padding()
          
          Button("입력") {
            viewStore.send(.updateItemName(item))
            viewStore.send(.updateItemPrice(Int(price)!))
          }
          .padding(.vertical, 30)
          
          Text("입력된 아이템 \(viewStore.item.name)")
          Text("입력된 아이템 가격 \(viewStore.item.price)")
        }
        .padding(100)
      }
    }
}


