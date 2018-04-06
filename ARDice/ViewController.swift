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
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.automaticallyUpdatesLighting = true
        
//        let cubeScene = SCNScene(named: "art.scnassets/mine.scn")!
//
//        if let cubeNode = cubeScene.rootNode.childNode(withName: "mine", recursively: true){
//
//            cubeNode.position = SCNVector3(x:0, y:0.1, z:-0.5)
//            sceneView.scene.rootNode.addChildNode(cubeNode)
//
//    }
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let touchLoc = touch.location(in: sceneView)
            
            let results = sceneView.hitTest(touchLoc, types: .featurePoint)
            //checking if results is NOT empty
            if let hitResult = results.first{
                let mineScene = SCNScene(named: "art.scnassets/mine.scn")
                if let mineNode = mineScene!.rootNode.childNode(withName: "mine", recursively: true){
                    mineNode.position = SCNVector3(x: hitResult.worldTransform.columns.3.x,
                                                   y: hitResult.worldTransform.columns.3.y,
                                                   z: hitResult.worldTransform.columns.3.z)
                    sceneView.scene.rootNode.addChildNode(mineNode)
                }
            }
        }
    }
    //this is where I set up the horizontal plane
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor{
            let planeAnchor = anchor as! ARPlaneAnchor
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            let planeNode = SCNNode()
            
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            
            plane.materials = [gridMaterial]
            
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
        }
        else{
            return
        }
    }
}
