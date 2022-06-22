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
    /// - Version: Beta 0.1
    ///
    @available( *, deprecated, message: "Can cause Crashes", renamed: "cropImageToSquare()" )
	public func cropImageToSquare() -> UIImage? {
		
		var imageHeight = self.size.height
		var imageWidth = self.size.width
		
		if imageHeight > imageWidth {
			imageHeight = imageWidth
		} else { imageWidth = imageHeight }
		
		let size = CGSize( width: imageWidth, height: imageHeight )
		
		let refWidth : CGFloat = CGFloat( self.cgImage!.width )
		let refHeight : CGFloat = CGFloat( self.cgImage!.height )
		
		let x = ( refWidth - size.width ) / 2
		let y = ( refHeight - size.height ) / 2
		
		let cropRect = CGRect( x: x, y: y, width: size.height, height: size.width )
		if let imageRef = self.cgImage!.cropping( to: cropRect ) {
			return UIImage( cgImage: imageRef, scale: 0, orientation: self.imageOrientation )
		}
		
		return nil
	}
    
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
    
    
    enum HSEUIImageError : Error {
        case couldntAccessCGImage
        case couldntCropImage
    }
}
#endif
