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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

class CoffeeApp {

  func makeCoffeeForMe() {
    let coffeeMaker = FilterCoffeeMaker()
    coffeeMaker.fill(with: Bean.arabica.grind())
    coffeeMaker.brew()
  }

}

class FilterCoffeeMaker {

  private let cafetiere = Cafetiere()

  func fill(with groundCoffee: GroundCoffee) {
    cafetiere.groundCoffee = groundCoffee
  }

  func brew() {
    cafetiere.plunge()
  }

}

class BeanToCupMachine {

  private var beans: Bean?

  func add(_ beans: Bean) {
    self.beans = beans
  }

  func make() {
    guard let groundCoffee = beans?.grind() else {
      return
    }
    _ = groundCoffee
    // make the coffee from the grounds
  }

}

class EspressoMachine {

  func make(from groundCoffee: GroundCoffee) {
    // yum, our coffee is nearly ready
  }

}

struct Bean {
  let strength: Int

  static let arabica = Bean(strength: 3)
  static let robusta = Bean(strength: 4)

  func grind() -> GroundCoffee {
    GroundCoffee(strength: self.strength)
  }
}
class Cafetiere {
  var groundCoffee: GroundCoffee?

  func plunge() {
    // push the plunger down!
  }
}

struct GroundCoffee {
  let strength: Int
}
