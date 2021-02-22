/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class MultipleResponsibilityViewController: UIViewController {

  let data = ["Dog", "Cat", "Octopus", "Skunk", "Squirrel"]
  let imageNames = ["dog", "cat", "octopus", "skunk", "squirrel"]
  private var selectedIndex: IndexPath!

  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    navigationController?.delegate = self
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let viewController = segue.destination as? AnimalDetailsViewController {
      viewController.animal = data[selectedIndex.row]
      viewController.image = UIImage(named: imageNames[selectedIndex.row])
    }
  }

}

extension MultipleResponsibilityViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "animal") ?? UITableViewCell(style: .default, reuseIdentifier: "data")
    cell.textLabel?.text = data[indexPath.row]
    cell.imageView?.image = UIImage(named: imageNames[indexPath.row])
    return cell
  }

}

extension MultipleResponsibilityViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedIndex = indexPath
    performSegue(withIdentifier: "showAnimal", sender: nil)
    tableView.deselectRow(at: indexPath, animated: true)
  }

}

extension MultipleResponsibilityViewController: UINavigationControllerDelegate {

  func navigationController(_ navigationController: UINavigationController,
                            animationControllerFor operation: UINavigationController.Operation,
                            from fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if fromVC == self && toVC is AnimalDetailsViewController {
      return self
    }
    return nil
  }

}

extension MultipleResponsibilityViewController: UIViewControllerAnimatedTransitioning {

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.2
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    transitionContext.containerView.backgroundColor = .white

    guard let toView = transitionContext.view(forKey: .to),
      let fromView = transitionContext.view(forKey: .from),
      let fromViewController = transitionContext.viewController(forKey: .from) as? MultipleResponsibilityViewController,
      let toViewController = transitionContext.viewController(forKey: .to) as? AnimalDetailsViewController,
      let selectedCell = fromViewController.tableView.cellForRow(at: selectedIndex) else {
        transitionContext.completeTransition(false)
        return
    }

    transitionContext.containerView.addSubview(fromView)
    transitionContext.containerView.addSubview(toView)

    let imageCopy = UIImageView(image: selectedCell.imageView!.image)
    transitionContext.containerView.addSubview(imageCopy)
    imageCopy.frame = selectedCell.convert(selectedCell.imageView!.frame, to: nil)

    toView.alpha = 0
    toViewController.view.layoutSubviews()
    toViewController.imageView.alpha = 0

    UIView.animate(withDuration: 0.2, animations: {
      imageCopy.frame = toViewController.view.convert(toViewController.imageView.frame, to: nil)
      toView.alpha = 1
    }, completion: { complete in
      imageCopy.removeFromSuperview()
      toViewController.imageView.alpha = 1
      transitionContext.completeTransition(complete)
    })
  }


}

class AnimalDetailsViewController: UIViewController {

  var animal: String!
  var image: UIImage!
  
  @IBOutlet weak var imageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = animal

    imageView.image = image
  }

}
