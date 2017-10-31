//
//  ViewController.swift
//  OscarArias-Lab3
//
//  Created by labuser on 10/2/17.
//  Copyright © 2017 oarias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var drawingView: UIView!
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var saturationSlider: UISlider!
    @IBOutlet weak var brightnessSlider: UISlider!
    @IBOutlet weak var colorSwitch: UISwitch!
    
    @IBOutlet weak var drawingStack: UIStackView!
    @IBOutlet weak var sliderStack: UIStackView!
    @IBOutlet weak var labelStack: UIStackView!
    
    var currentLine: Line = Line()
    var drawingCanvas: LineView!
    
    var removedLines: [Line] = []
    var hue: CGFloat = 0.0
    
    @IBAction func clearScreen(_ sender: Any) {
        drawingCanvas.theLine = nil
        drawingCanvas.lines = []
        removedLines = []
    }
    
    @IBAction func undoLine(_ sender: Any) {
        if drawingCanvas.lines.count > 0 {
            drawingCanvas.theLine = nil
            removedLines.append(drawingCanvas.lines.removeLast())
        }
    }
    
    
    @IBAction func redoLine(_ sender: Any) {
        if removedLines.count != 0 {
            drawingCanvas.lines.append(removedLines.removeLast())
        }
    }
    
    @IBAction func changeColorSpace(_ sender: Any) {
        drawingStack.isHidden = colorSwitch.isOn
        sliderStack.isHidden = colorSwitch.isOn
        labelStack.isHidden = colorSwitch.isOn
    }
    
    @IBAction func redColor(_ sender: Any) {
        if !colorSwitch.isOn {
            hue = 0.0
            saturationSlider.value = 1.0
            brightnessSlider.value = 1.0
        }
        else {
            drawingView.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func blueColor(_ sender: Any) {
        if !colorSwitch.isOn {
            hue = 240/360
            saturationSlider.value = 1.0
            brightnessSlider.value = 1.0
        }
        else {
            drawingView.backgroundColor = UIColor.blue
        }
    }
    
    @IBAction func greenColor(_ sender: Any) {
        if !colorSwitch.isOn {
            hue = 120/360
            saturationSlider.value = 1.0
            brightnessSlider.value = 1.0
        }
        else {
            drawingView.backgroundColor = UIColor.green
        }
    }
    
    @IBAction func orangeColor(_ sender: Any) {
        if !colorSwitch.isOn {
            hue = 30/360
            saturationSlider.value = 1.0
            brightnessSlider.value = 1.0
        }
        else {
            drawingView.backgroundColor = UIColor.orange
        }
    }
    
    @IBAction func blackColor(_ sender: Any) {
        if !colorSwitch.isOn {
            hue = 0.0
            saturationSlider.value = 0.0
            brightnessSlider.value = 0.0
        }
        else {
            drawingView.backgroundColor = UIColor.black
        }
    }
    
    @IBAction func whiteColor(_ sender: Any) {
        if !colorSwitch.isOn {
            hue = 0.0
            saturationSlider.value = 0.0
            brightnessSlider.value = 1.0
        }
        else {
            drawingView.backgroundColor = UIColor.white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let drawingRectangle = CGRect(x:0, y:0, width:drawingView.frame.width, height:drawingView.frame.height)
        
        drawingCanvas = LineView(frame: drawingRectangle)
        drawingView.addSubview(drawingCanvas)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: drawingView) else { return }
        
        currentLine.color = UIColor(hue: hue, saturation: CGFloat(saturationSlider.value), brightness: CGFloat(brightnessSlider.value), alpha: 1.0)
        
        currentLine.width = CGFloat(widthSlider.value)
        currentLine.points.append(touchPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: drawingView) else { return }
        currentLine.points.append(touchPoint)
        drawingCanvas.theLine = currentLine
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentLine.points.count != 0 {
            drawingCanvas.theLine = nil
            drawingCanvas.lines.append(currentLine)
            currentLine.points = []
        }
    }
}

