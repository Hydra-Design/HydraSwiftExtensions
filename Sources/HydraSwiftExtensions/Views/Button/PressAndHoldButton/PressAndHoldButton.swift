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

/// A Button that allows a User to hold it down and repeatedly do an action.
///
/// You create a button by providing 1 - 2 action(s) and a label. The action(s) are
/// either a method or closure property that does something when a Uesr clicks or holds
/// the button. There is also a delayBetweenActivation property that allows you to control
/// how often you want the action to happen while the user is holding the button down. The
/// label is a View that describes the button's action --- for example, by showing text,
/// an icon, etc.
///
/// There is a common use case of text-only labels, you can use the convenience init that
/// takes a String or LocalizedStringKey as its first parameter, instead of a closure.
public struct PressAndHoldButton< Content: View >: View {
    
    @State private var timer: Timer?
    @State public var isLongPressing: Bool = false
    
    private var label: Content
    private var tapAction: () -> Void
    private var holdAction: () -> Void
    
    /// Controls the delay between the call to `holdAction` while a User is holding down the button.
    private var delayBetweenActivation = 0.25
    
    /// Creates a button that displays a custom label and can be held down for repeat action.
    ///
    /// - Parameters:
    ///   - delayBetweenActivation: Controls the delay between the calls to the provided action while the user is holding down the button.
    ///   - label: A `View` that describes the purpose of the button's `action`.
    ///   - action: An action to perform when then button is pressed, or repeated while the User holds down the button.
    public init (
        delayBetweenActivation delay: Double = 0.25,
        label: () -> Content,
        action: @escaping () -> Void
    ) {
        self.label = label()
        self.tapAction = action
        self.holdAction = action
        self.delayBetweenActivation = delay
    }
    
    /// Creates a button that displays a custom label. Takes two actions, one to happen when
    /// the user taps the button, and one to happen repeatedly while the user holds the button.
    ///
    /// - Parameters:
    ///   - delayBetweenActivation: Controls the dealy between the calls to the provided onHold action while the user is holding down the button.
    ///   - label: A `View` that describes the purpose of the button's `action`.
    ///   - onTap: An action to perform when the button is tapped and not held.
    ///   - onHold: An action to perform on repeate while the button is held down.
    public init (
        delayBetweenActivation delay: Double = 0.25,
        label: () -> Content,
        onTap: @escaping () -> Void,
        onHold: @escaping () -> Void
    ) {
        self.label = label()
        self.tapAction = onTap
        self.holdAction = onHold
        self.delayBetweenActivation = delay
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
extension PressAndHoldButton where Content == Text {
    
    /// Creates a button that generates its label from a `LocalizedStringKey`.
    ///
    /// This init creates a `Text View` and uses the `LocalizedStringKey` as the
    /// text to display in the `Text View`.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes
    ///   the purpose of the button's `action`.
    ///   - delayBetweenActivation: Controls the dealy between the calls to the provided onHold action while the user is holding down the button.
    ///   - action: An action to perform when then button is pressed, or repeated while the User holds down the button.
    public init(
        _ titleKey: LocalizedStringKey,
        delayBetweenActivation delay: Double = 0.25,
        action: @escaping () -> Void
    ) {
        self.label = Text( titleKey  )
        self.tapAction = action
        self.holdAction = action
        self.delayBetweenActivation = delay
    }
    
    /// Creates a button that generates its label from a `LocalizedStringKey`.
    ///
    /// This init creates a `Text View` and uses the `LocalizedStringKey` as the
    /// text to display in the `Text View`.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes
    ///   the purpose of the button's `action`.
    ///   - delayBetweenActivation: Controls the dealy between the calls to the provided onHold action while the user is holding down the button.
    ///   - onTap: An action to perform when the button is tapped and not held.
    ///   - onHold: An action to repeatedly perform while the button is held down.
    public init (
        _ titleKey: LocalizedStringKey,
        delayBetweenActivation delay: Double = 0.25,
        onTap: @escaping () -> Void,
        onHold: @escaping () -> Void
    ) {
        self.label = Text( titleKey )
        self.tapAction = onTap
        self.holdAction = onHold
        self.delayBetweenActivation = delay
    }
    
    /// Creates a button that generates its label from a `String`.
    ///
    /// This init creates a `Text View` and uses the `String` as the
    /// text to display in the `Text View`.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes
    ///   the purpose of the button's `action`.
    ///   - delayBetweenActivation: Controls the dealy between the calls to the provided onHold action while the user is holding down the button.
    ///   - action: An action to perform when then button is pressed, or repeated while the User holds down the button.
    public init<S>(
        _ title: S,
        delayBetweenActivation delay: Double = 0.25,
        action: @escaping () -> Void
    ) where S : StringProtocol {
        self.label = Text( title )
        self.tapAction = action
        self.holdAction = action
        self.delayBetweenActivation = delay
    }
    
    /// Creates a button that generates its label from a `String`.
    ///
    /// This init creates a `Text View` and uses the `String` as the
    /// text to display in the `Text View`.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes
    ///   the purpose of the button's `action`.
    ///   - delayBetweenActivation: Controls the dealy between the calls to the provided onHold action while the user is holding down the button.
    ///   - onTap: An action to perform when the button is tapped and not held.
    ///   - onHold: An action to repeatedly perform while the button is held down.
    public init<S> (
        _ titleKey: S,
        delayBetweenActivation delay: Double = 0.25,
        onTap: @escaping () -> Void,
        onHold: @escaping () -> Void
    ) where S : StringProtocol {
        self.label = Text( titleKey )
        self.tapAction = onTap
        self.holdAction = onHold
        self.delayBetweenActivation = delay
    }
}

@available(iOS 13.0, *)
@available(macOS 11, *)


fileprivate struct OnPressAndHold: ViewModifier {
    
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
public extension View {
    
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
