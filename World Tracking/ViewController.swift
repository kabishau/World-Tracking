//
//  ViewController.swift
//  World Tracking
//
//  Created by Aleksey Kabishau on 1119..17.
//  Copyright © 2017 Aleksey Kabishau. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        sceneView.session.run(configuration)
        
        // adding source of light to scene
        sceneView.autoenablesDefaultLighting = true

    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        

    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        restartSession()
    }
    
    // reset function
    func restartSession() {
        // first the session should be paused
        sceneView.session.pause()
        // second "node" should be deleted for parent node
        sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        // third session should be running again with resetTracking option and removing existing anchors
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }
    
}

