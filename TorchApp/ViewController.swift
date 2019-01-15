//
//  ViewController.swift
//  QuickActionDemo
//
//  Created by anges on 31.12.18.
//  Copyright © 2018 anges. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var BtnLevel1: UIButton!
    @IBOutlet weak var BtnLevel2: UIButton!
    @IBOutlet weak var BtnLevel3: UIButton!
    @IBOutlet weak var BtnLevel4: UIButton!
    
    @IBOutlet weak var BtnFlashing: UIButton!
    @IBOutlet weak var SlideupDown: UISlider!
    @IBOutlet weak var UView: UIView!
    
    
    var Switch = false
    var IsFlashing = false
    var Level1IsSet = false
    var Level2IsSet = false
    var Level3IsSet = false
    var Level4IsSet = false
    
    let Torch = TorchHandler()
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Radius: CGFloat = 29
        let Fontsize: CGFloat = 25
        
        BtnLevel1.layer.cornerRadius = Radius
        BtnLevel2.layer.cornerRadius = Radius
        BtnLevel3.layer.cornerRadius = Radius
        BtnLevel4.layer.cornerRadius = Radius
        BtnFlashing.layer.cornerRadius = Radius
        UView.layer.cornerRadius = 73
        
        BtnLevel1.titleLabel?.font = BtnLevel1.titleLabel?.font.withSize(Fontsize)
        BtnLevel2.titleLabel?.font = BtnLevel2.titleLabel?.font.withSize(Fontsize)
        BtnLevel3.titleLabel?.font = BtnLevel3.titleLabel?.font.withSize(Fontsize)
        BtnLevel4.titleLabel?.font = BtnLevel4.titleLabel?.font.withSize(Fontsize)
        
        var SwipeUpDown: UIPanGestureRecognizer!
        SwipeUpDown = UIPanGestureRecognizer(target: self, action: #selector(PanTorchLevel))
        UView.addGestureRecognizer(SwipeUpDown)
    }
    
    
    @objc func PanTorchLevel(sender: UIPanGestureRecognizer)
    {
        let location = sender.location(in: view)
        if sender.state == .changed
        {
            if(location.y > 420)
            {
                Reset()
            }
            
            if(location.y >= 130 && location.y < 200)
            {
                SetTorchLevel4()
                SetLevel4()
            }
            if(location.y >= 200 && location.y < 270)
            {
                SetTorchLevel3()
                SetLevel3()
            }
            if(location.y >= 270 && location.y < 340)
            {
                SetTorchLevel2()
                SetLevel2()
            }
            if(location.y >= 340 && location.y < 410)
            {
                SetTorchLevel1()
                SetLevel1()
            }
            
            //#####################################
//            if(location.y >= 130 && location.y < 200)
//            {
//                SetTorchLevel1()
//                SetLevel1()
//            }
//            if(location.y >= 200 && location.y < 270)
//            {
//                SetTorchLevel2()
//                SetLevel2()
//            }
//            if(location.y >= 270 && location.y < 340)
//            {
//                SetTorchLevel3()
//                SetLevel3()
//            }
//            if(location.y >= 340 && location.y < 410)
//            {
//                SetTorchLevel4()
//                SetLevel4()
//            }
            
            //print(location)
        }
    }
    
    //Set Torch Level1 and set Background to red for the active Button
    func SetTorchLevel1()
    {
        Torch.TorchLevel(level: 0.3)
        
        BtnLevel1.backgroundColor = UIColor.red
        BtnLevel2.backgroundColor = UIColor.green
        BtnLevel3.backgroundColor = UIColor.green
        BtnLevel4.backgroundColor = UIColor.green
    }
    
    //Set Torch Level2 and set Background to red for the active Button
    func SetTorchLevel2()
    {
        Torch.TorchLevel(level: 0.6)
        
        BtnLevel1.backgroundColor = UIColor.green
        BtnLevel2.backgroundColor = UIColor.red
        BtnLevel3.backgroundColor = UIColor.green
        BtnLevel4.backgroundColor = UIColor.green
    }
    
    //Set Torch Level3 and set Background to red for the active Button
    func SetTorchLevel3()
    {
        Torch.TorchLevel(level: 0.9)
        
        BtnLevel1.backgroundColor = UIColor.green
        BtnLevel2.backgroundColor = UIColor.green
        BtnLevel3.backgroundColor = UIColor.red
        BtnLevel4.backgroundColor = UIColor.green
    }
    
    //Set Torch Level4 and set Background to red for the active Button
    func SetTorchLevel4()
    {
        Torch.TorchLevel(level: 1.0)
        
        BtnLevel1.backgroundColor = UIColor.green
        BtnLevel2.backgroundColor = UIColor.green
        BtnLevel3.backgroundColor = UIColor.green
        BtnLevel4.backgroundColor = UIColor.red
    }
    
    
    func SetLevel1()
    {
        Level1IsSet = true
        Level2IsSet = false
        Level3IsSet = false
        Level4IsSet = false
    }
    
    func SetLevel2()
    {
        Level1IsSet = false
        Level2IsSet = true
        Level3IsSet = false
        Level4IsSet = false
    }
    
    func SetLevel3()
    {
        Level1IsSet = false
        Level2IsSet = false
        Level3IsSet = true
        Level4IsSet = false
    }
    
    func SetLevel4()
    {
        Level1IsSet = false
        Level2IsSet = false
        Level3IsSet = false
        Level4IsSet = true
    }
    
    
    //sets the torch level or switche off the torch
    @IBAction func BtnTorchLevelClicked(sender: UIButton)
    {
        switch sender.tag {
        case 1:
            SetTorchLevel1()
            HandleFlash()
            
            if(Level1IsSet)
            {
                Reset()
                return
            }
            
            SetLevel1()
            
        case 2:
            SetTorchLevel2()
            HandleFlash()
            
            if(Level2IsSet)
            {
                Reset()
                return
            }
            
            SetLevel2()
            
        case 3:
            SetTorchLevel3()
            HandleFlash()
            
            if(Level3IsSet)
            {
                Reset()
                return
            }
            
            SetLevel3()
            
        case 4:
            SetTorchLevel4()
            HandleFlash()
            
            if(Level4IsSet)
            {
                Reset()
                return
            }
            
            SetLevel4()
            
        default:
            return
        }
    }
    
    
    //reset all value's
    func Reset()
    {
        Torch.toggleTorch(on: false)
        
        timer.invalidate()
        
        Level1IsSet = false
        Level2IsSet = false
        Level3IsSet = false
        Level4IsSet = false
        
        BtnLevel1.backgroundColor = UIColor.green
        BtnLevel2.backgroundColor = UIColor.green
        BtnLevel3.backgroundColor = UIColor.green
        BtnLevel4.backgroundColor = UIColor.green
        
        //Optional: Disable the flasing button
        //BtnFlashing.isEnabled = false
    }
    
    
    //Helper function to handle the flasher
    func HandleFlash()
    {
        timer.invalidate()
        BtnFlashing.setBackgroundImage(UIImage(named: "flash_on"), for: UIControl.State.normal)
        IsFlashing = false
        
        //+++> Optional: Enable the flashing button
        //++++> flashing can only activated if torch is on
        //+++++> flasing button must be disabled in main.storyboard
        //BtnFlashing.isEnabled = true
    }
    
    
    //Checks, if torch is on or off
    func CheckTorch() -> Bool {
        if (Level1IsSet || Level2IsSet || Level3IsSet || Level4IsSet)
        {
            return true
        }
        else
        {
           return false
        }
    }
    
    
    //Turns the flashing of torch on or off
    //Flasher level = 1.0
    @IBAction func BtnFlash(_ sender: Any) {
        
        if(IsFlashing)
        {
            BtnFlashing.setBackgroundImage(UIImage(named: "flash_on"), for: UIControl.State.normal)
            IsFlashing = false
            
            timer.invalidate()
            
            if(Level1IsSet)
            {
                SetTorchLevel1()
            }
            else if(Level2IsSet)
            {
                SetTorchLevel2()
            }
            else if(Level3IsSet)
            {
                SetTorchLevel3()
            }
            else if(Level4IsSet)
            {
                SetTorchLevel4()
            }
            else
            {
                Torch.toggleTorch(on: false)
            }
        }
        else if (CheckTorch() && timer.isValid)
        {
            BtnFlashing.setBackgroundImage(UIImage(named: "flash_off"), for: UIControl.State.normal)
            IsFlashing = true
            
            timer.invalidate()
        }
        else
        {
            BtnFlashing.setBackgroundImage(UIImage(named: "flash_off"), for: UIControl.State.normal)
            IsFlashing = true
            
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(SlideupDown!.value), target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }
    }
    
    
    //define the slider value and sets the new timer interval
    @IBAction func SliderChanged(_ sender: Any) {
        if(IsFlashing)
        {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(SlideupDown!.value), target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }
        else
        {
            timer.invalidate()
        }
    }
    
    
    //torch will be set to on or off, when timer is elapsed
    @objc func fireTimer() {
        Torch.toggleTorch(on: Switch)
        Switch = !Switch
    }
}

