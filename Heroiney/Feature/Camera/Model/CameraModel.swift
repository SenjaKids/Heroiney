//
//  CameraModel.swift
//  Heroiney
//
//  Created by Alfine on 22/05/23.
//

import SwiftUI
import AVFoundation

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    //pic data
    @Published var isSaved = false
    @Published var picData = Data(count: 0)
    func check(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            setUp()
            return
        case .notDetermined:
            // req for permission
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status{
                    self.setUp()
                }
                //                return
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setUp() {
        // Set camera
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        guard authorizationStatus == .authorized else {
            alert.toggle()
            return
        }
        
        let devices = AVCaptureDevice.devices(for: .video)
        guard let device = devices.first(where: { $0.position == .back }) else {
            print("No back camera available")
            return
        }
        
        do {
            self.session.beginConfiguration()
            
            let input = try AVCaptureDeviceInput(device: device)
            
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
            
        } catch {
            print("Failed to set up camera: \(error.localizedDescription)")
        }
    }
    
    func takePic(){
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
//            self.session.stopRunning()
            
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                    self.session.stopRunning()
                }
                
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                    withAnimation{self.isTaken = true}
                }
            }
        }
    }
    
    func retake(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{self.isTaken = false}
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil{
            return
        }
        
        print("pic taken...")
        
        guard let imageData = photo.fileDataRepresentation() else {return}
        print(imageData)
        self.picData = imageData
        
        // cara pake image -> UIImage(data: self.picData)!
    }
    
    func getPicData() -> UIImage {
        return UIImage(data: self.picData)!
    }
}
