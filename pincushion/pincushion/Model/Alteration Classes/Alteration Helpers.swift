//
//  Alteration Helpers.swift
//  pincushion
//
//  Created by Matt Green on 5/3/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit

protocol AlterationType {
    var name: String { get }
    var minCost: Float { get }
    var maxCost: Float { get }
    var actualCost: Float { get }
    var totalCost: Float { get }
    var costDetails: String { get }
    
     // not all have these
    var costUnit: String { get }
    var units: Int { get }
    var secondaryCost: Float { get }
    var secondaryCostDetails: String { get }
}

struct AlterationSection {
    var sectionName: String
    var alterations: [AlterationType]
}


var alterationSections: [AlterationSection] = [
    AlterationSection(sectionName: "Custom", alterations: [
        CustomAlteration()
        ]),
    
    AlterationSection(sectionName: "Bodice", alterations: [
        AddBraCups(),
        AddOrRemoveBoning(),
        AddDarts(),
        AddBeading(),
        SewInBra(),
        TackOnSash(),
        CloseV(),
        ReplaceButtonLoopTape(),
        AddAppliquesBodice()
        ]),
    
    AlterationSection(sectionName: "Neckline", alterations: [
        ReshapeOrRestyleNeckline()
        ]),
    
    AlterationSection(sectionName: "Sides", alterations: [
        Add20PerSideForRebeadingOrReapplyingLace(),
        BustTakenInOrOut(),
        HipOrWaistTakenInOrOut(),
        TakeInLayersOfSkirtAtSideSeams(),
        AddInnerElasticBelt()
        ]),
    
    AlterationSection(sectionName: "Sleeves or straps", alterations: [
        AddPremadeCapSleeves(),
        ConstructAndAddCapOrDropSleeves(),
        AddSleeves(),
        ShortenSpaghettiStraps(),
        RaiseShoulders(),
        AddPremadeStraps(),
        ConstructAndAddStraps(),
        ShortenOrHemSleeves(),
        RaiseShouldersWithSleeves(),
        ReshapeArmholes(),
        ArmscyeGusset(),
        AddElasticToStraps(),
        AddHorsehairToStraps()
        ]),
    
    AlterationSection(sectionName: "Back of dress", alterations: [
        CreateKeyholeBack(),
        LoweringBackCreatingDeepV(),
        AddCorsetBack(),
        ChangeToZipperBack(),
        ReplaceDamagedZipper()
        ]),
    
    AlterationSection(sectionName: "Seams", alterations: [
        HorsehairStabilizer()
        ]),
    
    AlterationSection(sectionName: "Hem", alterations: [
        AdjustUpPriceForBallGown(),
        CutEdgeTulleEtc(),
        SatinOrSilkRolledHem(),
        HorsehairStitchedOn(),
        HorsehairEnclosed(),
        LiftAndReplaceLaceApplique(),
        RemoveCrinoline(),
        LiningSergerRolledHem(),
        ShortenFromWaistlineAndReshapeSkirt(),
        AddHemLace(),
        CutAndReplaceHem(),
        DoubleLayerPressedEnclosedHemNoHoresehair(),
        PressedHemSergeEdgePressSew(),
        DetachedLaceHemSubtract20OfLiftAndReplacedHem()
        ]),
    
    AlterationSection(sectionName: "Skirt", alterations: [
        OverOrUnderBustle(),
        AddWristLoopForTrain(),
        SewInSlip(),
        AddAppliquesSkirt()
        ]),
    
    AlterationSection(sectionName: "Veils", alterations: [
        //AllCustomVeilsRequireThePurchaseOfARawEdgeVeil(),
        CordedEdge(),
        HemLaceEdge(),
        AppliquesVeils(),
        Beaded(),
        RibbonEdge()
        ]),
    
    AlterationSection(sectionName: "Prom - straps", alterations: [
        AddCostForBeadingOrAppliqueLaceProm(),
        RaiseShouldersProm(),
        ShortenSpaghettiStrapsProm(),
        AdjustStrapsProm()
        ]),
    
    AlterationSection(sectionName: "Prom - take in/out", alterations: [
        BustInOrOutProm(),
        HipOrWaistInOrOutProm(),
        InOrOutAtZipperProm(),
        AddCorsetProm(),
        CloseVProm(),
        ReplaceZipperProm()
        ]),
    
    AlterationSection(sectionName: "Prom - hem", alterations: [
        CutEdgeTulleEtcProm(),
        JerseyFabricProm(),
        SatinOrSilkOrChiffonRolledHemProm(),
        LiningProm(),
        MainAndLiningEnclosedProm(),
        MainAndLiningEnclosedWithHorsehairProm(),
        AddSlitProm(),
        HorsehairHemProm()
        ]),
    
    AlterationSection(sectionName: "Tux", alterations: [
        PantsHemTux(),
        JacketHemSleevesWithButtonPlacketTux()
        ]),
]

