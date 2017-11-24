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
        
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        let piramindNode = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.05, length: 0.1))
        let planeNode = SCNNode(geometry: SCNPlane(width: 0.04, height: 0.07))
        let planeWindowNode = SCNNode(geometry: SCNPlane(width: 0.04, height: 0.04))
        
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.darkGray
        piramindNode.geometry?.firstMaterial?.diffuse.contents = UIColor.lightGray
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        planeWindowNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        
        sceneView.scene.rootNode.addChildNode(boxNode)
        boxNode.addChildNode(piramindNode)
        boxNode.addChildNode(planeNode)
        boxNode.addChildNode(planeWindowNode)
        
        boxNode.position = SCNVector3(0, 0, 0)
        piramindNode.position = SCNVector3(0, 0.05, 0)
        planeNode.position = SCNVector3(0, 0, 0.051)
        planeWindowNode.position = SCNVector3(-0.051, 0, 0)
        //adding rotation to a single element
        planeWindowNode.eulerAngles = SCNVector3(0, Float(270.degreesToRadians), 0)

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

extension Int {
    var degreesToRadians: Double {
        return Double(self) * .pi / 180
    }
}

