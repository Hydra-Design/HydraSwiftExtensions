//
//  PressAndHoldButton.swift
//  
//
//  Created by Lukas Simonson on 9/22/22.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
@available(macOS 11, *)
public struct PressAndHoldButton< Content: View >: View {
    
    @State private var timer: Timer?
    @State public var isLongPressing: Bool = false
    
    private var label: Content
    private var tapAction: () -> Void
    private var holdAction: () -> Void
    
    public init( label: () -> Content, action: @escaping () -> Void ) {
        self.label = label()
        self.tapAction = action
        self.holdAction = action
    }
    
    public init( label: () -> Content, onTap: @escaping () -> Void, onHold: @escaping () -> Void ) {
        self.label = label()
        self.tapAction = onTap
        self.holdAction = onHold
    }
    
    public var body: some View {
        Button {
            if self.isLongPressing {
                self.isLongPressing.toggle()
                self.timer?.invalidate()
            }
            else {
                tapAction()
            }
        } label: {
            label
        }
        .simultaneousGesture(holdGesture)
    }
    
    private var holdGesture: some Gesture {
        LongPressGesture( minimumDuration: 0.1 )
            .onEnded { _ in
                holdAction()
                self.isLongPressing = true
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true, block: { _ in
                    holdAction()
                })
            }
    }
}
