//
//  Tweak.xm
//
//  Created by Maximilian Katzmann on 27.12.13.
//  You may use or modify this however you like.
//

/*
This simple tweak gets rid off the Missed view in iOS 7's
notification center.
*/

/*
This is the only class we need to hook.
When the SBModeViewController, that the SBNotificationCenterViewController uses,
gets told what viewControllers it should use, we interfere! :P 
*/
@interface SBModeViewController
-(void)setViewControllers:(id)arg1 ;
@end

%hook SBModeViewController

-(void)setViewControllers:(id)arg1
{
	/*
	This is the array that will replace the one we got passed (arg1)
	*/
	NSArray *DMnewViewControllers = nil;
	
	/*
	It should be an array, but we want to be sure...
	*/
	if ([arg1 isKindOfClass:[NSArray class]]) {

		/*
		This is a mutable array where we will add ALL the view controllers
		that are in the original array, except for the one that represents
		the missed view.
		*/
		NSMutableArray *DMmutableNewViewControllers = [[[NSMutableArray alloc] init] autorelease];

		/*
		Traversing the array
		*/
		for (id vc in (NSArray *)arg1) {

			/*
			Checking whether the view controller that we are currently observing
			is a SBNotificationCenterMissedModeViewController. If not, we add it
			to our mutable array. Otherwise we will ignore it, because we don't
			want that view controller!
			*/
			if (![vc isKindOfClass:[%c(SBNotificationsMissedModeViewController) class]]) {
				[DMmutableNewViewControllers addObject:vc];
			}
		}

		/*
		Creating a non-mutable array from our mutable one, to replace arg1.
		*/
		DMnewViewControllers = [[[NSMutableArray alloc] initWithArray:DMmutableNewViewControllers] autorelease];
	}

	/*
	If everything went fine DMnewViewControllers will not be nil and
	we can safely replace arg1 with it.
	*/
	if (DMnewViewControllers) arg1 = DMnewViewControllers;

	/*
	Don't forget to call %orgi ! It will proceed to execute the method
	as it was intended to be, but with our modified array.
	*/
	%orig;
}

%end