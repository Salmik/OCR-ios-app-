//
//  OCRManager.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit
import Vision

final class OCRManager {
    
    static let shared = OCRManager()
    
    private init() {}
    
     var text = ""
    
    var completion: ((String) -> Void)?
    
    //MARK:- OCR

        lazy var workQueue = {
            return DispatchQueue(label: "workQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
        }()
        
        lazy var textRecognitionRequest: VNRecognizeTextRequest = {
            
            let req = VNRecognizeTextRequest { (request, error) in
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                
                var resultText = ""
                for observation in observations {
                    guard let topCandidate = observation.topCandidates(1).first else { return }
                    resultText += topCandidate.string
                    // resultText += "\n"
                }
                
                DispatchQueue.main.async { [weak self] in
                    
                    guard let self = self else { return }
                    
                    if !(resultText.isEmpty) {
                        self.text = resultText
                        self.completion!(resultText)
                        // navigation push
                    }
                    
                }
            }
            req.recognitionLanguages = ["en-US","ru-RU"]
            req.usesLanguageCorrection = true
            req.recognitionLevel = .accurate
            
            return req
        }()
        
    func recognizeText(in image: UIImage) {
            
            guard let cgImage = image.cgImage else { return }
            
            workQueue.async { [weak self] in
                guard let self = self else { return }
                let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                do {
                    try requestHandler.perform([self.textRecognitionRequest])
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    
}
