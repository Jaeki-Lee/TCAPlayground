//
//  TCAPlaygroundApp.swift
//  TCAPlayground
//
//  Created by jae on 2023/07/26.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAPlaygroundApp: App {
//  let contentStore = Store(
//    initialState: ContentReducer.State(),
//    reducer: ContentReducer()
//  )

//  let AStore = StoreOf(initialState: AReducer.State(), reducer: AReducer())
  
    var body: some Scene {
        WindowGroup {
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
}
