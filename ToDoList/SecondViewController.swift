//
//  SecondViewController.swift
//  ToDoList
//
//  Created by appsgaga on 2015/11/4.
//  Copyright © 2015年 appsgaga. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!//用於改變button的文字
    
    @IBAction func changeText(sender: UITextField) {//此變數是用來偵測使用者有無輸入文字，若無：button維持Back字樣及功能;若有：button改變成add字樣及功能
        //其中事件選為editing changed

        if myTextField.text == ""{
            addButton.setTitle("Back", forState: .Normal)
            addButton.setTitle("Back", forState: .Selected)
            //我覺得selected和normal都是成雙成對會出現的狀態
        }else{
            addButton.setTitle("Add", forState: .Normal)//一般(Normal)的狀況，button要設為back

            addButton.setTitle("Add", forState: .Selected)//當有輸入文字但最後又清空文字(Selected)的狀況要設為back

        }
    }
    
    @IBAction func addTasks(sender: UIButton) {
        if myTextField.text != ""{//代表要存待辦事項，所以要寫有關存檔的程式
            //存檔
            tasks.append(myTextField.text!)//這代表在task Array後添加myTextField.text

            NSUserDefaults.standardUserDefaults().setObject(tasks, forKey: "tasks")
        }
        myTextField.text = ""//不論有無新增新的代辦事項，都須將myTextField.text清空

        myTextField.resignFirstResponder()//再將鍵盤收起
        self.tabBarController?.selectedIndex = 0//再回到tabBar的第一個畫面(i.e.有許多待辦事項的那個畫面)
        //大部分的user都會希望輸入完直接按下鍵盤上的return鍵即可新增待辦事項，所以我們需偵測keyBoard上的return鍵(回到mainStoryBoard把textField的delegate連到Add viewController，再新增UITextFieldDelegate。並利用textFieldShouldReturn() func去執行按下鍵盤return鍵後的工作)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        myTextField.becomeFirstResponder()//每次跳到這個畫面都想要自動跳出鍵盤
        //每次跳到這個畫面時，也要預設把按鈕的文字改成back
        addButton.setTitle("Back", forState: .Normal)//一般(Normal)的狀況，button要設為back

        addButton.setTitle("Back", forState: .Selected)//當有輸入文字但最後又清空文字(Selected)的狀況要設為back

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {//鍵盤按下return鍵後該做的事

        if myTextField.text != ""{
            //存檔
            tasks.append(myTextField.text!)
            NSUserDefaults.standardUserDefaults().setObject(tasks, forKey: "tasks")
            myTextField.text = ""
            myTextField.resignFirstResponder()
            self.tabBarController?.selectedIndex = 0
        }
        
        
        return true
    }
}

