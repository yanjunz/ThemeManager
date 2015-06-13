# ThemeManager

`ThemeManager` use Category to add theme. And it is super easy to add theme to your app without changing a lot of existed code. You can apply theme to `UIButton` and `UILabel` and `UIImageView`.

# Preparation

Organize theme resources in the following format:

## A summary file to include all themes
* res/themes/theme.plist  

## Theme directory
* res/themes/theme1     
* res/themes/theme2

## Theme Description file and icon file
* res/themes/theme1/config.plist
* res/themes/theme1/icon@2x.png

## Theme resources
* res/themes/theme1/res

# Create config.plist for theme with script
* cd Resources
* sh import_theme.sh


## Usage

```objective-c
cell.textLabel.text = item[@"title"];

// Apply theme text color for textLabel
cell.textLabel.themeMap = @{kThemeMapKeyColorName : @"left_tabbar_cell_title"};
// Apply theme image for imageView
cell.imageView.themeMap = @{kThemeMapKeyImageName : imageName};
```

## License
ThemeManager is available under the MIT license. See the LICENSE file for more info.
