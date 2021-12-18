//
//  UpdateStore.swift
//  DesignCode
//
//  Created by Sujay Patil on 18/12/21.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
