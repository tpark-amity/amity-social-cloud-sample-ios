
import UIKit
import AVKit
import AVFoundation
import NotificationCenter
let STATUS_KEY = "status"
class LiveStreamViewController: UIViewController {
    @IBOutlet weak var tblComments: UITableView!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var viewPlayer: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblViewers: UILabel!
    @IBOutlet weak var lblHeadLine: UILabel!
    @IBOutlet weak var imgUser: UIImageView!

    var avPlayer: AVPlayer!
    let playerController = AVPlayerViewController()
    var playerLayer: AVPlayerLayer!
    var dataModel:LiveStreamModel!
    var source = [CommentModel](){
        didSet{
            GCD.async(.Main) {
                self.tblComments.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Global.shared.ekoManager.getAllComments(for: self.dataModel.channelid) { (comments) in
            self.source = comments
        }
        self.tblComments.register(UINib(nibName: TableViewCellNames.LiveCommentTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: TableViewCellNames.LiveCommentTableViewCell.rawValue)
        self.tblComments.rowHeight = UITableView.automaticDimension
        self.tblComments.transform = CGAffineTransform (scaleX: 1,y: -1);
        self.tblComments.estimatedRowHeight = 60
        self.tblComments.tableFooterView = UIView()
        self.lblName.text = self.dataModel.name
        self.lblHeadLine.text = self.dataModel.headline
        self.lblViewers.text =  self.dataModel.viewers + VIEWERS
        self.imgUser.imageFromUrl(urlString: dataModel.coverImage)
        self.imgUser.contentMode = .scaleAspectFill
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear((animated))
            self.playVideo()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removePlayer()
        
    }
    func playVideo() {
        avPlayer = AVPlayer(url: URL(string: self.dataModel.videourl)!)
        avPlayer.seek(to:CMTimeMakeWithSeconds(0.0,preferredTimescale: .max))
        avPlayer.play()
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        avPlayer.addObserver(self, forKeyPath: STATUS_KEY, options: .new, context: nil)
        self.playerLayer = AVPlayerLayer(player:avPlayer)
        self.playerLayer.frame = self.viewPlayer.layer.bounds
        self.viewPlayer.layer.addSublayer(self.playerLayer)
       }
    func removePlayer() {
       avPlayer.pause()
        self.avPlayer.removeObserver(self, forKeyPath: STATUS_KEY)
       NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
        self.playerLayer.removeFromSuperlayer()
      }
    @objc func playerDidFinishPlaying() {
        avPlayer.seek(to:CMTimeMakeWithSeconds(0.0,preferredTimescale: .max))
        self.avPlayer.play()
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath?.elementsEqual(STATUS_KEY))! && self.avPlayer.status == AVPlayer.Status.readyToPlay{
            self.avPlayer.play()
      }
    }
    @IBAction func actionFullScreen(_ sender:UIButton){
        self.playerController.player?.pause()
           let vc = self.storyboard?.instantiateViewController(withIdentifier: ControllerNames.LiveStreamDetailViewController.rawValue) as! LiveStreamDetailViewController
        vc.dataModel = self.dataModel
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func actionBack(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
       }
    
}
extension LiveStreamViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellNames.LiveCommentTableViewCell.rawValue, for: indexPath) as! LiveCommentTableViewCell
        cell.configure(comment: self.source[indexPath.row])
        cell.selectionStyle = .none
        cell.transform = CGAffineTransform (scaleX: 1,y: -1);
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.source[indexPath.row].getSizeForCommentBox().height
    }
    
}
