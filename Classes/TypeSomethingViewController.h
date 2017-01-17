//
//  TypeSomethingViewController.h
//  Pickers
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
extern NSString *nname,*aadress,*pperson;

@protocol TypeSomethingViewControllerDelegate;

@interface TypeSomethingViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate,UITextFieldDelegate>{
    UITextField *textField;
    UILabel *personlabel;
	id<TypeSomethingViewControllerDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet UILabel *personlabel;
@property (retain) IBOutlet UITextField *textField;
@property (assign) id<TypeSomethingViewControllerDelegate> delegate;

- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)showPeoplePicker:(id)sender;


@end

@protocol TypeSomethingViewControllerDelegate <NSObject>

@optional
- (void)typeSomethingViewController:(TypeSomethingViewController *)controller didTypeSomething:(NSString *)text;

@end