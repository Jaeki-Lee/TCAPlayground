//
//  BView.swift
//  TCAPlayground
//
//  Created by jae on 2023/07/29.
//

import SwiftUI
import ComposableArchitecture

struct BView: View {
  
  let store: StoreOf<BReducer>
  
  init(store: StoreOf<BReducer>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        TextField("",
                  text:
        .init(get: {
          viewStore.userName
        }, set: { userName in
          viewStore.send(.binding(.set(\.$userName, userName)))
        }),
         prompt: Text("Please type user name")
        )
        .padding()
        
        TextField("",
                  text:
        .init(get: {
          viewStore.userInfo
        }, set: { userInfo in
          viewStore.send(.binding(.set(\.$userInfo, userInfo)))
        }),
          prompt: Text("Please type user infomation")
        )
        .padding()
        
        Button("Enter User info") {
          viewStore.send(
            .updateUserModel(
              UserModel(
                userName: viewStore.userName,
                userInfo: viewStore.userInfo
              )
            )
          )
          
        }
        .disabled(!viewStore.readyToEdit)
      }
    }
  }
}

//struct BView_Previews: PreviewProvider {
//  static var previews: some View {
//    BView(
//      store: Store(
//        initialState: BReducer.State(),
//        reducer: BReducer()
//      )
//    )
//  }
//}
