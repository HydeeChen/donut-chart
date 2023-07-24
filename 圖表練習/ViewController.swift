//
//  ViewController.swift
//  圖表練習
//
//  Created by Hydee Chen on 2023/7/18.
//

import UIKit

class ViewController: UIViewController {
    //拉漸層view的outlet
    @IBOutlet weak var backgroundView: UIView!
    let background = CAGradientLayer()
    //先進行顏色定義
    let mint = UIColor(red: 136/255, green: 227/255, blue: 205/255, alpha: 1)
    let green = UIColor(red: 208/255, green: 230/255, blue: 165/255, alpha: 1)
    let yellow = UIColor(red: 255/255, green: 221/255, blue: 149/255, alpha: 1)
    let red = UIColor(red: 252/255, green: 136/255, blue: 122/255, alpha: 1)
    let purple = UIColor(red: 206/255, green: 170/255, blue: 216/255, alpha: 1)
    let pink = UIColor(red: 219/255, green: 162/255, blue: 176/255, alpha: 1)
    
    //拉輸入類別數字的outlet
    @IBOutlet weak var eat: UITextField!
    @IBOutlet weak var wear: UITextField!
    @IBOutlet weak var live: UITextField!
    @IBOutlet weak var traffic: UITextField!
    @IBOutlet weak var study: UITextField!
    @IBOutlet weak var entertainment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //設定漸層背景
        background.frame =  backgroundView.bounds
        background.colors = [purple.cgColor, yellow.cgColor, UIColor.white.cgColor]
        background.locations = [0.6, 0.8, 0.9]
        backgroundView.layer.addSublayer(background)
    }
    
    //設定記錄button計算百分比
    @IBAction func create(_ sender: Any) {
        // 從使用者介面的文字欄位取得輸入值
        let eatText = eat.text!
        let wearText = wear.text!
        let liveText = live.text!
        let trafficText = traffic.text!
        let studyText = study.text!
        let entertainmentText = entertainment.text!
        
        // 將文字輸入值轉換成 Double 型態。
        let eatNumber = Double(eatText)
        let wearNumber = Double(wearText)
        let liveNumber = Double(liveText)
        let trafficNumber = Double(trafficText)
        let studyNumber = Double(studyText)
        let entertainmentNumber = Double(entertainmentText)
        
        // 檢查所有轉換結果是否不為 nil (即有效的 Double 值)。
        if eatNumber != nil, wearNumber != nil, liveNumber != nil, trafficNumber != nil, studyNumber != nil, entertainmentNumber != nil {
            
            //花費總金額公式
            let totalSpend = eatNumber! + wearNumber! + liveNumber! + trafficNumber! + studyNumber! + entertainmentNumber!
            
            //各項目百分比
            let eatPercentage = (eatNumber! / totalSpend) * 100
            let wearPercentage = (wearNumber! / totalSpend) * 100
            let livePercentage = (liveNumber! / totalSpend) * 100
            let trafficPercentage = (trafficNumber! / totalSpend) * 100
            let studyPercentage = (studyNumber! / totalSpend) * 100
            let entertainmentPercentage = (entertainmentNumber! / totalSpend) * 100
            
            //設定甜甜圈圖表
            let aDegree = CGFloat.pi/180
            let lineWidth: CGFloat = 60
            let radius: CGFloat = 90
            var startDegree: CGFloat = 270
            
            //設定甜甜圈圖表的圓心位置
            let center = CGPoint(x: 50 + lineWidth + radius, y: 500 + lineWidth + radius)
            
            //設定百分比的array
            var percentages: [CGFloat] = [eatPercentage, wearPercentage, livePercentage, trafficPercentage, studyPercentage, entertainmentPercentage]
            var colorIndex = -1
            var nameIndex = -1
            
            //收起鍵盤
            view.endEditing(true)
        
            //使用迴圈製作甜甜圈圖表
            for percentage in percentages {
                
                let endDegree = startDegree + 360 * percentage / 100
                let percentagePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: aDegree * startDegree, endAngle: aDegree * endDegree, clockwise: true)
                
                //先進行顏色定義
                let mint = UIColor(red: 136/255, green: 227/255, blue: 205/255, alpha: 1)
                let green = UIColor(red: 208/255, green: 230/255, blue: 165/255, alpha: 1)
                let yellow = UIColor(red: 255/255, green: 221/255, blue: 149/255, alpha: 1)
                let red = UIColor(red: 252/255, green: 136/255, blue: 122/255, alpha: 1)
                let purple = UIColor(red: 206/255, green: 170/255, blue: 216/255, alpha: 1)
                let pink = UIColor(red: 219/255, green: 162/255, blue: 176/255, alpha: 1)
                
                let percentageLayer = CAShapeLayer()
                percentageLayer.path = percentagePath.cgPath
                var color = [mint, green, yellow, red, purple, pink]
                colorIndex += 1
                percentageLayer.strokeColor = color[colorIndex].cgColor
                percentageLayer.fillColor = UIColor.clear.cgColor
                percentageLayer.lineWidth = lineWidth
                view.layer.addSublayer(percentageLayer)
                
                let textCenterDegree = startDegree + (360 * percentage/100) * 1/2
                let textPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: aDegree * startDegree, endAngle: aDegree * textCenterDegree, clockwise: true)
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
                label.backgroundColor = UIColor.white
                label.font = UIFont.systemFont(ofSize: 14)
                let name = ["食", "衣", "住", "行", "育", "樂"]
                nameIndex += 1
                label.text = String(format: "%.0f", percentage).description+"%,\(name[nameIndex])"
                label.sizeToFit()
                label.center = textPath.currentPoint
                view.addSubview(label)
                startDegree = endDegree
            }
        }
    }
}
    
