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
  let contentStore = Store(
    initialState: ContentReducer.State(),
    reducer: ContentReducer()
  )
  
    var body: some Scene {
        WindowGroup {
            ContentView(store: contentStore)
        }
    }
}
