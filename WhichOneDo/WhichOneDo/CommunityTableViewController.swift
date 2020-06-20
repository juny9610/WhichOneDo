import UIKit


class CommunityTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var communityTable: UITableView!
    @IBOutlet var viewForTable: UIView!
    @IBOutlet var viewForTable2: UIView!
    @IBOutlet var communityTable2: UITableView!
    let array1 = ["내가 쓴 글", "댓글 단 글", "스크랩"]
    let array2 = ["자유게시판", "리뷰게시판", "정보게시판", "이벤트"]
    override func viewDidLoad() {
        super.viewDidLoad()
        communityTable2.dataSource = self
        communityTable2.delegate =  self
        communityTable2.separatorStyle = .none
        viewForTable2.layer.cornerRadius = 30
        viewForTable2.layer.borderWidth = 1.0
        viewForTable2.layer.borderColor = UIColor(hex: "BFBFBF").cgColor
        viewForTable2.clipsToBounds = true

        communityTable.dataSource = self
        communityTable.delegate = self
        communityTable.separatorStyle = .none
        viewForTable.layer.cornerRadius = 30
        viewForTable.layer.borderWidth = 1.0
        viewForTable.layer.borderColor = UIColor(hex: "BFBFBF").cgColor
        viewForTable.clipsToBounds = true
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.communityTable{
            return array1.count
        }
        else{
            return array2.count
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if tableView == self.communityTable{
            cell = communityTable.dequeueReusableCell(withIdentifier: "noticeCell")
            cell?.textLabel?.text = array1[indexPath.row]
        }
        else{
            cell = self.communityTable2.dequeueReusableCell(withIdentifier: "noticeCell")
            cell?.textLabel?.text = self.array2[indexPath.row]
        }
        return cell!
    }
    
    
}
