import 'package:flutter/material.dart';


class RulesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RulesPageState();
  }
}

class _RulesPageState extends State<RulesPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text("Rules"),
        centerTitle: true,
        backgroundColor: Color(0xff1985A1),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('images/dyeislifetext.png',height: 100),
          Text('The Set-Up', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          Text("•To play Water Die, you will need a 4’ by 8’ long wood table with a dividing line going through the middle (vertically). It needs to be roughly 3 ½' off the ground"),
          Text("•4 Pint size glasses placed finger (or hands) lengths distance from each corner"),
          Text("•2 Dice"),
          Text("•4 Players"),
          Text("•Beverage of choice"),
          Text("•Each player before the game starts must fill one full drink in their cup"), 
          Text('•And lastly before you begin playing you want to set a height boundary - this is how high the die must be tossed on every toss'),
          Text(''),
          Text('The Game', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          Text('First Toss:', style: TextStyle(fontSize: 20)),
          Text('•To decide which team tosses first, one person rolls a die and the other team calls high or low. If the die is a 4, 5, or 6 that is high. If the die is a 1, 2, or 3 that is low. If they called it right, they are awarded first toss.'),
          Text(''),
          Text('To Win:', style: TextStyle(fontSize: 20)),
          Text('•Games are played up to 9 or 11 points. If the game is played to 9, a drink is killed and filled every 3 points, if it is played to 11, a water is killed and filled for every 4 points scored. Games are also always won by 2.'),
          Text('•How to Score a Point:'),
          Text("•To score a point the die must be tossed above the discussed height and bounce off any part of the opponent's side of the table, if the die is not caught after the die bounces off the table it's a point. One person tosses at a time per team."),
          Text("•A die can bounce anywhere after it hits the defending teams side, it could even bounce back towards the side from whence it was tossed. As long as it connects with the defending half of table and falls to the ground, it is a point. To prevent a point, a defensive player must catch the die with ONE hand before it hits the ground. If the player uses both hands to catch a die it is a point for the offensive team."),
          Text("•Once one die is thrown and either caught or dropped and the defending team is ready, the next die is tossed. When die is tossed too low and it only takes one person from the defending team to call height, which generally speaking is a pretty obvious call."),
          Text("•If the die lands short (on the tossing teams side of the table) or on the dividing line it is dead and goes to the opposing team. If there is a heated dispute on whether the die landed short or not, it is a re-toss."),
          Text("•If the die is trapped (i.e. movement of the die is halted by applying pressure with hand or other body part) against the body or any other surrounding object, then it is a point for the tossing team."),
          Text("•Catching a die over the table is only allowed if the die has either hit the offensive players side and is a dead die or it has hit the defensive side and goes off the table and is popped back over the table via a bobble but does not touch the table. If the die falls off the table, is bobbled, and touches any part of the table again, it is a point for the offensive team."),
          Text("•A die that hits the defending sides cup and falls off the table without being caught it 2 points."),
          Text("•A sink is awarded 3 points and the defending team must kill and fill their drink regardless of the score. A sink can be a direct shot into the cup or a bounce in. The team sunk on now has 3 or 4 points to go (depending on if they play to 9 or 11) before they must kill and fill again."),
          Text(''),
          Text("FIFA's:", style: TextStyle(fontSize: 20)),
          Text('•If both teams decide to play FIFA then any toss from the offensive team that misses the table can be kicked up by one of the defensive players and caught by the adjacent defensive player for a point. They also get to keep the die for the ensuing offensive turn. Game cannot be won off a FIFA.'),
          Text("•The die may be kicked by the defending player twice! Dyeislife DOES NOT condone the use of knees for Fifa's."),
          Text("•When a defending player kicks a die, by doing so, he/she is keeping the die alive and in play. A Fifa is performed by using the foot or head, a player is (at most) allowed to kick the die twice in total. Whether that is once by the original Fifa'er and once by the partner (to himself) or twice by the original Fifa'er to his partner. The die cannot be caught by the original Fifa'er. "),
          Text(''),
          Text("SCORING FIFA's:", style: TextStyle(fontSize: 20)),
          Text("•If the die is Fifa'd and caught by the other defending player it is a point for their team."),
          Text("ALTERNATE RULE: no points, but the other team losses a player to defend for one turn."),
          Text("•If the die is Fifa'd and lands on the defending tables side, and then falls off the table without being caught, it is a point for the offensive team. The die was put back in play."),
          Text("•If the die is Fifa'd and hits the defending sides cup then hits the ground it is 2 points (if you play tinks, 1 point if you don't). Again, in this scenario, the die was put back in play."),
          Text("•If the die is Fifa'd and lands in the defending sides cup it counts as a sink (2 points if you do not play tinks, 3 if you do) and it is a kill & fill."),
          Text("•If the die is Fifa'd and hits the offensives sides table or cup. No points are awarded, however if the offensive side cup is SUNK. That will be awarded 2 points for the Fifa'ers team and a kill n fill for the offensive side."),
          Text(''),
          Text("Other Rules:", style: TextStyle(fontSize: 20)),
          Text("•Bobbles: if both teams decide to play bobbles then the defending team cannot bobble the die at all or bobble it on purpose depending on how you want to play. If the die is bobbled and not caught cleanly then it is a point for the tossing team"),
          Text("•Extreme bobbles: if both teams elect to play extreme bobbles then a defensive player who bobbles a die can be blasted off their feet by an offensive player to prevent them from catching a die"),
          Text("•Picks: if both teams agree to picks, then you are allowed to set a pick at the cups (not at the mid-line). You cannot shoulder into or move into the defending player in any way. Doing so will result in no points. "),
          Text("•Spitting 5 After a Sink: if both team agree to the spit 5’s rule then after a sink. The player either swallows and spits a die out onto the table or just roles it out of the cup. If that player spits (or rolls) a 5 then he must shotgun a water or chug a drink out of his glass"),
          Text("•Naked Lap (Naked Mile) or Pizza: if a team is skunked (losses 9 to 0 or 11 to 0) then they must run around the block completely naked. They can elect to do this or buy the winning team a pizza. If you sink your own cup, depending on the house rules, you must either run a naked lap and give the other team 2 points or run a naked lap and you automatically lose the game. There is no option to buy the opposing team a pizza."),
          Text(''),
          Text("Rare Circumstances:", style: TextStyle(fontSize: 20)),
          Text("•Bounce out sink and caught: if the offensive team sinks a plastic cup and it bounces out it is automatically a sink, no matter if it is caught, lands on the table, or on the ground. If the cup is glass (regulation) and the die bounces out, the defense is allowed to make a play on the die but ONLY WHEN IT COMES OFF THE TABLE. "),
          Text("•Bounce on tossing teams side but sinks the defending teams cup: no points are awarded, but the player sunk on must kill and fill"),
        ]
      )
    );
  }
}


