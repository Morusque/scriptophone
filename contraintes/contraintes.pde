String currentText = "";

float countdown = 1.0f;

void setup() {
  size(1024, 175);
  
  changeText();
}

void draw() {
  countdown-=0.00009f;
  if (countdown<=0) changeText();
  background(0xFF);
  if (countdown>=0.997f && frameCount%5<2) background(0, 0xFF, 0);
  noStroke();
  fill(0xE0, 0x10, 0xA0);
  rect(0, 0, width*(1-countdown), height);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(50);
  text(currentText, 0, 0, width, height);
}

void changeText() {
  countdown = 1.0f;
  int index = floor(random(34));
  if (index==0) currentText = "Répétez le dernier élément et développez."; 
  if (index==1) currentText = "Obstinez vous."; 
  if (index==2) currentText = "Ralentendo.";
  if (index==3) currentText = "Laissez glisser.";
  if (index==4) currentText = "Décrivez une citrouille";
  if (index==5) currentText = "C'est le drame.";
  if (index==6) currentText = "Stop ou encore?";
  if (index==7) currentText = "Choisissez l'élément le plus faible.";
  if (index==8) currentText = "Prenez la mouche.";
  if (index==9) currentText = "Traduisez en italien.";
  if (index==10) currentText = "Accélérez.";
  if (index==11) currentText = "Encore plus vite.";
  if (index==12) currentText = "Faites une pause.";
  if (index==13) currentText = "Copiez votre voisin.";
  if (index==14) currentText = "Demandez à boire.";
  if (index==15) currentText = "Si c'était une question?";
  if (index==16) currentText = "Déshabillez-vous.";
  if (index==17) currentText = "Changez de sexe.";
  if (index==18) currentText = "Usez de la symétrie.";
  if (index==19) currentText = "Décalez d'un demi-ton.";
  if (index==20) currentText = "Précisez votre pensée.";
  if (index==21) currentText = "La même chose dans dix ans.";
  if (index==22) currentText = "Impressionnismez-vous.";
  if (index==23) currentText = "Jouez votre tube.";
  if (index==24) currentText = "Donnez libre cours à votre intuition la plus mauvaise";
  if (index==25) currentText = "Que ferait votre meilleur ami?";
  if (index==26) currentText = "Abandonnez vos instruments.";
  if (index==27) currentText = "Accentuez les défauts.";
  if (index==28) currentText = "Coupez une connexion vitale.";
  if (index==29) currentText = "Distortion temporelle.";
  if (index==30) currentText = "Prenez des risques.";
  if (index==31) currentText = "Réfléchissez.";
  if (index==32) currentText = "Soyez plus discret.";
  if (index==33) currentText = "Hurlez.";
  if (index==34) currentText = "No frills.";
  if (index==35) currentText = "Hommage explicite.";
}

void keyPressed() {
  countdown-=0.1f;
}
