//
//  SavedDefaults.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/15/21.
//

import Foundation
import Combine
import SwiftUI

class SavedDefaults: ObservableObject {
    
    @Published var draggedOffset = UserDefaults.standard.float(forKey: "draggedOffset")
    
    public func updateDraggedOffset(offset: Float) {
        UserDefaults.standard.set(offset, forKey: "draggedOffset")
        print("user defautl: \(offset)")
    }
    
    init() {
        UserDefaults.standard.set(Float(UIScreen.main.bounds.height / 1.2), forKey: "draggedOffset")
    }
}
