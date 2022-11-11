
import 'package:diary/pages/terms/widgets/term_card.dart';
import 'package:flutter/material.dart';

import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  SwipeableCardSectionController controller = SwipeableCardSectionController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SwipeableCardsSection(
            cardController: controller,
            context: context,

            items: const [
              TermCard(
                  ruleNumber: "1",
                  ruleText:
                      "Data is stored on your device's memory, nothing is shared on the internet."),
              TermCard(
                  ruleNumber: "2",
                  ruleText:
                      "No one has access on your diary entries except you."),
              TermCard(
                  ruleNumber: "3",
                  ruleText:
                      "Remember, if your anxiety or depression feels unmanageable, it's important to first turn to family, friends, or professionals for help"),
            ],
            //Get card swipe event callbacks
            onCardSwiped: (dir, index, widget) {
              //Add the next card using _cardController
              controller.addItem(widget);

              //Take action on the swiped widget based on the direction of swipe
              //Return false to not animate cards
            },
            //
            enableSwipeUp: true,
            enableSwipeDown: false,
          ),
        ],
      ),
      //other children
    );
  }
}
