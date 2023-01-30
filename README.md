#  CombineDemo

## Overview
>This is a simple Movies app that displays list of movies, The whole idea of this App is to show how you can integrate Combine framework into your App easily. By applying Combine to your App you will get the benefit of leverage the unified high-level API introduced by Apple.

## Used Architecture
>This project is implemented by applying MVVM along side Clean Architecture coined by uncle bob.
>The Model-View-ViewModel pattern (MVVM) provides a clean separation of concerns between the UI and Domain.

## MVVM Benefits
* **Expressive:** The view model better expresses the business logic for the view.
* **Reduced Complexity**: MVVM makes the view controller simpler by moving a lot of business logic out of it.
* **Testability**: A view model is much easier to test than a view controller. You end up testing business logic without having to worry about view implementations.
* **Shared**: The view model can be shared across multiple views because it does not hold reference on the view.

## Layers
* **Domain Layer** = Entities + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + API (Network) + Persistence 
* **Presentation Layer (MVVM)** = ViewModels + Views

## Used Stack
* **Combine**
* **UIKit**

