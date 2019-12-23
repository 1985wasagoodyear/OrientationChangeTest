#  Orientation Change Test

An evaluation on handling orientation-changes, and resizing UI for it.

## Orientation-change Options:

1. `NSNotificationCenter`

* Observe the `UIDevice.orientationDidChangeNotification` notification. 
* Seems to occur on orientation changes.

2. `viewWillTransition:toSize:withCoordinator`

* UIViewController method, can be overridden.
* Always happens later than the aforementioned option.


## Additional Notes:

1. UIDevice needs to be told to [`beginGeneratingDeviceOrientationNotifications`](https://developer.apple.com/documentation/uikit/uidevice/1620041-begingeneratingdeviceorientation?language=objc).
2. Each above call must be paired with a call to `endGeneratingDeviceOrientationNotifications`.
3. Despite the documenation stating that, the necessity of doing so seems questionable...?

