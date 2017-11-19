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

    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        // creating node and giving it shape and color and position
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.position = SCNVector3(0, 0, 0)
        // scene - what is visible on screen
        // rootNode - by default set to origin of the view, has no shape, color, etc
        sceneView.scene.rootNode.addChildNode(node)
    }
    
}

