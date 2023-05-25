//
//  CameraPreview.swift
//  Heroiney
//
//  Created by Alfine on 23/05/23.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var cam: CameraModel
    
    func makeUIView(context: Context) -> UIView {
//        let view = UIView(frame: UIScreen.main.bounds)
        let screenWidth = UIScreen.main.bounds.width
        let view = UIView(frame: CGRect(x: 0, y: 200, width: screenWidth, height: screenWidth))
        
        cam.preview = AVCaptureVideoPreviewLayer(session: cam.session)
        cam.preview.frame = view.frame
        
        cam.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(cam.preview)
        
        cam.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
}

