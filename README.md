# CartTrackr
-Swift 3-

  Designed to help budget-minded individuals keep track of the cost of items they've put into their cart at the store, CartTrackr uses SwiftOCR, an Optical Character Recognition framework, to read the price tag of an item to get the price for you. The app saves the items in your cart and calculates the pre-tax and post-tax totals for you as you add, modify, and remove items. Additionally, users may set a budget value they wish to conform to and are presented with a progress bar to visualize how they are doing. Upon reaching 100% of the progress bar the background changes color to red to alert the user.
  
# Usage Guide
  Upon load of the app, user is presented with the Cart List view, which has 4 icons across the bottom. The first icon on the left (a $ with an arrow pointing up to a line) opens a menu for setting a budget; setting a budget causes a progress bar to appear on the Cart List view. The second icon is a +, which is used to manually add an item to the cart. Tapping the icon opens the Manual Item entry view, allowing the user to enter the price, description, and quantity of an item. 
  
  The third icon is a camera with a + inside, which will take the user to the camera view when tapped. From the camera view, the user would attempt to fit the price from the price tag inside the rectangle frame. Upon taking a picture, the image is processed through the OCR and will transition the user to the Manual entry view while filling the price field with the extracted price. The fourth icon, which is a + next to four stacked horizontal lines, is meant to clear the list and start over; it will show an action sheet to confirm or cancel this delete action.
  
  The user may delete a single item from the list by swiping left on that item in the list view and selecting "Delete". Tapping on an item in the list will take the user to the Modify Item screen, allowing them to alter any or all of the item's details. Once the post-tax total meets or exceeds the assigned budget, the background of the app changes from blue to red.

# Libraries and Frameworks
  SwiftOCR: Optical Character Recognition framework processes images to pull out short alphanumeric strings
  
  GPU Image: Dependency of SwiftOCR
  
  SwiftyCam: Customizable camera view controller based on AVFoundation
  
  STZPopupView: Programmatically adds popup view overlays on a view controller
  
  AVFoundation: Used in creating and customizing the camera functionality

# Development Team
  A concerted effort by Christina Lee, Brandon Little, and Jay Balderas. 

  Shoutout to Erica Winberry, Jeremy Moore, Cathy Oun, Corey Malek, and Adam Walraff for all their help.
