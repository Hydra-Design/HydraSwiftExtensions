//
//  View+SafariCover.swift
//  HydraSwiftExtensions
//
//  Created by Lukas Simonson on 10/31/24.
//

import SwiftUI
import SafariServices

public extension View {
    func safariCover(for link: Binding<SafariCoverLink?>) -> some View {
        self.fullScreenCover(item: link) { link in
            SafariWebView(url: link.url)
                .ignoresSafeArea(edges: .bottom)
        }
    }
}

public struct SafariCoverLink: Identifiable {
    public var id: String { url.absoluteString }
    public var url: URL
    
    public init(url: URL) {
        self.url = url
    }
}

private struct SafariWebView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        return
    }
}
