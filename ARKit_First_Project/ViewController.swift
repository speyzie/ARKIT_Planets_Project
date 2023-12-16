//
//  ViewController.swift
//  ARKit_First_Project
//
//  Created by Asya Güney on 7.12.2023.
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
        
        let world = createSphere(radius: 0.06, content: "world.png", vector: SCNVector3(x: 0.3, y: 0.2, z: -1.2))
        let mars = createSphere(radius: 0.034, content: "mars.png", vector: SCNVector3(x: 0.1, y: 0.2, z: -0.6))
        let venus = createSphere(radius: 0.06, content: "venus.png", vector: SCNVector3(x: 0.4, y: 0.2, z: -1))
        let jupiter = createSphere(radius: 0.7, content: "jupiter.jpg", vector: SCNVector3(x: 0.6, y: 0.2, z: -2.3))
        let neptune = createSphere(radius: 0.25, content: "neptune.jpg", vector: SCNVector3(x: 0.7, y: 0.2, z: -3.4))
        
        sceneView.scene.rootNode.addChildNode(world)
        sceneView.scene.rootNode.addChildNode(mars)
        sceneView.scene.rootNode.addChildNode(venus)
        sceneView.scene.rootNode.addChildNode(neptune)
        sceneView.scene.rootNode.addChildNode(jupiter)
        
        
        sceneView.automaticallyUpdatesLighting = true
        
    }
    
    func createSphere(radius:CGFloat, content:String, vector:SCNVector3) -> SCNNode{
        let mySphere = SCNSphere(radius: radius)
        
        let mySphereMaterial = SCNMaterial()
        mySphereMaterial.diffuse.contents = UIImage(named: "art.scnassets/\(content)")
        mySphere.materials = [mySphereMaterial]
        
        let node = SCNNode()
        node.position = vector
        node.geometry = mySphere
        
        let movePlanet = SCNAction.rotateBy(x: 0.2, y: 0.2, z: 0, duration: 1)
        let sequence = SCNAction.sequence([movePlanet])
        let repeatForever = SCNAction.repeatForever(sequence)
        
        node.runAction(repeatForever)
        
        return node
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

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
