//
//  CameraView.swift
//  Heroiney
//
//  Created by Alfine on 22/05/23.
//

import SwiftUI


struct CameraView: View {
//    let screenWidth = UIScreen.main.bounds.width
    @StateObject var cam = CameraModel()
    let imagePredictor = ImagePredictor()
    @State var predictionTxt = ""
    @State var isPredictionTrue = false
    let predictionsToShow = 1
    
    @State var currentHero: Hero = Hero(id: "0", name: "", date: "", story: "", photo: "")
    var heroes: [Hero] = Hero.allHero
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            CameraPreview(cam: cam)
                .ignoresSafeArea()
            if predictionTxt == "" {
                ResultCapsuleView(result: .constant("Bring money into view"))
                    .padding(.top, 270)
            }
            
            VStack{
                
                if cam.isTaken {
                    //Tampilan setelah gambar di ambil
                    VStack {
                        Text("Is this Rp\(predictionTxt)?")
                            .foregroundColor(Color(red: 233/255, green: 255/255, blue: 219/255))
                            .font(.system(size: 24))
                            .fontWeight(.medium)
                        
//                        Text("National Hero Side")
//                            .foregroundColor(Color(red: 233/255, green: 255/255, blue: 219/255))
//                            .font(.system(size: 16))
//                            .fontWeight(.thin)
                            
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    HStack(spacing: 15) {
                        Button {
                            cam.retake()
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                                predictionTxt = ""
                            }
                        } label: {
                            Text("No")
                                .foregroundColor(Color(red: 233/255, green: 255/255, blue: 219/255))
                                .frame(width: 160, height: 40)
                                .background(Color(red: 185/255, green: 0/255, blue: 0/255))
                                .cornerRadius(8)
                            
                        }
                        Button {
                            isPredictionTrue = true
                        } label: {
                            Text("Yes")
                                .foregroundColor(Color(red: 233/255, green: 255/255, blue: 219/255))
                                .frame(width: 160, height: 40)
                                .background(Color(red: 73/255, green: 178/255, blue: 96/255))
                                .cornerRadius(8)
                            
                        }

                    }
                    .padding(.bottom, 100)
                } else {
                    VStack {
                        Text("Take a picture of a paper money")
                            .foregroundColor(Color(red: 233/255, green: 255/255, blue: 219/255))
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                        
                        Text("(National Hero Side)")
                            .foregroundColor(Color(red: 233/255, green: 255/255, blue: 219/255))
                            .font(.system(size: 16))
                            .fontWeight(.thin)
                            
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    Button {
                        cam.takePic()
                        Timer.scheduledTimer(withTimeInterval: 0.11, repeats: false) { (timer) in
                            classifyImage(cam.getPicData())
                        }
                    } label: {
                        ZStack{
                            Circle()
                                .fill(.white)
                                .frame(width: 65, height: 65)
                            
                            Circle()
                                .stroke(.white, lineWidth: 2)
                                .frame(width: 75, height: 75)
                        }
                        .padding(.bottom, 50)
                    }
                }
                

            }
            
        }
        .statusBarHidden()
        .transaction { transaction in
            transaction.animation = nil
        }
        .onAppear {
            cam.check()
        }
        .sheet(isPresented: $isPredictionTrue) {
            
            ZStack{
                
                Color(red: 222/255, green: 255/255, blue: 238/255)
                    .ignoresSafeArea()
                
                VStack{
                    if predictionTxt == "1000"{
                        Image((heroes.first(where: {$0.id == "1000"})?.photo)!)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width * 75/100)
                        
                        VStack{
                            Text((heroes.first(where: {$0.id == "1000"})?.name)!)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 30/255, green: 125/255, blue: 0/255))
                                .padding(.top, 16)
                                .onAppear {
                                    
                                    print(currentHero.name)
                                }
                            Text("(\((heroes.first(where: {$0.id == "1000"})?.date)!))")
                                .font(.system(size: 16))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                            
                            Text((heroes.first(where: {$0.id == "1000"})?.story)!)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                                .padding(.top, 8)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }else if predictionTxt == "2000"{
                        Image((heroes.first(where: {$0.id == "2000"})?.photo)!)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width * 75/100)
                        
                        VStack{
                            Text((heroes.first(where: {$0.id == "2000"})?.name)!)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 30/255, green: 125/255, blue: 0/255))
                                .padding(.top, 16)
                                .onAppear {
                                    
                                    print(currentHero.name)
                                }
                            Text("(\((heroes.first(where: {$0.id == "2000"})?.date)!))")
                                .font(.system(size: 16))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                            
                            Text((heroes.first(where: {$0.id == "2000"})?.story)!)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                                .padding(.top, 8)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }else if predictionTxt == "5000"{
                        Image((heroes.first(where: {$0.id == "5000"})?.photo)!)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width * 75/100)
                        
                        VStack{
                            Text((heroes.first(where: {$0.id == "5000"})?.name)!)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 30/255, green: 125/255, blue: 0/255))
                                .padding(.top, 16)
                                .onAppear {
                                    
                                    print(currentHero.name)
                                }
                            Text("(\((heroes.first(where: {$0.id == "5000"})?.date)!))")
                                .font(.system(size: 16))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                            
                            Text((heroes.first(where: {$0.id == "5000"})?.story)!)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                                .padding(.top, 8)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }else if predictionTxt == "10000"{
                        Image((heroes.first(where: {$0.id == "10000"})?.photo)!)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width * 75/100)
                        
                        VStack{
                            Text((heroes.first(where: {$0.id == "10000"})?.name)!)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 30/255, green: 125/255, blue: 0/255))
                                .padding(.top, 16)
                                .onAppear {
                                    
                                    print(currentHero.name)
                                }
                            Text("(\((heroes.first(where: {$0.id == "10000"})?.date)!))")
                                .font(.system(size: 16))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                            
                            Text((heroes.first(where: {$0.id == "10000"})?.story)!)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                                .padding(.top, 8)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }else if predictionTxt == "20000"{
                        Image((heroes.first(where: {$0.id == "20000"})?.photo)!)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width * 75/100)
                        
                        VStack{
                            Text((heroes.first(where: {$0.id == "20000"})?.name)!)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 30/255, green: 125/255, blue: 0/255))
                                .padding(.top, 16)
                                .onAppear {
                                    
                                    print(currentHero.name)
                                }
                            Text("(\((heroes.first(where: {$0.id == "20000"})?.date)!))")
                                .font(.system(size: 16))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                            
                            Text((heroes.first(where: {$0.id == "20000"})?.story)!)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                                .padding(.top, 8)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }else if predictionTxt == "50000"{
                        Image((heroes.first(where: {$0.id == "50000"})?.photo)!)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width * 75/100)
                        
                        VStack{
                            Text((heroes.first(where: {$0.id == "50000"})?.name)!)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 30/255, green: 125/255, blue: 0/255))
                                .padding(.top, 16)
                                .onAppear {
                                    
                                    print(currentHero.name)
                                }
                            Text("(\((heroes.first(where: {$0.id == "50000"})?.date)!))")
                                .font(.system(size: 16))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                            
                            Text((heroes.first(where: {$0.id == "50000"})?.story)!)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                                .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                                .padding(.top, 8)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }else if predictionTxt == "100000"{
                        if let seratus = ["100001", "100002"].randomElement() {
                            Image((heroes.first(where: {$0.id == seratus})?.photo)!)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width * 75/100)
                            
                            VStack{
                                Text((heroes.first(where: {$0.id == seratus})?.name)!)
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(red: 30/255, green: 125/255, blue: 0/255))
                                    .padding(.top, 16)
                                    .onAppear {
                                        
                                        print(currentHero.name)
                                    }
                                Text("(\((heroes.first(where: {$0.id == seratus})?.date)!))")
                                    .font(.system(size: 16))
                                    .fontWeight(.light)
                                    .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                                
                                Text((heroes.first(where: {$0.id == seratus})?.story)!)
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                    .foregroundColor(Color(red: 104/255, green: 111/255, blue: 102/255))
                                    .padding(.top, 8)
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        
                    }
                    
                }
            }
        }
    }
}

extension CameraView {
    // MARK: Image prediction methods
    /// Sends a photo to the Image Predictor to get a prediction of its content.
    /// - Parameter image: A photo.
    private func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image,
                                                    completionHandler: self.imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }

    /// The method the Image Predictor calls when its image classifier model generates a prediction.
    /// - Parameter predictions: An array of predictions.
    /// - Tag: imagePredictionHandler
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        guard let predictions = predictions else {
            self.predictionTxt = ""
            return
        }

        let formattedPredictions = formatPredictions(predictions)

        let predictionString = formattedPredictions.joined(separator: "\n")
        self.predictionTxt = predictionString
    }

    /// Converts a prediction's observations into human-readable strings.
    /// - Parameter observations: The classification observations from a Vision request.
    /// - Tag: formatPredictions
    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
            var name = prediction.classification

            // For classifications with more than one name, keep the one before the first comma.
            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }

            return "\(name)"
        }

        return topPredictions
    }
}


//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
