//
//  CustomAlert.swift
//  
//
//  Created by Lukas Simonson on 11/9/22.
//

import SwiftUI

@available(iOS 15.0, macOS 12, *)
public extension View {
    func alert( data: Binding<( title: String, message: String, show: Bool )>, actions: () -> some View ) -> some View {
        alert(data.wrappedValue.title, isPresented: data.show, actions: actions) {
            Text(data.wrappedValue.message)
        }
    }
    
    func alert( _ data: Binding<HydraAlert> ) -> some View {
        alert(data.wrappedValue.title, isPresented: data.isShown) {
            ForEach( data.actions ) { action in
                Button(action.wrappedValue.name, action: action.wrappedValue.action)
            }
        } message: {
            Text(data.wrappedValue.message)
        }
    }
}

@available(iOS 15.0, macOS 12, *)
public struct HydraAlert {
    
    public static var defaultAlert: HydraAlert { HydraAlert(title: "Custom Alert", message: "Made By Hydra Design LLC") }
    
    public var title: String
    public var message: String
    public var isShown = false
    public var actions = [ HydraAlertAction.defaultAction ]
    
    mutating public func addAction( named name: String, action: @escaping () -> Void ) {
        actions.append(HydraAlertAction(name: name, action: action))
    }
    
    mutating public func show() { self.isShown = true }
    
    public struct HydraAlertAction: Identifiable {
        public var id = UUID()
        public var name: String
        public var action: () -> Void
        
        static var defaultAction: HydraAlertAction { HydraAlertAction(name: "Ok", action: {}) }
    }
}
