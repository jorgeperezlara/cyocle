import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';

const Set<String> _kIDsConsumable = {
  'donation099',
  'donation199',
  'donation399'
}; //consumables may be purchased several times if needed.
enum ErrorType { notAvailable, responseError, streamError, notFoundIDs }
enum DonationType { none, donation099, donation199, donation399 }

class StoreEngine {
  List<ProductDetails> products;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  bool donationUser = false;
  //We must initialize the plugin.
  void initializePlugin() {
    InAppPurchaseConnection.enablePendingPurchase;
  }

  void disposePlugin() {
    _subscription.cancel();
  }

  void grabPurchases() async {
    //Check the connection is available.
    final bool available = await InAppPurchaseConnection.instance.isAvailable();
    if (!available) {
      showErrorDialog(ErrorType.notAvailable);
      return;
    }
    QueryPurchaseDetailsResponse response =
        await InAppPurchaseConnection.instance.queryPastPurchases();
    if (response.error != null) {
      showErrorDialog(ErrorType.responseError);
    } else {
      for (PurchaseDetails purchase in response.pastPurchases) {
        //If the donation is contained in the Set of products, we will set donationUser = true.
        donationUser = _kIDsConsumable.contains(purchase.productID);
        //We confirm the App Store (only needed for iOS) the purchase has been delivered to the user.
        Platform.isIOS
            ? InAppPurchaseConnection.instance.completePurchase(purchase)
            : null;
      }
    }
  }

  Future<void> loadIAPsForSale() async {
    final bool available = await InAppPurchaseConnection.instance.isAvailable();
    if (!available) {
      showErrorDialog(ErrorType.notAvailable);
      return;
    }
    final ProductDetailsResponse response = await InAppPurchaseConnection
        .instance
        .queryProductDetails(_kIDsConsumable);
    response.notFoundIDs.isNotEmpty
        ? showErrorDialog(ErrorType.notFoundIDs)
        : null;
    products = response.productDetails;
  }

  void loadPurchaseStream() {
    final Stream<List<PurchaseDetails>> purchasesUpdatesStream =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchasesUpdatesStream.listen((event) {
      handlePurchaseUpdates(event);
    }, onDone: () {
      _subscription
          .cancel(); //once we've finished grabbing the data from the stream, just close it.
    }, onError: (error) {
      showErrorDialog(ErrorType.streamError);
    });
  }

  //What to do when there's an update in the Stream.
  void handlePurchaseUpdates(List<PurchaseDetails> purchasesList) {
    for (var purchase in purchasesList) {
      donationUser = _kIDsConsumable.contains(purchase.productID);
      InAppPurchaseConnection.instance.completePurchase(purchase);
    }
  }

  void showErrorDialog(ErrorType type) {
    //TODO: Mostrar un diálogo que informe de esto para que el usuario sepa si hay problemas con las compras.
    switch (type) {
      case ErrorType.notAvailable:
        print(
            'Could not access the purchase history. You\'ll be reverted to back to normal user. Purchases cannot be performed.');
        break;
      case ErrorType.responseError:
        print(
            'Could not access the purchase history. You\'ll be reverted to back to normal user.');
        break;
      case ErrorType.streamError:
        print(
            'Stream error. Check your internet connection or try it again later');
        break;
      case ErrorType.notFoundIDs:
        print('Sorry, we couldn\'t find the product chosen');
        break;
      default:
        print(
            'Unknown error'); //we add this possibility just in case we need it.
    }
  }

  Future<void> performDonation(DonationType donation) async {
    print('the donation ${donation} will be performed');
    await loadIAPsForSale(); //we load the inapp purchases.
    for (var product in products) {
      String productID = 'DonationType.${product.id}';
      //we go through the list of products available for purchase
      if (productID == donation.toString()) {
        //if the product is the one we specify, set the parameter to it.
        PurchaseParam purchaseParameter =
            PurchaseParam(productDetails: product);
        if (_kIDsConsumable.contains(donation.toString())) {
          //if it's consumable, purchase it as consumable.
          InAppPurchaseConnection.instance
              .buyConsumable(purchaseParam: purchaseParameter);
        } else {
          //if it's not, purchase as Non consumable
          InAppPurchaseConnection.instance
              .buyNonConsumable(purchaseParam: purchaseParameter);
        }
      }
      else{
        print('no product found!: not a match for $productID in ${donation.toString()}');
      }
    }
  }
}
