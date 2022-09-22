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
    
    private var delayBetweenActivation = 0.25
    
    public init (
        label: () -> Content,
        delayBetweenActivation delay: Double = 0.25,
        action: @escaping () -> Void
    ) {
        self.label = label()
        self.tapAction = action
        self.holdAction = action
        self.delayBetweenActivation = delay
    }
    
    public init (
        label: () -> Content,
        delayBetweenActivation delay: Double = 0.25,
        onTap: @escaping () -> Void,
        onHold: @escaping () -> Void
    ) {
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
        .simultaneousGesture( AnyGesture<Any>.holdGesture(delayBetweenActivations: delayBetweenActivation, isLongPressing: $isLongPressing, timer: $timer, action: holdAction) )
    }
}

@available(iOS 13.0, *)
@available(macOS 11, *)
struct OnPressAndHold: ViewModifier {
    
    @State private var isLongPressing: Bool = false
    @State private var timer: Timer? = nil
    
    private var tapAction: () -> Void
    private var holdAction: () -> Void
    
    private var delayBetweenActivation = 0.25
    
    public init( delayBetweenActivation delay: Double = 0.25, action: @escaping () -> Void ) {
        self.delayBetweenActivation = delay
        self.tapAction = action
        self.holdAction = action
    }
    
    public init(
        delayBetweenActivation delay: Double = 0.25,
        onTap: @escaping () -> Void,
        onHold: @escaping () -> Void
    ) {
        self.delayBetweenActivation = delay
        self.tapAction = onTap
        self.holdAction = onHold
    }
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                if self.isLongPressing {
                    self.isLongPressing.toggle()
                    self.timer?.invalidate()
                } else {
                    tapAction()
                }
            }
            .simultaneousGesture(
                AnyGesture<Any>.holdGesture(
                    delayBetweenActivations: delayBetweenActivation,
                    isLongPressing: $isLongPressing,
                    timer: $timer,
                    action: holdAction
                )
            )
    }
}

@available(iOS 13.0, *)
@available(macOS 11, *)
extension View {
    
    func onPressAndHold(
        delayBetweenActivation delay: Double = 0.25,
        _ action: @escaping () -> Void,
        tapAction: (() -> Void)? = nil
    ) -> some View {
        if let tapAction = tapAction {
            return modifier(OnPressAndHold(delayBetweenActivation: delay, onTap: tapAction, onHold: action))
        } else {
            return modifier(OnPressAndHold(delayBetweenActivation: delay, action: action))
        }
    }
}

@available(iOS 13.0, *)
@available(macOS 11, *)
fileprivate extension Gesture {
    
    static func holdGesture(
        delayBetweenActivations delay: Double,
        isLongPressing: Binding< Bool >,
        timer: Binding< Timer? >,
        action: @escaping () -> Void
    ) -> some Gesture {
        LongPressGesture( minimumDuration: 0.1 )
            .onEnded { _ in
                action()
                isLongPressing.wrappedValue = true
                timer.wrappedValue = Timer.scheduledTimer(withTimeInterval: delay, repeats: true, block: { _ in
                    action()
                })
            }
    }
}
