//
//  IkeaViewController.swift
//  World Tracking
//
//  Created by Aleksey Kabishau on 1130..17.
//  Copyright © 2017 Aleksey Kabishau. All rights reserved.
//

import UIKit
import ARKit

class IkeaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let itemsArray: [String] = ["cup", "vase", "boxing", "table"]

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        
        
        // setting the delegate and data source objects
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        
        registerGestureRecognizers()
        
    }
    
    func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        //sceneView.isUserInteractionEnabled = true
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        print("tapped the sceneView")
        let sceneView = sender.view as! ARSCNView
        let tapLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        if !hitTest.isEmpty {
            print("touched a horizontal surface")
        } else {
            print("no match")
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! ItemCell
        cell.itemLabel.text = itemsArray[indexPath.row]
        return cell
    }
    
    // UICollectionViewDelegate function
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        
    }
    
}
