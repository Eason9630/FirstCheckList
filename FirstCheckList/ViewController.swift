//
//  ViewController.swift
//  FirstCheckList
//
//  Created by 林祔利 on 2023/8/31.
//

import UIKit

// 定義待辦事項的數據模型
class CheckListItem {
    let title: String  // 標題
    var isChecked: Bool = false  // 是否已勾選
    
    init(title: String) {
        self.title = title
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 初始化待辦事項列表
    let items:[CheckListItem] = [
        "Get Mike",
        "Go on a Long Run",
        "Practice Swift",
        "Do exercise",
        "Go Gym",
        "Read English"
    ].compactMap({
        CheckListItem(title: $0)
    })
    
    // 創建一個 TableView
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 將 TableView 添加到畫面中
        view.addSubview(table)
        
        // 設置 TableView 的代理與數據源為當前 ViewController
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 設置 TableView 的尺寸為整個畫面
        table.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isChecked ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        item.isChecked = !item.isChecked
        DispatchQueue.main.async {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
