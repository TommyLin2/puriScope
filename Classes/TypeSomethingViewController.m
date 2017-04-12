//
//  TypeSomethingViewController.m
//  Pickers
//

#import "TypeSomethingViewController.h"
NSString *nname,*aadress,*pperson;

@implementation TypeSomethingViewController

@synthesize textField;
@synthesize delegate,personlabel;

- (IBAction)doneButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(typeSomethingViewController:didTypeSomething:)]) {
        [self.delegate typeSomethingViewController:self didTypeSomething:textField.text];
    }
	if([textField.text isEqualToString:@""])
	{
		nname=@"          -";
	}else
	{
        nname= textField.text;
	}
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- ( BOOL)textFieldShouldReturn:(UITextField *)textfField
{
	[textfField resignFirstResponder];
	return YES;
}

- (IBAction)showPeoplePicker:(id)sender
{
    ABPeoplePickerNavigationController *peoplePickerController = [[ABPeoplePickerNavigationController alloc] init];
    peoplePickerController.peoplePickerDelegate = self;
    [self presentViewController:peoplePickerController animated:YES completion:nil];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSString *lastname = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
	if(lastname == nil)
	{
		lastname=@"-";
	}
	NSString *firstname = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
	if(firstname == nil)
	{
		firstname=@"-";
	}
	NSString *company = (__bridge NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
	if(company == nil)
	{
		company=@"-";
	}
	NSString *name = [[NSString alloc] initWithFormat:@"%@,\n%@ %@ ",company,firstname, lastname];
	
	personlabel.text=[[NSString alloc]initWithFormat:@"%@",name];
	pperson = [[NSString alloc]initWithFormat:@"%@",name];
		
    ABMutableMultiValueRef addrMulti = ABRecordCopyValue(person, kABPersonAddressProperty);
	aadress = @"-";
	
	//NSString *addressLabel;
	CFDictionaryRef addressDict;
	
	
	
	
	for (CFIndex i = 0; i < ABMultiValueGetCount(addrMulti); i++) 
	{
		
		//addressLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(addrMulti, i));
		addressDict = (CFDictionaryRef)ABMultiValueCopyValueAtIndex(addrMulti, i);
		NSString *streetStr = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressStreetKey);
		NSString *zipStr = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressZIPKey);
		NSString *cityStr = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressCityKey);
		NSString *addrStr = [[NSString alloc] initWithFormat:@"%@,\n%@ %@", streetStr, zipStr, cityStr];
		if(i==0)
		{	
		 aadress = [[NSString alloc] initWithFormat:@"%@",addrStr];
		}
			
	}
	
	CFRelease(addrMulti);
	
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
	CFRelease(addressDict);
	//CFRelease(addressLabel);
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

- (void)dealloc {
}


@end
