//
//  SupportEmail.swift
//  HydraSwiftExtensions
//
//  Created by Lukas Simonson on 10/31/24.
//

import SwiftUI

public struct SupportEmail {
    public let supportEmailAddress: String
    public let subject: String
    
    public init(address: String, subject: String? = nil) {
        self.supportEmailAddress = address
        if let subject { self.subject = subject }
        else {
            let app = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
            self.subject = "\(app) Support Request"
        }
    }
    
    public var body: String {"""
    Application Name: \(Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Unknown")
    iOS Version: \(UIDevice.current.systemVersion)
    Device Model: \(UIDevice.current.model)
    App Version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown Version")
    App Build: \(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown Build")
    
    Please describe your issue below
    ------------------------------------
    """}
    
    public func send(openURL: OpenURLAction) {
        let replacedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        let replacedBody = body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        let urlString = "mailto:\(supportEmailAddress)?subject=\(replacedSubject)&body=\(replacedBody)"
        guard let url = URL(string: urlString) else { return }
        openURL(url) { accepted in
            if !accepted { // e.g. Simulator
                print("Device doesn't support email.\n \(body)")
            }
        }
    }
}
