import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/providers/category_provider.dart';
import 'package:shopify/providers/home_provider.dart';
import 'package:shopify/widgets/product.dart';

import '../providers/product_provider.dart';
import '../widgets/carousel_slider_ex.dart';
import '../widgets/headline.widget.dart';
import '../widgets/home/categories_row.home.widget.dart';
import 'master_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bool isLoading = true;
  List productsImages = [
    "assets/images/women_shoes.png",
    "assets/images/backpack.png",
    "assets/images/scarf.png",
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    //getData();
   // HomeProvider().initHomeProvider();
    super.initState();
  }

  // void getData() async {
  //   await DataSeeder.loadData();
  //   setState(() {});
  //   isLoading = false;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const HeadlineWidget(title: 'Categories'),
            Consumer<CategoryProvider>(
              builder: (__, caegoryProvider, _) {
                return FutureBuilder(
                    future: caegoryProvider.getCategories(context, limit: 3),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error While Get Data');
                        } else if (snapshot.hasData) {
                          return CategoriesRowHome(
                            categories: snapshot.data ?? [],
                          );
                        } else {
                          return const Text('No Data Found');
                        }
                      } else {
                        return Text(
                            'Connection Statue ${snapshot.connectionState}');
                      }
                    });
              },
            ), 
            const HeadlineWidget(title: 'Products'),
            const SizedBox(
              height: 10,
            ),

            
            Consumer<ProductProvider>(
              builder: (__, productProvider, _) {
                return FutureBuilder(
                    future: productProvider.getProducts(context, limit: 3),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error While Get Data');
                        } else if (snapshot.hasData) {
                          return FlexibleGridView(
                            axisCount: GridLayoutEnum.threeElementsInRow,
                            shrinkWrap: true,
                            children: snapshot.data
                                    ?.map((e) => ProductWidget(product: e))
                                    .toList() ??
                                [],
                          );
                        } else {
                          return Text('No Data Found');
                        }
                      } else {
                        return Text(
                            'Connection Statue ${snapshot.connectionState}');
                      }
                    });
              },
            ),

            







            //  buildCarouselSliderEx(),
            //=======================================================
           // buildProductGrid(),
          ],
        ),
      ),
    );
  }

  // Widget buildCarouselSliderEx() {
  //   return Consumer<ProductProvider>(builder: (ctx, productProvider, child) {
  //     if (productProvider.products.isEmpty) {
  //       return const Padding(
  //         padding: EdgeInsets.all(15.0),
  //         child: CircularProgressIndicator(),
  //       );
  //     } else {
  //       return CarouselSliderEx(
  //           isForProduct: false,
  //           imageUrls: productProvider.Ads,
  //           onBtnPressed: () {});
  //     }
  //   });
  // }

  // Widget buildProductGrid() {
  //   return Consumer<ProductProvider>(
  //       builder: (context, productProvider, child) {
  //     if (productProvider.products.isEmpty) {
  //       return const Padding(
  //         padding: EdgeInsets.all(15.0),
  //         child: CircularProgressIndicator(),
  //       );
  //     } else {
  //       return Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: GridView.builder(
  //             // scrollDirection: Axis.horizontal,
  //             physics: const NeverScrollableScrollPhysics(), //here
  //             shrinkWrap: true,
  //             itemCount: productProvider.productsNum,
  //             // itemCount: 3,
  //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 3,
  //               mainAxisSpacing: 12,
  //               crossAxisSpacing: 12,
  //               mainAxisExtent: 170,
  //             ),
  //             itemBuilder: (_, index) {
  //               return GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (_) => const MasterProductPage()));
  //                 },
  //                 child: Container(
  //                   padding: const EdgeInsets.all(10),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(16),
  //                     color: Colors.white,
  //                   ),
  //                   child: Column(
  //                     children: [
  //                       Image.asset(
  //                         productsImages[index],
  //                         width: 100,
  //                         height: 100,
  //                         fit: BoxFit.cover,
  //                       ),
  //                       const SizedBox(
  //                         height: 10,
  //                       ),
  //                       Align(
  //                         alignment: Alignment.topLeft,
  //                         child: Column(
  //                           children: [
  //                             //  Text("Ankle Boots",style: TextStyle(fontSize:12,fontWeight: FontWeight.w300,color:Color(0xff515C6F) ),
  //                             Text(
  //                               productProvider.products[index].name.toString(),
  //                               style: const TextStyle(
  //                                   fontSize: 12,
  //                                   fontWeight: FontWeight.w300,
  //                                   color: Color(0xff515C6F)),
  //                             ),
  //                             const SizedBox(
  //                               height: 5,
  //                             ),
  //                             //Text("\$49.99",style: TextStyle(fontSize:10,fontWeight: FontWeight.bold,color:Color(0xff515C6F)
  //                             Text(
  //                               "\$${productProvider.products[index].price}",
  //                               style: const TextStyle(
  //                                   fontSize: 10,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Color(0xff515C6F)),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             }),
  //       );
  //     }
  //   });
  // }
}
