
import UIKit
class ArticleViewController: BaseViewController {
    @IBOutlet weak var menuBarView: MenuTabsView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    var currentIndex: Int = 0
    var pageController: UIPageViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        if Global.shared.isCorrectData{
            self.configure()
        }else{
            self.showWrongDataAlert()
        }
    }
    func configure() {
        var tabs = [String]()
        for each in Global.shared.appData.articleList.articles{
            tabs.append(each.name)
        }
        self.menuBarView.dataArray = tabs
        self.menuBarView.isSizeToFitCellsNeeded = true
        self.menuBarView.collView.backgroundColor = UIColor.clear
        presentPageVCOnView()
        self.menuBarView.menuDelegate = self
        pageController.delegate = self
        pageController.dataSource = self
        self.menuBarView.collView.selectItem(at: IndexPath.init(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
        pageController.setViewControllers([viewController(At: 0)!], direction: .forward, animated: true, completion: nil)
        self.lblTitle.text = Global.shared.appData.mainTitle
        self.showHideElements(isSelected: true)
        
    }
    func showHideElements(isSelected:Bool)  {
        if isSelected{
            self.btnSearch.isSelected = false
            self.lblTitle.isHidden = false
            self.txtSearch.isHidden = true
            self.txtSearch.resignFirstResponder()
        }else{
            self.btnSearch.isSelected = true
            self.lblTitle.isHidden = true
            self.txtSearch.isHidden = false
            self.txtSearch.becomeFirstResponder()
        }
    }
    func presentPageVCOnView() {
        self.pageController = UIStoryboard.init(name: StoryBoardNames.Main.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PageControllerVC") as! PageControllerVC
        self.pageController.view.frame = CGRect.init(x: 0, y: menuBarView.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - menuBarView.frame.maxY)
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)
        self.pageController.didMove(toParent: self)
    }
    func viewController(At index: Int) -> UIViewController? {
        if((self.menuBarView.dataArray.count == 0) || (index >= self.menuBarView.dataArray.count)) {
            return nil
        }
        let vc = UIStoryboard.init(name: StoryBoardNames.Article.rawValue, bundle: nil).instantiateViewController(withIdentifier: ControllerNames.ArticleContentViewController.rawValue) as! ArticleContentViewController
        vc.pageIndex = index
        vc.source = Global.shared.appData.articleList.articles[index]
        currentIndex = index
        menuBarView.selectedIndex = index
        return vc
    }
}

extension ArticleViewController: MenuBarDelegate {
    func menuBarDidSelectItemAt(menu: MenuTabsView, index: Int) {
        if index != currentIndex {
            if index > currentIndex {
                self.pageController.setViewControllers([viewController(At: index)!], direction: .forward, animated: true, completion: nil)
            }else {
                self.pageController.setViewControllers([viewController(At: index)!], direction: .reverse, animated: true, completion: nil)
            }
            menuBarView.selectedIndex = index
            menuBarView.collView.selectItem(at: IndexPath.init(item: index, section: 0), animated: true, scrollPosition: .centeredVertically)
            menuBarView.collView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
            menuBarView.updateCells(forIndex: index)
        }
    }
}
extension ArticleViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ArticleContentViewController).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return self.viewController(At: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ArticleContentViewController).pageIndex
        if (index == Global.shared.appData.articleList.articles.count) || (index == NSNotFound) {
            return nil
        }
        index += 1
        return self.viewController(At: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            if completed {
                let cvc = pageViewController.viewControllers!.first as! ArticleContentViewController
                let newIndex = cvc.pageIndex
                menuBarView.collView.selectItem(at: IndexPath.init(item: newIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
                menuBarView.collView.scrollToItem(at: IndexPath.init(item: newIndex, section: 0), at: .centeredHorizontally, animated: true)
                menuBarView.updateCells(forIndex: newIndex)
            }
        }
        
    }
}
