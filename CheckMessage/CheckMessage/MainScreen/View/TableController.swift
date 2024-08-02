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
    func deleteMessage(_ message: MessageViewModel)
}

protocol TableControllerDelegate: AnyObject {
    func loadData()
    func didTapOnCell()
    func deleteMessage(viewModel: MessageViewModel)
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
    func deleteMessage(_ message: MessageViewModel) {
        guard let index = data.firstIndex(where: { $0.messageId == message.messageId }) else { return }
        let indexPath = IndexPath(row: index, section: 0)
        data.remove(at: index)
        tableView?.deleteRows(at: [indexPath], with: .automatic)
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapOnCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y + scrollView.frame.height
        guard position > scrollView.contentSize.height - Const.fetchOffset else {
            return
        }
        
        delegate?.loadData()
    }
    
    
    func outgoingMessage(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingMessageCell.reuseIdentifier, for: indexPath) as? OutgoingMessageCell else {
            return UITableViewCell()
        }
        
        let viewModel = data[indexPath.row]
        cell.updateWithModel(viewModel)
        
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        cell.selectionStyle = .none
        
        let interaction = UIContextMenuInteraction(delegate: self)
        cell.addInteraction(interaction)
        
        return cell
    }
    
    func incomingMessage(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IncomingMessageCell.reuseIdentifier, for: indexPath) as? IncomingMessageCell else {
            return UITableViewCell()
        }
        
        let viewModel = data[indexPath.row]
        cell.updateWithModel(viewModel)
        
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        cell.selectionStyle = .none
        
        let interaction = UIContextMenuInteraction(delegate: self)
        cell.addInteraction(interaction)
        
        return cell
    }
    
}

extension TableController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, 
                                configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        guard let tableView = tableView else { return nil }
        let locationInTableView = tableView.convert(location, from: interaction.view)
        guard let indexPath = tableView.indexPathForRow(at: locationInTableView) else { return nil }
        
        let identifier = NSString(string: "\(indexPath.row)")
        let viewModel = data[indexPath.row]
        
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { [weak self] _ in
            let deleteAction = UIAction(title: "Delete",
                                        image: UIImage(systemName: "trash"),
                                        attributes: .destructive) { action in
                self?.delegate?.deleteMessage(viewModel: viewModel)
            }
            return UIMenu(title: "", children: [deleteAction])
        }
    }
}
