//
//  AView.swift
//  TCAPlayground
//
//  Created by jae on 2023/07/29.
//

import SwiftUI
import ComposableArchitecture

struct AView: View {
  
  let store: StoreOf<AReducer>
  
    var body: some View {
      WithViewStore(store, observe: { $0 }) { viewStore in
        VStack {
          Text("User name: \(viewStore.userModel.userName)")
            .padding()
          
          Text("User info: \(viewStore.userModel.userInfo)")
            .padding()
          
          Button("Edit User information") {
            viewStore.send(.toggleBottomSheetOpen(true))
          }
        }
        .sheet(
          isPresented: Binding(
            get: { viewStore.state.isBottomSheetOpen },
            set: { viewStore.send(.toggleBottomSheetOpen($0)) }
          )
        ) {
          BView(
            store: store.scope(state: \.bState,
                               action: AReducer.Action.bAction)
          )
          .presentationDetents([.height(500)])
        }
      }
    }
}

//struct AView_Previews: PreviewProvider {
//    static var previews: some View {
//      AView(
//        store: Store(
//          initialState: AReducer.State(),
//          reducer: AReducer()
//        )
//      )
//    }
//}
