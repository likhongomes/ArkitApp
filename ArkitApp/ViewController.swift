//
//  ViewController.swift
//  ArkitApp
//
//  Created by Likhon Gomes on 5/8/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    let animateButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //arViewSetup()
        // Load the "Box" scene from the "Experience" Reality File
        //let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        //arView.scene.anchors.append(boxAnchor)
        
        let floor = ModelEntity(mesh: MeshResource.generateBox(size: [1,0.01,1]))
        floor.physicsBody = PhysicsBodyComponent(massProperties: PhysicsMassProperties(mass: 0.1), material: .default, mode: .kinematic)
        floor.generateCollisionShapes(recursive: true)
        floor.collision = CollisionComponent(shapes: [ShapeResource.generateBox(size: [1,1,1])])
        
        
        var configure = ARWorldTrackingConfiguration()
        configure.planeDetection = .horizontal
        arView.session.run(configure, options: .resetTracking)
        
        
        let model:ModelEntity = try! ModelEntity.loadModel(named: "fighter")
        model.generateCollisionShapes(recursive: true)
        model.position = [0,0.1,0]
        print("available animations \(model.availableAnimations) asdf")
        
        model.playAnimation(model.availableAnimations[0], transitionDuration: 1, startsPaused: false)
        
        
        model.scale = [0.2,0.2,0.2]
        model.physicsBody = PhysicsBodyComponent(massProperties: PhysicsMassProperties(mass: 0), material: .default, mode: .kinematic)
        model.physicsMotion = PhysicsMotionComponent(linearVelocity: [0,0,0], angularVelocity: [0,0,0])
        
        print(model.availableAnimations)
        
        //model.availableAnimations
        
        if #available(iOS 13.4, *) {
            arView.environment.sceneUnderstanding.options.insert(.physics)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.4, *) {
            arView.environment.sceneUnderstanding.options.insert(.occlusion)
        } else {
            // Fallback on earlier versions
        }
        
        let anchorEntity = AnchorEntity(plane: .horizontal, minimumBounds: [0.2,0.2])
        arView.scene.addAnchor(anchorEntity)
        anchorEntity.addChild(model, preservingWorldTransform: true)
        anchorEntity.addChild(floor)
        
        animateButtonSetup()
    }
    
    func animateButtonSetup(){
        view.addSubview(animateButton)
        animateButton.translatesAutoresizingMaskIntoConstraints = false
        animateButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        animateButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        animateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        animateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        animateButton.backgroundColor = .systemGreen
        animateButton.setTitleColor(.white, for: .normal)
        animateButton.setTitle("Animate", for: .normal)
        animateButton.addTarget(self, action: #selector(animateButtonTapped), for: .touchUpInside)
    }
    
    @objc func animateButtonTapped(){
        print("xxx")

    }
    
    func arViewSetup(){
        arView = ARView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), cameraMode: .ar, automaticallyConfigureSession: true)
    }
}
