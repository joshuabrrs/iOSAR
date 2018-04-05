//
//  ViewController.swift
//  ARDice
//
//  Created by Joshua Barrios on 4/3/18.
//  Copyright © 2018 Joshua Barrios. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.automaticallyUpdatesLighting = true
        
        let cubeScene = SCNScene(named: "art.scnassets/mine.scn")!
        
        if let cubeNode = cubeScene.rootNode.childNode(withName: "mine", recursively: true){
        
            cubeNode.position = SCNVector3(x:0, y:0.1, z:-0.5)
            sceneView.scene.rootNode.addChildNode(cubeNode)
       
    }
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}
