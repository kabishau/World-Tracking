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
        // creating node and giving it shape and color and position
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        // effect of light that being reflected from the surface of the node object
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        // creating x, y, z points for Vector3
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        node.position = SCNVector3(x, y, z)
        // scene - what is visible on screen
        // rootNode - by default set to origin of the view, has no shape, color, etc
        sceneView.scene.rootNode.addChildNode(node)
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
    
    // func that generates randmon number between given min and max numbers
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

