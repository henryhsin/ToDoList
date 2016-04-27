//
//  FirstViewController.swift
//  ToDoList
//
//  Created by appsgaga on 2015/11/4.
//  Copyright © 2015年 appsgaga. All rights reserved.
//

import UIKit

var tasks = [String]()//代表說這是一個字串的陣列，後面加上()代表生出一個存字串的陣列，再把這個陣列存在task這個變數裡面

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var addTaskReminder: UILabel!
    
    override func viewDidLoad() {//先去檢查NSUserDefault有無存待辦事項
        super.viewDidLoad()
        if NSUserDefaults.standardUserDefaults().objectForKey("tasks") != nil{
            tasks = NSUserDefaults.standardUserDefaults().objectForKey("tasks") as! Array
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        myTableView.reloadData()//這樣每次回到這個畫面時tableView的data便會重新relioad一次，變成當前的資料
        
        if tasks.count == 0{
            addTaskReminder.hidden = false
        }else{
            addTaskReminder.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent//讓ststusbar上的文字變為白色
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        cell.textLabel?.textColor = UIColor.whiteColor()//將文字顏色設成白色

        cell.textLabel?.font = UIFont(name: "arial", size: 24)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {//當選到了某一列該做些什麼事
        myTableView.deselectRowAtIndexPath(indexPath, animated: false)//取消選取這一列，如此一來這一列被選到時便不會反白

    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {//要做出將待辦事項向左滑動刪除時的功能
        if editingStyle == .Delete{//若要刪除tableView中某一列
            tasks.removeAtIndex(indexPath.row)//就用removeAtIndex(indexPath.row就是選取的那一列)
            NSUserDefaults.standardUserDefaults().setObject(tasks, forKey: "tasks")//接著要把刪除後的結果存檔回去
            myTableView.reloadData()//再讓tableView重新reload data
            if tasks.count == 0{
                addTaskReminder.hidden = false
            }else{
                addTaskReminder.hidden = true
            }
        }
    }
}






