import 'package:event_ticket_sale_app_with_clean_arch/core/app/event_ticket_sale_app.dart';
import 'package:event_ticket_sale_app_with_clean_arch/core/consts/colors/colors.dart';
import 'package:event_ticket_sale_app_with_clean_arch/core/locator/service_locator.dart';
import 'package:event_ticket_sale_app_with_clean_arch/core/widgets/custom_appbar.dart';
import 'package:event_ticket_sale_app_with_clean_arch/core/widgets/loading_indicator.dart';
import 'package:event_ticket_sale_app_with_clean_arch/features/home/presentation/logic_holder/home_logic_holder/home_screen_logic_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen(
    this.logicHolder,
    this.eventId,{
    super.key,
  });

  final HomeScreenLogicHolder logicHolder;
  final String eventId;
  @override
  _TicketListScreenState createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {


  @override
  void initState() {
    super.initState();
    widget.logicHolder.getEvents();
    //widget.logicHolder.getEventDetails(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: const Text("All List"),
      ),
      backgroundColor: AppColors.themeColor.withOpacity(0.5),
      body: Observer(
        builder: (_) {
          // return widget.logicHolder.isTicketListLoading
          //   ? SizedBox(
          //       height: MediaQuery.of(context).size.height / 4,
          //       width: MediaQuery.of(context).size.width,
          //       child: const Center(
          //         child: LoadingIndicator(),
          //       ),
          //     )
          //   : 
          return widget.logicHolder.isEventsLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: LoadingIndicator(),
                ),
              )
            : 
            // bu bir liste döndürücü. bunu kullanmak zorunda değilsiniz tabi.
            GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.8,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  // normalde burda bir eventin bütün tarihlerdeki listesini görecek şekilde ayarlamak lazım
                  // onun için de getTicketList vs adında bir usecase ve onun data
                  // ve presentationdaki bağlantılarını yaptıktan sonra burda
                  // widget.logicHolder.ticketList.length şeklinde ayarlarsınız
                  // ben şimdilik göstermelik olarak event listesindeki ilk itemi dönüyorum 
                  itemCount: 1,//widget.logicHolder.events.length,
                  itemBuilder: (context, index) {
                    final event = widget.logicHolder.events[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        color: AppColors.themeColor,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Stack(
                          children: [
                            Image.asset(
                              event.eventImage ?? "assets/events/daftpunk.png",
                              width: size.width,
                              height: size.height / 4,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              left: size.width / 2,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 200,
                                color: AppColors.themeColor,
                                child: Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    event.eventName ?? "No Name",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        }
      ),
    );
  }
}