//
//  UIImagePlusCropCenterSquare.swift
//  HydraSwiftExtensions
//
//  Created by Lukas Simonson on 11/4/21.
//


#if !os(macOS)
import Foundation
import UIKit

extension UIImage {
    
    /// Crops the UIImage into a Square, cutting off excess in either the width or height.
    ///
    /// - Version: Beta 0.2
    /// 
    public func cropImageToSquare() throws -> UIImage {
        
        var imageHeight = self.size.height
        var imageWidth = self.size.width
        
        if imageHeight > imageWidth { imageHeight = imageWidth }
        else { imageWidth = imageHeight }
        
        let size = CGSize( width: imageWidth, height: imageHeight )
        
        if let CGImage = self.cgImage {
            let refWidth = CGFloat( CGImage.width )
            let refHeight = CGFloat( CGImage.height )
            
            let x = ( refWidth - size.width ) / 2
            let y = ( refHeight - size.height ) / 2
            
            let cropRect = CGRect( x: x, y: y, width: size.width, height: size.height )
            
            if let imageRef = CGImage.cropping( to: cropRect ) {
                return UIImage( cgImage: imageRef, scale: 0, orientation: self.imageOrientation )
            } else {
                throw HSEUIImageError.couldntCropImage
            }
        } else {
            throw HSEUIImageError.couldntAccessCGImage
        }
    }
}

enum HSEUIImageError : Error {
    case couldntAccessCGImage
    case couldntCropImage
}

#endif
