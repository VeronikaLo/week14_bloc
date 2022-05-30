import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week14_bloc/bloc/bloc_cart.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
      create: (_) => ProdBloc() ,
      child: Scaffold(
            appBar: AppBar(
              title: const Text('Shopping App', ),centerTitle: true,
              actions: <Widget>[
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: TextButton.icon(
                        style: TextButton.styleFrom(primary: Colors.white),
                        onPressed: () {
                        },
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text(''),
                        key: const Key('cart'),
                      ),
                    ),

                    BlocConsumer<ProdBloc, ProdState>(
                        listenWhen: (ProdState previous, ProdState current) {
                              if (current.isClicked == true) {
                                    return true;
                              } else {
                                    return false;
                                }
                                  } ,
                        listener:(context, ProdState state) {
                              final snackBar = SnackBar(content: Text(state.eventMsg), duration: const Duration(seconds: 1),);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  } ,
                        builder:(context, ProdState state){
                              return Positioned(
                        left: 30,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green),
                          child:  Text(
                            (state.cartValue.toString()),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                        } ,)
                    
                    ,
                  ],
                ),
              ],
            ),
            body:   const ProductList(),
          ),
    );
  }
}




class ProductList extends StatelessWidget {
  const ProductList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (BuildContext context, int index){
        return BlocBuilder<ProdBloc, ProdState>(
          builder: (context, ProdState state){
            return  ListTile(
          leading: Icon(Icons.flourescent_rounded, color: Colors.primaries[index% Colors.primaries.length],),
          title: Text('Product ${index+1}') ,
          trailing: GestureDetector(
            child: (state.inCart)[index]
              ? const Icon(Icons.shopping_cart, color: Colors.green,) 
              : const Icon(Icons.shopping_cart_outlined),
            onTap: (){ 
              
              if((state.inCart)[index]){
                context.read<ProdBloc>().add(RemoveProduct(index: index));
              }else{
                context.read<ProdBloc>().add(AddProduct(index: index));
              }
            
            },) ,
        );
          },);
      });
  } 
}