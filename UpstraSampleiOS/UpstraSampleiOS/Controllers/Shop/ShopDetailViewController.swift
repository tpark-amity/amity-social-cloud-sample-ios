
import UIKit
import ImageSlideshow
import Alamofire
import Lottie
class ShopDetailViewController: UIViewController {
    @IBOutlet weak var collectionColor: UICollectionView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnBag: UIButton!
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblbagCount: UILabel!
    @IBOutlet weak var viewDot: UIView!
    @IBOutlet weak var viewAnimation: UIView!
    @IBOutlet weak var lblCartItems: UILabel!
    
    var item: ItemModel?
    var animationView  = AnimationView(name:"cart")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
  }
    func configure() {
        self.lblTitle.text = self.item?.name
        self.lblPrice.text = "$"+self.item!.price
        self.lblDesc.text = self.item!.description
        let pageIndicator =  UIPageControl()
        pageIndicator.hidesForSinglePage = true
        pageIndicator.currentPageIndicatorTintColor = UIColor.black
        pageIndicator.pageIndicatorTintColor = UIColor.white
        slideshow.pageIndicator = pageIndicator
        var sources = [InputSource]()
        for each in self.item!.detailImages{
            sources.append(AlamofireSource(urlString: each)!)
        }
        slideshow.setImageInputs(
           sources
        )
        self.animationView.frame = CGRect(x: 8, y: 3, width: 40, height: 35)
            viewAnimation.addSubview(animationView)
        self.viewAnimation.isHidden = true
        self.lblbagCount.text = "\(Global.shared.cartCount)"
        self.viewDot.isHidden = Global.shared.cartCount <= 0
    }
    @IBAction func actionClose(_ sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func actionAddToCart(_ sender:UIButton){
        self.showAddTocartAnimation()
       }
    func showAddTocartAnimation()  {
        self.btnBag.isHidden = true
        self.viewAnimation.isHidden = false
        animationView.play()
        GCD.async(.Main, delay: 1.3) {
            Global.shared.cartCount += 1
        }
        GCD.async(.Main, delay: 1.3) {
             self.viewAnimation.isHidden = true
            self.btnBag.isHidden = false
            self.lblbagCount.text = "\(Global.shared.cartCount)"
            self.viewDot.isHidden = false
        }
    }
}
extension ShopDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.item!.availableColors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellNames.ColorCell.rawValue, for: indexPath)
        cell.contentView.backgroundColor = hexStringToUIColor(hex: self.item!.availableColors[indexPath.row])
        return cell
      }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 25, height: 25)
    }
}
