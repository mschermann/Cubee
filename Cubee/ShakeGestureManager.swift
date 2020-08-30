//
//  ShakeGestureManager.swift
//  Cubee
//
//  Created by Michael Schermann on 8/30/20.
//  Copyright © 2020 Michael Schermann. All rights reserved.
// https://blckbirds.com/post/how-to-detect-shake-gestures-in-swiftui/
//

import Foundation
import SwiftUI
import Combine

let messagePublisher = PassthroughSubject<Void, Never>()

class ShakableViewController: UIViewController {

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        messagePublisher.send()
    }
}


struct ShakableViewRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ShakableViewController {
        ShakableViewController()
    }
    func updateUIViewController(_ uiViewController: ShakableViewController, context: Context) {
        
    }
}
