//
//  TPPDF.swift
//  pincushion
//
//  Created by Matt Green on 6/2/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import TPPDF

//Mark: Nick's Code! :D
func createContractPDF(viewController: UIViewController, text: String, AltArray: [AlterationStruct], totalCost: Float, brideName: String, specialist: String, eventDate: Date, buyDate: Date, bust: String, waist: String, hip: String) {
    let document = PDFDocument(format: .a4)
    
    var allAlterations = AltArray
   
    // method called to style & print each alteration
    func postAlteration(theAlteration: AlterationStruct) {

        document.setTextColor(color: UIColor.black)
        document.addText(.contentLeft, text: "\(theAlteration.name) -- Subtotal: $\(theAlteration.totalCost)0")
        document.setTextColor(color: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.8))
        
        var actualCostString = ""
        var secondaryCostString = ""
        var theResultString = ""
        
        // there is a cost note
        if theAlteration.costDetails != "" {
            if theAlteration.units > 1 {
                actualCostString = "$\(theAlteration.actualCost)0 \(theAlteration.costDetails) (x\(theAlteration.units))"
            } else {
                actualCostString = "$\(theAlteration.actualCost)0 \(theAlteration.costDetails)"
            }
        }
        
        // there is a secondary cost & note
        if theAlteration.secondaryCost != 0 {
            if theAlteration.secondaryCostDetails != "" {
                secondaryCostString = " $\(theAlteration.secondaryCost)0 (\(theAlteration.secondaryCostDetails))"
            } else {
                secondaryCostString = " $\(theAlteration.secondaryCost)0"
            }
        }
        
        // if secondary cost exist, include them
        if secondaryCostString != "" {
            theResultString = actualCostString + " + " + secondaryCostString
        } else {
            theResultString = actualCostString
        }
        
        document.setFont(font: UIFont.italicSystemFont(ofSize: 10.0))
        document.addText(.contentLeft,text: "\(theResultString)")
        document.addSpace(space: 8.0)
        document.setFont(font: UIFont.systemFont(ofSize: 12.0))
   } // end of alteration style & print method
    
    //MARK:- Header
    document.setTextColor(color: UIColor.black)

    let imageElement = PDFImage(image: UIImage(named: "PDFLogo")!, quality: 1, options: [.none])
    
    document.addImage(.contentRight, image: imageElement)

    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    
    let dateString = formatter.string(from: eventDate)

    document.setFont(font: UIFont.systemFont(ofSize: 20.0))
    document.addText(PDFContainer.contentLeft, text: "Bride: \(brideName)")
    
    document.setFont(font: UIFont.systemFont(ofSize: 15.0))
    document.addText(PDFContainer.contentLeft, text: "Specialist: \(SpecialistSingleton.displayName)")
    document.addText(PDFContainer.contentLeft, text: "Event: \(dateString)")
    
    document.addSpace(space: 10.0)
    document.setFont(font: UIFont.systemFont(ofSize: 12.0))
    
    document.addText(.contentLeft, text: "Measurements:")
    document.setFont(font: UIFont.systemFont(ofSize: 10.0))
    document.addText(.contentLeft, text: "Bust - \(bust)")
    document.addText(.contentLeft, text: "Waist - \(waist)")
    document.addText(.contentLeft, text: "Hip - \(hip)")
    document.setFont(font: UIFont.systemFont(ofSize: 12.0))
    
    //MARK:- Alterations
    document.addText(.contentCenter, text: "Alterations")
    
    let style = PDFLineStyle(type: .full, color: UIColor.darkGray, width: 0.5)
    document.addLineSeparator(PDFContainer.contentLeft, style: style)
    document.addSpace(space: 12.0)
    
    for calledItem in allAlterations {
      
        postAlteration(theAlteration: calledItem)
    }
    
    //MARK:- Footer
    document.setTextColor(color: UIColor.black)
  
    let sub = String(format: "%.2f", totalCost)
    let tax = String(format: "%.2f", totalCost * 0.089)
    let total = String(format: "%.2f", totalCost * 0.089 + totalCost)
  

    document.addText(.footerRight, text: "Total: $\(total)")
    document.addText(.footerRight, text: "Tax: $\(tax)")
    
    document.addSpace(space: 10.0)
    document.addText(.footerRight, text: "Subtotal: $\(sub)")
    document.addText(.footerRight, text: " ")
    document.addText(.footerRight, text: "_____________________________________________________________________________")
    
    document.addText(.contentCenter, text: " ")
    document.addText(.contentCenter, text: " ")
    document.addText(.contentCenter, text: " ")
    document.addText(.contentCenter, text: " ")
    
    // Page break
    document.createNewPage()
    
    //MARK:- Page two... disclaimers
    document.addImage(.contentRight, image: imageElement)
    document.addSpace(space: 20.0)
    document.addText(.contentLeft, text: "For alterations appointments that have been fitted and pinned, a $30 pinning fee will apply should you decide not to go forward with Believe Bride.")
    document.addText(.contentCenter, text: " ")
    document.addText(.contentLeft, text: "If you decide to pick up your item before the custom alterations are completed we cannot be held liable for the condition of the final product.")
    document.addText(.contentCenter, text: " ")
    document.addText(.contentLeft, text: "I am aware that any changes in weight loss or gain may result in  additional alteration charges, if they vary significantly from the original pinning. Initial: ______")
    document.addText(.contentCenter, text: " ")
    document.addText(.contentLeft, text: "I agree to be punctual for all the alterations appointments I have made. This includes being  prepared with all necessary undergarments, which includes: shoes, slip, bras, etc.")
    document.addText(.contentCenter, text: " ")
    document.addText(.contentLeft, text: "The total charges are collected prior to starting custom alterations.")
    document.addText(.contentCenter, text: " ")
    document.addText(.contentLeft, text: "I understand the terms and policies for custom alterations at Believe Bride.")
    document.addText(.contentCenter, text: " ")
    document.addText(.contentCenter, text: " ")
        
    document.addText(.contentLeft, text: "Signature:______________________________________   Date:___________________")
    
    
    //MARK:- Export as PDF
    do {
        // Generate PDF file and save it in a temporary file. This returns the file URL to the temporary file
        let url = try PDFGenerator.generateURL(document: document, filename: "Example.pdf", progress: {
            (progressValue: CGFloat) in
            print("TPPDF-progress: ", progressValue)
        }, debug: false)
        print("TPPDF-PDF-URL: \(url)")
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        
        // iPad stuff
        if UIDevice.current.userInterfaceIdiom == .pad {
            vc.popoverPresentationController?.sourceView = viewController.view
            vc.popoverPresentationController?.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
            vc.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        }
        viewController.present(vc, animated: true, completion: nil)
    } catch {
        print("Error while generating PDF: " + error.localizedDescription)
    }
}


