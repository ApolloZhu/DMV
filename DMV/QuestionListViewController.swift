//
//  QuestionListViewController.swift
//  DMV
//
//  Created by Apollo Zhu on 12/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class QuestionListViewController: UITableViewController {

    // MARK: Data
    private var sectionID = 0
    private var subSectionID = 0
    private var ids = [Int]()

    open func setup(_ indexPath: IndexPath) {
        sectionID = indexPath.section + 1
        subSectionID = indexPath.row + 1
        ids = quizSet.allQuizIDsIn(section: sectionID, subSection: subSectionID).sorted()
    }

    // MARK: Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ids.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section: \(sectionID).\(subSectionID), total: \(ids.count)"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.NormalReusableTableViewCell, for: indexPath)
        let id = ids[indexPath.row]
        cell.textLabel?.text = "\(id)"
        cell.detailTextLabel?.text = quizSet.quizQuestion(withID: id)
        return cell
    }

    // MARK: Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Identifier.ShowQuizSegue, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.ShowQuizSegue,
            let vc = segue.terminus as? QuizViewController {
            vc.id = ids[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}
