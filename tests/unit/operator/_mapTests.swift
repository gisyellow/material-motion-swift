/*
 Copyright 2016-present The Material Motion Authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import XCTest
import CoreGraphics
import IndefiniteObservable
@testable import MaterialMotionStreams

class _mapTests: XCTestCase {

  func testSubscription() {
    let value = 10

    let observable = MotionObservable<Int> { observer in
      observer.next(value)
      observer.state(.active)
      return noopUnsubscription
    }

    let valueReceived = expectation(description: "Value was received")
    let stateReceived = expectation(description: "State was received")
    let _ = observable._map { value in
      return value * 10

    }.subscribe(next: {
      if $0 == value * 10 {
        valueReceived.fulfill()
      }
    }, state: { state in
      if state == .active {
        stateReceived.fulfill()
      }
    })

    waitForExpectations(timeout: 0)
  }
}