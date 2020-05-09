//
//  ViewController.swift
//  ArkitApp
//
//  Created by Likhon Gomes on 5/8/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    let animateButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        //arView.scene.anchors.append(boxAnchor)


        
        let model = try? ModelEntity.load(named: "fighter")
        model?.generateCollisionShapes(recursive: true)
        model?.position = [0,0,0]
        model?.scale = [1,1,1]
        
        
        let anchorEntity = AnchorEntity(plane: .horizontal, minimumBounds: [0.2,0.2])
        arView.scene.addAnchor(anchorEntity)
        anchorEntity.addChild(model!, preservingWorldTransform: true)
        
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
}
