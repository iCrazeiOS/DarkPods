#import <UIKit/UIKit.h>

@interface PRXTextView : UITextView
-(void)setTitleText:(id)titleView;
@end

@interface PRXCardContentView : UIView
@end

@interface UILabel (Private)
-(UIViewController *)_viewControllerForAncestor;
@end

void colourSubviews(UIView *view) {
	for (UIView *subview in view.subviews) {
		[subview setBackgroundColor:[UIColor colorWithRed:0.11 green:0.11 blue:0.12 alpha:1.0]];
		for (UIView *subview2 in subview.subviews) {
			[subview2 setBackgroundColor:[UIColor colorWithRed:0.11 green:0.11 blue:0.12 alpha:1.0]];
		}
	}
}

%hook UILabel
-(void)setText:(NSString *)text {
	%orig;
	if (suggestionsVisible) return %orig;

	if ([[self _viewControllerForAncestor] class] == %c(ProximityStatusViewController)) {
		[self setTextColor:[UIColor whiteColor]];
	}
}
%end

%hook PRXCardContentView
-(void)setTitleView:(PRXTextView *)titleView {
	%orig;
	if (titleView) {
		// This is an easy way to achieve the bolder text from iOS 17
		[titleView setTitleText:titleView.text];

		// Must set colour after setting text
		[titleView setTextColor:[UIColor whiteColor]];

		// Fix text background colour
		[titleView setBackgroundColor:[UIColor colorWithRed:0.11 green:0.11 blue:0.12 alpha:1.0]];

		colourSubviews(self.superview.superview);
	}
	%init(SuggestionsHooks);
}
%end
