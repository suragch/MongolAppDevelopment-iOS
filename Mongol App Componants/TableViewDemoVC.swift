import UIKit

class TableViewDemoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mongolTableView: UIMongolTableView!
    
    let renderer = MongolUnicodeRenderer.sharedInstance
    let mongolFont = "ChimeeWhiteMirrored"
    let fontSize: CGFloat = 24
    
    // Array of strings to display in table view cells
    var items: [String] = ["ᠨᠢᠭᠡ", "ᠬᠣᠶᠠᠷ", "ᠭᠤᠷᠪᠠ", "One", "Two", "Three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the table view from the IB reference
        mongolTableView.delegate = self
        mongolTableView.dataSource = self
        self.mongolTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // set up the cells for the table view
        let cell: UITableViewCell = self.mongolTableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        
        // TODO: use a custom UIMongolTableViewCell to render and choose font
        cell.textLabel?.text = renderer.unicodeToGlyphs(self.items[(indexPath as NSIndexPath).row])
        cell.textLabel?.font = UIFont(name: mongolFont, size: fontSize)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\((indexPath as NSIndexPath).row)!")
    }
}
