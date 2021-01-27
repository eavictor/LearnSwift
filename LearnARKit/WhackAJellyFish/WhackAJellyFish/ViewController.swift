//
//  ViewController.swift
//  WhackAJellyFish
//
//  Created by eavictor on 2021/1/11.
//

import ARKit
import UIKit
import Each

class ViewController: UIViewController {
    
    let configuration = ARWorldTrackingConfiguration()
    
    var timer = Each(1).seconds
    var countDown = 10
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    @IBOutlet weak var play: UIButton!
    
    @IBAction func play(_ sender: UIButton) {
        self.setTimer()
        self.addNode()
        self.play.isEnabled = false
    }
    
    @IBAction func reset(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.sceneView.scene.rootNode.enumerateChildNodes { (node: SCNNode, _: UnsafeMutablePointer<ObjCBool>) in
                node.removeFromParentNode()
            }
        }
        self.play.isEnabled = true
        self.countDown = 10
        self.timerLabel.text = "Let's play"
    }
    
    func addNode() {
        let jellyFishScene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        let jellyFishNode = jellyFishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        jellyFishNode?.position = SCNVector3(
            self.randomNumbers(firstNum: -1, secondNum: 1),
            self.randomNumbers(firstNum: -0.5, secondNum: 0.5),
            self.randomNumbers(firstNum: -1, secondNum: 1)
        )
        self.sceneView.scene.rootNode.addChildNode(jellyFishNode!)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if hitTest.isEmpty {
            print("didn't touch anything")
        } else {
            if self.countDown > 0 {
                let results = hitTest.first!
                let node = results.node
                if node.animationKeys.isEmpty {
                    SCNTransaction.begin()
                    self.animateNode(node: node)
                    SCNTransaction.completionBlock = {
                        node.removeFromParentNode()
                        self.addNode()
                        self.restoreTimer()
                    }
                    SCNTransaction.commit()
                }
            }
        }
    }
    
    func animateNode(node: SCNNode) {
        let spin = CABasicAnimation(keyPath: "position")
        spin.fromValue = node.presentation.position
        spin.toValue = SCNVector3(
            node.presentation.position.x - 0.2,
            node.presentation.position.y - 0.2,
            node.presentation.position.z - 0.2
        )
        spin.duration = 0.07
        spin.autoreverses = true
        spin.repeatCount = 5
        node.addAnimation(spin, forKey: "position")
    }
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }

    func setTimer() {
        self.timer.perform { () -> NextStep in
            if self.countDown == 0 {
                self.timerLabel.text = "You lose"
                return NextStep.stop
            }
            self.countDown -= 1
            self.timerLabel.text = String(self.countDown)
            return NextStep.continue
        }
    }
    
    func restoreTimer () {
        self.countDown = 10
        self.timerLabel.text = String(self.countDown)
        
    }
}


