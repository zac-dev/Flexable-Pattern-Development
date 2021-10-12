#  Flexable Pattern Development Demo

## Not another UI Design pattern! why?
Ok, I get it, there are to many already, but thats kinda the point! This Flexable pattern is more a way of shifting between the other patterns rather than a pattern in and of itself. Idealy as a project gets larger, a team will need to adapt to that complexity by breaking complex code out of basic classes into more dedicated ones. What happens, more often than not, is that a team working together will wait untll the last possible moment, then make a change to the next least complex pattern. When the refactoring is to big to slip unnoticed in a single sprint, the team spend a confused couple of months between two patterns moning about how nothing is the same pattern. Would it not be great to have a way to slide between each pattern as things get more complex? In an ordered and methodical way that alows a team to addapt as it extends its code. If this pattern where recognised by the majority of developers, then defferant parts of an app could be MVC others parts in Viper living happely together untill the complextity of any small section of the application requiers it. This is my attempt at making such a deamy pattern.

## Programming design pattern 101:
MVC (lesson no 1 in architecture: model view controller short for Model domain, view domain, controller domain (note: These are not sward fighting highlanders! No one ever said there should be only one!))
MVVM (when MVC is not enough (mostly because junior devs assume they are Highlanders and there can only be one of each model, view and controller!) )
VIPER (because hand holding is necessary! And developers (Yes I include myself in this!) NEED a name for everything or they cannot make a class to represent it!)

### It all starts with MVC:
Model, View, Controller. It has its problems. The biggest is that developers where never told that MVC is not actually restricted to ONLY JUST ONE view, model and controller per screen! So developers try to cram all their code into one of these THREE classes, this creates huge classes and is called the 'Massive View Controller' problem as the view and model are effectivly keeped dumb!

### Microsoft made MVVM (and we tried to follow!..but failed):
For them (Microsoft and thier C sharp developers) this solved the problem by automating the bindings between view and data in a view model removing the logic out of the view controller to this new class: view model. This works without adding loads of code around binding that data back to the view. However this solution is language and IDE specific. In Xcode with Obj-C / Swift we did not have automatic bindings(until SwiftUI that is), this made MVVM a non viable solution as the custom bindings code was just as much faff as moving the logic out of the view controller into the view model! Making two large classes rather than just one massive one!

### Uncle bob to save the day (VIPER):
If you do not know who uncle bob is (Robert C Martin) please look him up! He coined the phrase SOLID principles with the idea of “Clean Code”. These coding principles gave birth to VIPER as they are based on said principles.
In the future there will probably be more ABC’s in the design patterns world but just more! All of this is solved by breaking down these classes into other classes (of single responsibility ;) but for developers to use these design patterns we need our hands held and given a name for each and every class of responsibility! So we will end with (insert sarcastic look here!) ABCDEFGHIJK……Z pattern in the end!

## What does MVC look like in Objc-C/Swift?


## What does MVVM look like in Objc-C/Swift?
Exactly like MVC but with a class for the view's data and business rules with regards that data (data formatting etc). But basically still MVC if we consider MVC properly as in domains rather than single classes! We basicly devided the viewcontroller into two distint classes one controlling the view the other controlling the model.

## What does VIPER look like in Objc/swift?
Exactly like MVVM but with routers and presenters and interactors further breaking down the monolith of a view controller into singlely responsable classes!
 
Basically MVVM IS (a type of) MVC and VIPER IS (a type of) MVVM AND (a type of) MVC. We can still be MVVM, mostly because the managers that tell developers to only use MVVM would not know the difference and we can still point to models, view models, views and controllers in our code and tell them its MVVM, they are happy we are happy, and at the end of the day that is what matters!
​
​## What does the flexable pattern look like in practice:
Most of the time you will want the following list of classes for a screen called product list use the following:
 
V:
- ProductListViewController (interface for the screen - for properties only has UIView subclasses and a viewModel of which it is the presenter)
- ProductListViewModel (data representation of the screen (all value type properties used by the screen is in the view model) and related business logic, use an instance of Interactor protocol to get models)
 
I:
- ProductSearchInteractor (knows where and how to fetch product search data from network/files/userdefaults/caches/etc…)
- ProductDetailInteractor (knows where and how to fetch product detail data from network/files/userdefaults/caches/etc…)
- ProductListInteractor  (specific interactions can have data formatting rules for a particular feature otherwise the view model formats the data prior to sending it to the view.)
 
P:
- ProductListViewPresenter is an interface protocol representing the view controller from the view model’s point of view.
 
E:
- ProductModel  (raw data value representation of a product)
 
R:
- ProductListCoordinator/ProductListRouter (is responsible for the flow through view controllers, knows how to initialise next view controller and how to display it (push/modal/pop/etc)). It can be just a protocol on ViewController if using segues or in the view model if small feature with one exit point.
