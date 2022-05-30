import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc Events:

class ProdEvent{}  //general class

class AddProduct extends ProdEvent{
  int index;

  AddProduct({required this.index});
}

class RemoveProduct extends ProdEvent{
  int index;

  RemoveProduct({required this.index});

}
//  Create list for a cart:
final List<dynamic> newList = List<bool>.filled(15, false);

// Bloc State:  --> what we have in a State

class ProdState{

  final int cartValue;   // counter in a cart AppBar
  final String eventMsg;  // Text in scaffoldMessanger
  final bool isClicked;   //  switcher for a toggle modus
  final List<dynamic> inCart; // Product in a cart or not
  

  ProdState({
    required this.cartValue,
    this.eventMsg = "",
    this.isClicked = false,
    inCart , 
  }) : inCart = inCart?? newList ;

}


//Bloc

class ProdBloc extends Bloc<ProdEvent, ProdState>{

ProdBloc():super(ProdState(cartValue: 0,)){

  on<AddProduct>((AddProduct event, Emitter<ProdState> emitter){
    
    //   ->Product in a cart 
    List<dynamic> list= state.inCart;
    list[event.index] = true;

    return emitter(ProdState(
      inCart: list ,
      cartValue: state.cartValue +1,
      eventMsg: "Product is added to cart",
      isClicked: true,
      ));
  });


  on<RemoveProduct>((RemoveProduct event, Emitter<ProdState> emitter){

    // -> Product not in a cart
    List<dynamic> list= state.inCart;
    list[event.index] = false;

    return emitter(ProdState(
      inCart: list,
      cartValue: state.cartValue -1,
      eventMsg: "Product is removed from cart",
      isClicked: true,
      ));
  });




}

}


