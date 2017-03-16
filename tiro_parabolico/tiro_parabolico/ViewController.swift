//
//  ViewController.swift
//  tiro_parabolico
//
//  Created by Marco Peyrot on 3/11/17.
//  Copyright © 2017 Marco Peyrot. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    @IBOutlet weak var yVelocityLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    var yAxis: [Int]!
    var lineChartDataSet = LineChartDataSet()
    var lineChartData = LineChartData()
    var index:Int = -1
    var shot: Shot!
    
    var initialVelocity: Double!
    var startX: Double!
    var startY: Double!
    var angle: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        yAxis = []
        setChart(yValues: yAxis)
        shot = Shot(initialVelocity, startX, startY, angle)
        
        yVelocityLabel.text = String(shot.getYVelocity(0))
        distanceLabel.text = String(shot.xForTime(0)!)
        heightLabel.text = String(shot.yForTime(0)!)
        timeLabel.text = String(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setChart(yValues: [Int]){
        
        var dataInput: [ChartDataEntry] = []
        
        for i in 0..<yValues.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(yValues[i]))
            dataInput.append(dataEntry)
        }
        
        lineChartDataSet = LineChartDataSet(values: dataInput, label: "Altura")
        lineChartDataSet.circleRadius = 2
        lineChartDataSet.circleColors = [NSUIColor.black]
        lineChartDataSet.lineWidth = 5
        lineChartDataSet.colors = [NSUIColor.black]
        lineChartDataSet.drawValuesEnabled = false
        lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        lineChartView.animate(xAxisDuration: 1)
        
    }
    
    @IBAction func update(_ sender: UIStepper) {
        let value = Int(sender.value)
        
        if yAxis.count < value {
            yAxis.append(value - 1)
            index += 1
        } else {
            yAxis.removeLast()
            index -= 1
        }
        setChart(yValues: yAxis)
        
        // Shot info
        yVelocityLabel.text = String(shot.getYVelocity(sender.value))
        distanceLabel.text = String(shot.xForTime(sender.value)!)
        heightLabel.text = String(shot.yForTime(sender.value)!)
        timeLabel.text = String(sender.value)

    }
    
}

