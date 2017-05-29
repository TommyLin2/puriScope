//
//  TypeSomethingViewController.h
//  Pickers
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>

extern NSString *nname,*aadress,*pperson;

@protocol TypeSomethingViewControllerDelegate;

@interface TypeSomethingViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate,UITextFieldDelegate,CNContactViewControllerDelegate,CNContactPickerDelegate>

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
