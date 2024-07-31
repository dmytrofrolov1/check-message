//
//  CollectionController.swift
//  CheckMessage
//
//  Created by Dmytro on 29.07.2024.
//

import UIKit


protocol TableControllerInterface {
    func addMessages(_ data: [MessageViewModel])
    func addMessage(_ message: MessageViewModel)
}

protocol TableControllerDelegate: AnyObject {
    func loadData()
}


class TableController: NSObject {
  
    fileprivate enum Const {
        static let fetchOffset: CGFloat = 30
    }
    
    private weak var tableView: UITableView?
    private var data = [MessageViewModel]()
    
    weak var delegate: TableControllerDelegate?
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.transform = CGAffineTransform(scaleX: 1, y: -1)
        self.tableView?.register(OutgoingMessageCell.self, forCellReuseIdentifier: OutgoingMessageCell.reuseIdentifier)
        self.tableView?.register(IncomingMessageCell.self, forCellReuseIdentifier: IncomingMessageCell.reuseIdentifier)
        self.tableView?.separatorStyle = .none
    }
}

extension TableController: TableControllerInterface {
    func addMessages(_ data: [MessageViewModel]) {
        self.data.append(contentsOf: data.reversed())
        tableView?.reloadData()
    }
    
    func addMessage(_ message: MessageViewModel) {
        data.insert(message, at: 0)
        tableView?.reloadData()
    }
}

extension TableController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let viewModel = data[indexPath.row]
   
        if viewModel.userId == GlobalConst.userId {
            return outgoingMessage(tableView: tableView, indexPath: indexPath)
        } else {
            return incomingMessage(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y + scrollView.frame.height
        guard position > scrollView.contentSize.height - Const.fetchOffset else { return }
        
        delegate?.loadData()
    }
    
    
    func outgoingMessage(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingMessageCell.reuseIdentifier, for: indexPath) as? OutgoingMessageCell else {
            return UITableViewCell()
        }
         
        let viewModel = data[indexPath.row]
        cell.updateWithModel(viewModel)

        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        return cell
    }
    
    func incomingMessage(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IncomingMessageCell.reuseIdentifier, for: indexPath) as? IncomingMessageCell else {
            return UITableViewCell()
        }
         
        let viewModel = data[indexPath.row]
        cell.updateWithModel(viewModel)

        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        return cell
    }
    
}
