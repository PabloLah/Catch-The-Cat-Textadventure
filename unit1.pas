unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, ExtCtrls, mTOrt, LazUTF8;
type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonMinispiel1: TButton;
    ButtonMinispiel2: TButton;
    ButtonMinispiel3: TButton;
    ButtonMinispiel4: TButton;
    ButtonMinispiel5: TButton;
    ButtonMinispiel6: TButton;
    ButtonMinispiel7: TButton;
    ButtonMinispiel8: TButton;
    ButtonTutorial2: TButton;
    ButtonStory: TButton;
    ButtonTutorial: TButton;
    ButtonMinispiel: TButton;
    ButtonTipp: TButton;
    ButtonObjekt1: TButton;
    ButtonObjekt2: TButton;
    ButtonObjekt3: TButton;
    ButtonOben: TButton;
    ButtonUnten: TButton;
    ButtonSueden: TButton;
    ButtonGo: TButton;
    ButtonNorden: TButton;
    ButtonOsten: TButton;
    ButtonWesten: TButton;
    AbstellkammerBild: TImage;
    BadBild: TImage;
    Bad1Bild: TImage;
    GaestebadBild: TImage;
    BalkonBild: TImage;
    BueroBild: TImage;
    EingangsbereichBild: TImage;
    Flur1OGBild: TImage;
    Flur2OGBild: TImage;
    FlurUGBild: TImage;
    GartenBild: TImage;
    GaestezimmerBild: TImage;
    HaustuerBild: TImage;
    Hausaussen: TImage;
    LabelGewonnen: TLabel;
    LabelEnde1: TLabel;
    LabelEnde2: TLabel;
    VerlorenLabel2: TLabel;
    EndeBild: TImage;
    VerlorenLabel1: TLabel;
    TreppeOG2Bild: TImage;
    LabelTitel: TLabel;
    Memo1: TMemo;
    WohnzimmerBild: TImage;
    WaschraumBild: TImage;
    VorplatzBild: TImage;
    TreppeUGBild: TImage;
    TreppeGeheimBild: TImage;
    TreppeEGBild: TImage;
    Treppe1OGBild: TImage;
    SpielraumBild: TImage;
    Schlafzimmer2Bild: TImage;
    KuecheBild: TImage;
    Schlafzimmer1Bild: TImage;


    procedure ButtonMinispiel1Click(Sender: TObject);
    procedure ButtonMinispiel2Click(Sender: TObject);
    procedure ButtonMinispiel3Click(Sender: TObject);
    procedure ButtonMinispiel4Click(Sender: TObject);
    procedure ButtonMinispiel5Click(Sender: TObject);
    procedure ButtonMinispiel6Click(Sender: TObject);
    procedure ButtonMinispiel7Click(Sender: TObject);
    procedure ButtonMinispiel8Click(Sender: TObject);
    procedure ButtonMinispielClick(Sender: TObject);
    procedure ButtonNordenClick(Sender: TObject);
    procedure ButtonObenClick(Sender: TObject);
    procedure ButtonObjekt1Click(Sender: TObject);
    procedure ButtonObjekt2Click(Sender: TObject);
    procedure ButtonObjekt3Click(Sender: TObject);
    procedure ButtonOstenClick(Sender: TObject);
    procedure ButtonStoryClick(Sender: TObject);
    procedure ButtonSuedenClick(Sender: TObject);
    procedure ButtonGoClick(Sender: TObject);
    procedure ButtonTippClick(Sender: TObject);
    procedure ButtonTutorial2Click(Sender: TObject);
    procedure ButtonTutorialClick(Sender: TObject);
    procedure ButtonUntenClick(Sender: TObject);
    procedure ButtonWestenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;
  aktuellerOrt: TOrt; //Ort, in dem sich der Spieler befindet
  OrtNachbar: TOrt;   //Ort, in dem sich der Nachbar befindet
  Ortzufaellig: Array [1..6] of TOrt;   //Räume in dem sich der Nachbar befinden kann; Zufälliges Zuordnen von OrtNachbar
  //Räume Keller
  TreppeUG:TOrt;
  Spielraum:TOrt;
  Waschraum:TOrt;
  Abstellkammer:TOrt;
  FlurUG:TOrt;
  GeheimeTreppe:TOrt;
  Freiheit: TOrt;
  //Räume Erdgeschoss
  TreppeEG: TOrt;
  Vorplatz: TOrt;
  Haustuer: TOrt;
  Eingangsbereich: TOrt;
  Bad: TOrt;
  Kueche: TOrt;
  Wohnzimmer: TOrt;
  Garten:TOrt;
  //Räume OG1
  TreppeOG1: TOrt;
  Flur1: TOrt;
  Schlafzimmer1: TOrt;
  Schlafzimmer2: TOrt;
  Bad1: TOrt;
  Balkon: TOrt;
  //Räume OG2
  TreppeOG2: TOrt;
  Flur2: TOrt;
  Buero: TOrt;
  Gaestezimmer: TOrt;
  Gaestebad: TOrt;

  //Sonstiges: Variablen, die Informationen zum aktuellem Spielfortschritt geben
  schonBesucht_Haustuer: boolean =false;
  schonBesucht_Balkon: boolean =true;
  schonBesucht_Garten: Boolean =true;
  schonBesucht_Buero: Boolean =true;
  NachbarImHaus: Boolean=false;
  OrtmitObjekt: integer=0;
  Minispiel: integer= 0;
  GeheimTreppeFreigeschaltet:Boolean=false;
  TutorialAN: boolean =false;
  TippAN: boolean = false;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

  //Caption für Beginn des Spiels
  memo1.text:= 'Herzlich Willkommen zu "Catch The Cat"! Wir wünschen Dir viel Spaß!';
  memo1.Lines.add('Von Pablo und Paula');

//Sichtbarkeiten der einzelnen Buttons, Labels und Memos am Anfang des Spiels
  ButtonNorden.visible:=false;
  ButtonOsten.visible:=false;
  ButtonSueden.visible:=false;
  ButtonWesten.visible:=false;
  ButtonOben.visible:=false;
  ButtonUnten.visible:=false;
  ButtonObjekt1.visible:=false;
  ButtonObjekt2.visible:=false;
  ButtonObjekt3.visible:=false;
  ButtonGo.visible := true;
  ButtonStory.visible:= true;
  ButtonTutorial.visible:=true;
  memo1.visible := true;
  ButtonMinispiel.visible := false;
  ButtonTipp.visible := false;
  ButtonTutorial2.visible := false;

  EndeBild.visible := false;
  VerlorenLabel1.visible := false;
  VerlorenLabel2.visible := false;

  LabelEnde1.visible := false;
  LabelEnde2.visible := false;
  ButtonMinispiel1.visible := false;
  ButtonMinispiel2.visible := false;
  ButtonMinispiel3.visible := false;
  ButtonMinispiel4.visible := false;
  ButtonMinispiel5.visible := false;
  ButtonMinispiel6.visible := false;
  ButtonMinispiel7.visible := false;
  ButtonMinispiel8.visible := false;

  LabelGewonnen.visible := false;





//Die verschiedenen Räume des Hauses erstellen

  //Der Ort, an welchem sich der Spieler befindet
  aktuellerOrt:= TOrt.create;

  //Erstellen der Orte in denen sich der böse Nachbar bewegt, um sie dann zufällig auswählen lassen zu können (daher wird ein Array verwendet)
  Ortzufaellig[1]:=TOrt.create;
  Ortzufaellig[2]:=TOrt.create;
  Ortzufaellig[3]:=TOrt.create;
  Ortzufaellig[4]:=TOrt.create;
  Ortzufaellig[5]:=TOrt.create;
  Ortzufaellig[6]:=TOrt.create;
  //Räume Keller
  TreppeUG:= TOrt.create;
  Spielraum:= TOrt.create;
  Waschraum:= TOrt.create;
  Abstellkammer:= TOrt.create;
  FlurUG:= TOrt.create;
  GeheimeTreppe:=TOrt.create;
  Freiheit := TOrt.create;
  //Räume Erdgeschoss
  TreppeEG:= TOrt.create;
  Vorplatz:= TOrt.create;
  Haustuer:= TOrt.create;
  Eingangsbereich:= TOrt.create;
  Bad:= TOrt.create;
  Kueche:= TOrt.create;
  Wohnzimmer:= TOrt.create;
  Garten:= TOrt.create;
  //Räume OG1
  TreppeOG1:= TOrt.create;
  Flur1:= TOrt.create;
  Schlafzimmer1:= TOrt.create;
  Schlafzimmer2:= TOrt.create;
  Bad1:= TOrt.create;
  Balkon:= TOrt.create;
  //Räume OG2
  TreppeOG2:= TOrt.create;
  Flur2:= TOrt.create;
  Buero:= TOrt.create;
  Gaestezimmer:= TOrt.create;
  Gaestebad:= TOrt.create;


  //Zuweisung der Attribute

  //Räume Keller
  TreppeUG.setOrt(nil, nil, nil, FlurUG, TreppeEG, nil,'Du befindest dich jetzt im Untergeschoss. Genauer gesagt an der Treppe im Untergeschoss.');
  Spielraum.setOrt(FlurUG, nil, nil, nil, nil, nil, 'Hier liegen ganz viele Spielsachen auf dem Boden. Wie es scheint bist du im Spielraum.');
  Waschraum.SetOrt(nil, FlurUG, nil, nil, nil, nil, 'Wäsche, Wäsche, Wäsche. Du bist im Waschraum.');
  Abstellkammer.setOrt(nil, nil, FlurUG, nil, nil, nil, 'Du bekommst gerade so noch die Tür auf. Da war wohl direkt hinter der Tür eine Kiste. Dir ist direkt klar, dass es sich hier nur um die Abstellkammer handeln kann.');
  FlurUG.setOrt(Abstellkammer, TreppeUG, Spielraum, Waschraum, nil, nil, 'Du bist im Flur des Untergeschosses.');


  //Räume Erdgeschoss
  Garten.SetOrt(nil, nil, Wohnzimmer, nil, nil, nil, 'Lauter Gartenzwerge! Du bist im Garten.');
  Vorplatz.SetOrt(Haustuer, nil, nil, nil, nil, nil,'Von dem Vorplatz aus sieht das Haus des Nachbarn sehr groß und gruselig aus. Das passt zu ihm. Du willst aber deine Katze finden, also musst du in das Haus gehen.');
  Haustuer.SetOrt(nil, nil, Vorplatz, nil, nil, nil, 'Du bist jetzt an der Haustür. Du versuchst sie zu öffnen, aber merkst, dass sie verschlossen ist. Finde den Schlüssel, um ins Haus zu gelangen.');
  Eingangsbereich.SetOrt(Wohnzimmer, TreppeEG, Haustuer, Bad, nil, nil, 'WOW du hast dir den Eingangsbereich ganz anders vorgestellt. Schau dich um und versuche deine Katze zu finden.');
  Bad.SetOrt(nil, Eingangsbereich, nil, nil, nil, nil, 'Anscheinend ist hier ein Bad.');
  Kueche.SetOrt(nil, Wohnzimmer, nil, nil, nil, nil, 'Hmmm... hier riecht es aber lecker. Du befindest dich in der Küche');
  Wohnzimmer.SetOrt(Garten, nil, Eingangsbereich, Kueche, nil, nil, 'Hier sieht es gemütlich aus. Vor allem am Kamin. Du wünscht dir, dass du auch so ein gemütliches Wohnzimmer hättest.');
  TreppeEG.SetOrt(nil, nil, nil, Eingangsbereich, TreppeOG1, TreppeUG, 'Hier ist die Treppe des Erdgeschosses.');
  Freiheit.SetOrt(nil,nil,nil,nil,nil,nil,'Freiheit');


  //Räume Obergeschoss 1
  TreppeOG1.SetOrt(nil, nil, nil, Flur1, TreppeOG2, TreppeEG, 'Hier ist die Treppe im ersten Obergeschoss.');
  Flur1.SetOrt(Schlafzimmer1, TreppeOG1, nil, Schlafzimmer2, nil, nil, 'Du befindest dich im Flur des ersten Obegeschosses.');
  Schlafzimmer1.SetOrt(nil, nil, Flur1, Bad1, nil, nil, 'Süß! Die Einrichtung des Kinderzimmers passt gar nicht zu deinem Nachbarn.');
  Schlafzimmer2.SetOrt(Bad1, Flur1, nil, Balkon, nil, nil, 'Hier ist das Schlafzimmer der Eltern. Jetzt weißt du auch, wer in der Nachbarschaft immer Klavier spielt.');
  Bad1.SetOrt(nil, Schlafzimmer1, Schlafzimmer2, nil, nil, nil, 'Hier ist das Bad.');
  Balkon.SetOrt(nil, Schlafzimmer2, nil, nil, nil, nil, 'Herrlich. Dieser Ausblick von dem Balkon!');


  //Räume Obergeschoss 2
  TreppeOG2.SetOrt(nil, nil, nil, Flur2, nil, TreppeOG1,'Hier ist die Treppe des zweiten Obergeschosses');
  Flur2.SetOrt(Gaestezimmer, TreppeOG2, Buero, nil, nil, nil, 'Der Flur im zweiten Obergeschoss gefällt dir am besten.');
  Gaestezimmer.SetOrt(nil, nil, Flur2, Gaestebad, nil, nil, 'Noch ein Schlafzimmer? Das muss das Gästezimmer sein.');
  Gaestebad.SetOrt(nil, Gaestezimmer, nil, nil, nil, nil, 'So ein großes Gästebad!');
  Buero.SetOrt(Flur2, nil, nil, nil, nil, nil, 'Papierkram und Ordner? Das muss das Büro des Nachbarn sein.');


  //Zuweisung der Räume in denen sich der Nachbar bewegt
  Ortzufaellig[1]:=Eingangsbereich;
  Ortzufaellig[2]:=Bad;
  Ortzufaellig[3]:=Kueche;
  Ortzufaellig[4]:=Wohnzimmer;
  Ortzufaellig[5]:=Garten;
  Ortzufaellig[6]:=TreppeEG;



  //Objektbuttons verstecken (Zusätzliche Aktionen innerhalb eines Raumes)
         ButtonObjekt1.visible:=false;
         ButtonObjekt2.visible:=false;
         ButtonObjekt3.Visible:=false;


         //Abfrage, welches Bild gezeigt werden soll
  if aktuellerOrt = Abstellkammer then AbstellkammerBild.visible := true else AbstellkammerBild.visible := false;
  if aktuellerOrt = Bad then BadBild.visible := true else BadBild.visible := false;
  if aktuellerOrt = Bad1 then Bad1Bild.visible := true else Bad1Bild.visible := false;
  if aktuellerOrt = Gaestebad then GaestebadBild.visible := true else GaestebadBild.visible := false;
  if aktuellerOrt = Balkon then BalkonBild.visible := true else BalkonBild.visible := false;
  if aktuellerOrt = Buero then BueroBild.visible := true else BueroBild.visible := false;
  if aktuellerOrt = Eingangsbereich then EingangsbereichBild.visible := true else EingangsbereichBild.visible := false;
  if aktuellerOrt = Flur1 then Flur1OGBild.visible := true else Flur1OGBild.visible := false;
  if aktuellerOrt = Flur2 then Flur2OGBild.visible := true else Flur2OGBild.visible := false;
  if aktuellerOrt = FlurUG then FlurUGBild.visible := true else FlurUGBild.visible := false;
  if aktuellerOrt = Garten then GartenBild.visible := true else GartenBild.visible := false;
  if aktuellerOrt = Gaestezimmer then GaestezimmerBild.visible := true else GaestezimmerBild.visible := false;
  if aktuellerOrt = Haustuer then HaustuerBild.visible := true else HaustuerBild.visible := false;
  if aktuellerOrt = Schlafzimmer1 then Schlafzimmer1Bild.visible := true else Schlafzimmer1Bild.visible := false;
  if aktuellerOrt = Kueche then KuecheBild.visible := true else KuecheBild.visible := false;
  if aktuellerOrt = Schlafzimmer2 then Schlafzimmer2Bild.visible := true else Schlafzimmer2Bild.visible := false;
  if aktuellerOrt = Spielraum then SpielraumBild.visible := true else SpielraumBild.visible := false;
  if aktuellerOrt = TreppeOG1 then Treppe1OGBild.visible := true else Treppe1OGBild.visible := false;
  if aktuellerOrt = TreppeEG then TreppeEGBild.visible := true else TreppeEGBild.visible := false;
  if aktuellerOrt = GeheimeTreppe then TreppeGeheimBild.visible := true else TreppeGeheimBild.visible := false;
  if aktuellerOrt = TreppeUG then TreppeUGBild.visible := true else TreppeUGBild.visible := false;
  if aktuellerOrt = Vorplatz then VorplatzBild.visible := true else VorplatzBild.visible := false;
  if aktuellerOrt = Waschraum then WaschraumBild.visible := true else WaschraumBild.visible := false;
  if aktuellerOrt = Wohnzimmer then WohnzimmerBild.visible := true else WohnzimmerBild.visible := false;
  if aktuellerOrt = TreppeOG2 then TreppeOG2Bild.visible := true else TreppeOG2Bild.visible := false;
end;

procedure TForm1.ButtonGoClick(Sender: TObject);
begin

  //Sichtbarkeit der Buttons
  ButtonGo.visible := false;
  ButtonStory.visible:= false;
  ButtonTutorial.visible:=false;
  Hausaussen.visible := false;
  labelTitel.Visible := false;
  ButtonTipp.visible := true;
  ButtonTutorial2.visible:= true;


  //Anfangssituation des Spielers festlegen
  aktuellerOrt:= Vorplatz;

  //Prüfen in welche Richtungen sich der Spieler bewegen kann. Die Buttons für die Bewegungsmöglichkeiten werden anschließend sichtbar gemacht.
  if aktuellerOrt.Getnorden <>nil
     then buttonNorden.visible:=true
     else buttonNorden.visible:=false;

  if aktuellerOrt.GetOsten <>nil
     then buttonOsten.visible:=true
     else buttonOsten.visible:=false;

  if aktuellerOrt.GetSueden <>nil
     then buttonSueden.visible:=true
     else buttonSueden.visible:=false;

  if aktuellerOrt.GetWesten <>nil
     then buttonWesten.visible:=true
     else buttonWesten.visible:=false;

  if aktuellerOrt.GetOben <>nil
     then buttonOben.visible:=true
     else buttonOben.visible:=false;

  if aktuellerOrt.GetUnten <>nil
     then buttonUnten.visible:=true
     else buttonUnten.visible:=false;
  // Beschreibung des aktuellen Ort anzeigen
  memo1.text:= aktuellerOrt.getBeschreibung;

  //Bild nach Start Button
  if aktuellerOrt = Vorplatz then VorplatzBild.visible := true else VorplatzBild.visible := false;

end;




procedure TForm1.ButtonNordenClick(Sender: TObject);
begin
  //Die Buttons für die Objekte unsichtbar machen
         ButtonObjekt1.visible:=false;
         ButtonObjekt2.visible:=false;
         ButtonObjekt3.Visible:=false;

  //einen Ort weiter gehen und Sichtbarkeit der Richtungen einstellen
  aktuellerOrt:= aktuellerOrt.GetNorden;

  if aktuellerOrt.GetNorden <>nil
     then buttonNorden.visible:=true
     else buttonNorden.visible:=false;

  if aktuellerOrt.GetOsten <>nil
     then buttonOsten.visible:=true
     else buttonOsten.visible:=false;

  if aktuellerOrt.GetSueden <>nil
     then buttonSueden.visible:=true
     else buttonSueden.visible:=false;

  if aktuellerOrt.GetWesten <>nil
     then buttonWesten.visible:=true
     else buttonWesten.visible:=false;

  if aktuellerOrt.GetOben <>nil
     then buttonOben.visible:=true
     else buttonOben.visible:=false;

  if aktuellerOrt.GetUnten <>nil
     then buttonUnten.visible:=true
     else buttonUnten.visible:=false;
  //Beschreibung des aktuellen Ortes angezeigt
  memo1.text:= aktuellerOrt.GetBeschreibung;

  //Procedure: Katze ist nicht mehr im Garten
  if aktuellerOrt=Garten
   then if schonBesucht_Garten=false
        then
            begin
            schonBesucht_Garten:= true;
            memo1.lines.add('Die Katze hat sich an dir vorbei geschlichen. Gehe wieder ins Haus, um sie zu suchen.');
            schonBesucht_Buero:=false;
            end;

  //Abfrage, welche Objekte im aktuellen Ort vorhanden sind
  if aktuellerOrt=Haustuer
     then
         begin
         ButtonObjekt1.visible:=true;
         ButtonObjekt2.visible:=true;
         ButtonObjekt3.Visible:=true;
         ButtonObjekt1.caption:='Briefkasten';
         ButtonObjekt2.Caption:='Vase';
         ButtonObjekt3.Caption:='Lampe';
         OrtmitObjekt := 1;
         end;

  if aktuellerOrt=Abstellkammer
     then
         begin
         ButtonObjekt1.visible:=true;
         ButtonObjekt2.visible:=true;
         ButtonObjekt3.Visible:=true;
         ButtonObjekt1.caption:='Ritter';
         ButtonObjekt2.Caption:='Truhe';
         ButtonObjekt3.Caption:='Uhr';
         OrtmitObjekt := 2;
         end;

  if aktuellerOrt=Schlafzimmer1
     then
         begin
         ButtonObjekt1.visible:=true;
         ButtonObjekt2.visible:=true;
         ButtonObjekt3.Visible:=true;
         ButtonObjekt1.caption:='Unter dem Bett';
         ButtonObjekt2.Caption:='In der Truhe';
         ButtonObjekt3.Caption:='großer Teddybär';
         OrtmitObjekt := 4;
         end;

  if aktuellerOrt=Gaestezimmer
     then
         begin
         ButtonObjekt1.visible:=true;
         ButtonObjekt2.visible:=true;
         ButtonObjekt3.Visible:=true;
         ButtonObjekt1.caption:='Hinter dem Bett';
         ButtonObjekt2.Caption:='Unter dem Bett';
         ButtonObjekt3.Caption:='In der Kommode';
         OrtmitObjekt := 7;
         end;

  //Abfrage, welches Bild gezeigt werden soll
  if aktuellerOrt = Abstellkammer then AbstellkammerBild.visible := true else AbstellkammerBild.visible := false;
  if aktuellerOrt = Bad then BadBild.visible := true else BadBild.visible := false;
  if aktuellerOrt = Bad1 then Bad1Bild.visible := true else Bad1Bild.visible := false;
  if aktuellerOrt = Gaestebad then GaestebadBild.visible := true else GaestebadBild.visible := false;
  if aktuellerOrt = Balkon then BalkonBild.visible := true else BalkonBild.visible := false;
  if aktuellerOrt = Buero then BueroBild.visible := true else BueroBild.visible := false;
  if aktuellerOrt = Eingangsbereich then EingangsbereichBild.visible := true else EingangsbereichBild.visible := false;
  if aktuellerOrt = Flur1 then Flur1OGBild.visible := true else Flur1OGBild.visible := false;
  if aktuellerOrt = Flur2 then Flur2OGBild.visible := true else Flur2OGBild.visible := false;
  if aktuellerOrt = FlurUG then FlurUGBild.visible := true else FlurUGBild.visible := false;
  if aktuellerOrt = Garten then GartenBild.visible := true else GartenBild.visible := false;
  if aktuellerOrt = Gaestezimmer then GaestezimmerBild.visible := true else GaestezimmerBild.visible := false;
  if aktuellerOrt = Haustuer then HaustuerBild.visible := true else HaustuerBild.visible := false;
  if aktuellerOrt = Schlafzimmer1 then Schlafzimmer1Bild.visible := true else Schlafzimmer1Bild.visible := false;
  if aktuellerOrt = Kueche then KuecheBild.visible := true else KuecheBild.visible := false;
  if aktuellerOrt = Schlafzimmer2 then Schlafzimmer2Bild.visible := true else Schlafzimmer2Bild.visible := false;
  if aktuellerOrt = Spielraum then SpielraumBild.visible := true else SpielraumBild.visible := false;
  if aktuellerOrt = TreppeOG1 then Treppe1OGBild.visible := true else Treppe1OGBild.visible := false;
  if aktuellerOrt = TreppeEG then TreppeEGBild.visible := true else TreppeEGBild.visible := false;
  if aktuellerOrt = GeheimeTreppe then TreppeGeheimBild.visible := true else TreppeGeheimBild.visible := false;
  if aktuellerOrt = TreppeUG then TreppeUGBild.visible := true else TreppeUGBild.visible := false;
  if aktuellerOrt = Vorplatz then VorplatzBild.visible := true else VorplatzBild.visible := false;
  if aktuellerOrt = Waschraum then WaschraumBild.visible := true else WaschraumBild.visible := false;
  if aktuellerOrt = Wohnzimmer then WohnzimmerBild.visible := true else WohnzimmerBild.visible := false;
  if aktuellerOrt = TreppeOG2 then TreppeOG2Bild.visible := true else TreppeOG2Bild.visible := false;

  //Procedure: Nachbar im Haus
  if NachbarImHaus= true
     then
         begin
         randomize;
         OrtNachbar:= Ortzufaellig[random(6)+1]; //zufällige Zuordnung der Räume
         if aktuellerOrt=OrtNachbar
            then
              begin
                //Ansicht des Spielers, wenn verloren
               memo1.text:='Der Nachbar hat dich gefunden. Er ruft die Polizei und du kommst ins Gefängnis! Aber wenigstens hast du deine Katze gefunden.';
               EndeBild.visible := true;
               VerlorenLabel1.visible := true;
               VerlorenLabel2.visible := true;

               //Buttons unsichtbar machen, sodass nicht mehr weitergespielt werden kann
               ButtonSueden.visible := false;
               ButtonNorden.visible := false;
               ButtonOsten.visible := false;
               ButtonWesten.visible := false;
               ButtonOben.visible := false;
               ButtonUnten.visible := false;
               ButtonObjekt1.visible := false;
               ButtonObjekt2.visible := false;
               ButtonObjekt3.visible := false;
               ButtonTipp.visible := false;
               ButtonMinispiel.visible := false;
               ButtonTutorial2.visible := false;

               //Minispiele anbieten
               LabelEnde1.visible := true;
               LabelEnde2.visible := true;
               ButtonMinispiel1.visible := true;
               ButtonMinispiel2.visible := true;
               ButtonMinispiel3.visible := true;
               ButtonMinispiel4.visible := true;
               ButtonMinispiel5.visible := true;
               ButtonMinispiel6.visible := true;
               ButtonMinispiel7.visible := true;
               ButtonMinispiel8.visible := true;
               end;
              end;
end;

procedure TForm1.ButtonOstenClick(Sender: TObject);
begin
  //Die Buttons für die Objekte unsichtbar machen
         ButtonObjekt1.visible:=false;
         ButtonObjekt2.visible:=false;
         ButtonObjekt3.Visible:=false;

  //einen Ort weiter gehen und Sichtbarkeit der Richtungen einstellen
  aktuellerOrt:= aktuellerOrt.GetOsten;

  if aktuellerOrt.GetNorden <>nil
     then buttonNorden.visible:=true
     else buttonNorden.visible:=false;

  if aktuellerOrt.GetOsten <>nil
     then buttonOsten.visible:=true
     else buttonOsten.visible:=false;

  if aktuellerOrt.GetSueden <>nil
     then buttonSueden.visible:=true
     else buttonSueden.visible:=false;

  if aktuellerOrt.GetWesten <>nil
     then buttonWesten.visible:=true
     else buttonWesten.visible:=false;

  if aktuellerOrt.GetOben <>nil
     then buttonOben.visible:=true
     else buttonOben.visible:=false;

  if aktuellerOrt.GetUnten <>nil
     then buttonUnten.visible:=true
     else buttonUnten.visible:=false;

  //Beschreibung des aktuellen Ortes anzeigen
  memo1.text:= aktuellerOrt.GetBeschreibung;


  //Abfrage, welche Objekte im aktuellen Ort vorhanden sind
  if aktuellerOrt=Schlafzimmer1
       then
           begin
           ButtonObjekt1.visible:=true;
           ButtonObjekt2.visible:=true;
           ButtonObjekt3.Visible:=true;
           ButtonObjekt1.caption:='Unter dem Bett';
           ButtonObjekt2.Caption:='In der Truhe';
           ButtonObjekt3.Caption:='großer Teddybär';
           OrtmitObjekt := 4;
           end;

  if aktuellerOrt=Schlafzimmer2
     then
         begin
         ButtonObjekt1.visible:=true;
         ButtonObjekt2.visible:=true;
         ButtonObjekt3.Visible:=true;
         ButtonObjekt1.caption:='Im Klavier';
         ButtonObjekt2.Caption:='Unter dem Bett';
         ButtonObjekt3.Caption:='In der Kommode';
         OrtmitObjekt := 5;
         end;

  if aktuellerOrt=Gaestezimmer
     then
         begin
         ButtonObjekt1.visible:=true;
         ButtonObjekt2.visible:=true;
         ButtonObjekt3.Visible:=true;
         ButtonObjekt1.caption:='Hinter dem Bett';
         ButtonObjekt2.Caption:='Unter dem Bett';
         ButtonObjekt3.Caption:='In der Kommode';
         OrtmitObjekt := 7;
         end;

  //Abfrage, welches Bild gezeigt werden soll
  if aktuellerOrt = Abstellkammer then AbstellkammerBild.visible := true else AbstellkammerBild.visible := false;
  if aktuellerOrt = Bad then BadBild.visible := true else BadBild.visible := false;
  if aktuellerOrt = Bad1 then Bad1Bild.visible := true else Bad1Bild.visible := false;
  if aktuellerOrt = Gaestebad then GaestebadBild.visible := true else GaestebadBild.visible := false;
  if aktuellerOrt = Balkon then BalkonBild.visible := true else BalkonBild.visible := false;
  if aktuellerOrt = Buero then BueroBild.visible := true else BueroBild.visible := false;
  if aktuellerOrt = Eingangsbereich then EingangsbereichBild.visible := true else EingangsbereichBild.visible := false;
  if aktuellerOrt = Flur1 then Flur1OGBild.visible := true else Flur1OGBild.visible := false;
  if aktuellerOrt = Flur2 then Flur2OGBild.visible := true else Flur2OGBild.visible := false;
  if aktuellerOrt = FlurUG then FlurUGBild.visible := true else FlurUGBild.visible := false;
  if aktuellerOrt = Garten then GartenBild.visible := true else GartenBild.visible := false;
  if aktuellerOrt = Gaestezimmer then GaestezimmerBild.visible := true else GaestezimmerBild.visible := false;
  if aktuellerOrt = Haustuer then HaustuerBild.visible := true else HaustuerBild.visible := false;
  if aktuellerOrt = Schlafzimmer1 then Schlafzimmer1Bild.visible := true else Schlafzimmer1Bild.visible := false;
  if aktuellerOrt = Kueche then KuecheBild.visible := true else KuecheBild.visible := false;
  if aktuellerOrt = Schlafzimmer2 then Schlafzimmer2Bild.visible := true else Schlafzimmer2Bild.visible := false;
  if aktuellerOrt = Spielraum then SpielraumBild.visible := true else SpielraumBild.visible := false;
  if aktuellerOrt = TreppeOG1 then Treppe1OGBild.visible := true else Treppe1OGBild.visible := false;
  if aktuellerOrt = TreppeEG then TreppeEGBild.visible := true else TreppeEGBild.visible := false;
  if aktuellerOrt = GeheimeTreppe then TreppeGeheimBild.visible := true else TreppeGeheimBild.visible := false;
  if aktuellerOrt = TreppeUG then TreppeUGBild.visible := true else TreppeUGBild.visible := false;
  if aktuellerOrt = Vorplatz then VorplatzBild.visible := true else VorplatzBild.visible := false;
  if aktuellerOrt = Waschraum then WaschraumBild.visible := true else WaschraumBild.visible := false;
  if aktuellerOrt = Wohnzimmer then WohnzimmerBild.visible := true else WohnzimmerBild.visible := false;
  if aktuellerOrt = TreppeOG2 then TreppeOG2Bild.visible := true else TreppeOG2Bild.visible := false;

  //Procedure: Nachbar im Haus
  if NachbarImHaus= true
     then
         begin
         randomize;
         OrtNachbar:= Ortzufaellig[random(6)+1]; //zufällige Zuordnung der Räume
         if aktuellerOrt=OrtNachbar
            then
              begin
                //Ansicht des Spielers, wenn verloren
               memo1.text:='Der Nachbar hat dich gefunden. Er ruft die Polizei und du kommst ins Gefängnis! Aber wenigstens hast du deine Katze gefunden.';
               EndeBild.visible := true;
               VerlorenLabel1.visible := true;
               VerlorenLabel2.visible := true;

               //Buttons unsichtbar machen, sodass nicht mehr weitergespielt werden kann
               ButtonSueden.visible := false;
               ButtonNorden.visible := false;
               ButtonOsten.visible := false;
               ButtonWesten.visible := false;
               ButtonOben.visible := false;
               ButtonUnten.visible := false;
               ButtonObjekt1.visible := false;
               ButtonObjekt2.visible := false;
               ButtonObjekt3.visible := false;
               ButtonTipp.visible := false;
               ButtonMinispiel.visible := false;
               ButtonTutorial2.visible := false;

               //Minispiele anbieten
               LabelEnde1.visible := true;
               LabelEnde2.visible := true;
               ButtonMinispiel1.visible := true;
               ButtonMinispiel2.visible := true;
               ButtonMinispiel3.visible := true;
               ButtonMinispiel4.visible := true;
               ButtonMinispiel5.visible := true;
               ButtonMinispiel6.visible := true;
               ButtonMinispiel7.visible := true;
               ButtonMinispiel8.visible := true;
               end;
              end;

end;



procedure TForm1.ButtonSuedenClick(Sender: TObject);
begin

  //Die Buttons für die Objekte unsichtbar machen
         ButtonObjekt1.visible:=false;
         ButtonObjekt2.visible:=false;
         ButtonObjekt3.Visible:=false;

  //einen Ort weiter gehen und Sichtbarkeit der Richtungen einstellen
  aktuellerOrt:= aktuellerOrt.GetSueden;

  if aktuellerOrt.GetNorden <>nil
     then buttonNorden.visible:=true
     else buttonNorden.visible:=false;

  if aktuellerOrt.GetOsten <>nil
     then buttonOsten.visible:=true
     else buttonOsten.visible:=false;

  if aktuellerOrt.GetSueden <>nil
     then buttonSueden.visible:=true
     else buttonSueden.visible:=false;

  if aktuellerOrt.GetWesten <>nil
     then buttonWesten.visible:=true
     else buttonWesten.visible:=false;

  if aktuellerOrt.GetOben <>nil
     then buttonOben.visible:=true
     else buttonOben.visible:=false;

  if aktuellerOrt.GetUnten <>nil
     then buttonUnten.visible:=true
     else buttonUnten.visible:=false;

  //Beschreibung der aktuellen Räume angezeigt
  memo1.text:= aktuellerOrt.getBeschreibung;


  //Abfrage, welche Objekte im aktuellen Ort vorhanden sind
  if aktuellerOrt=Buero
     then
         begin
         ButtonObjekt1.visible:=true;
         ButtonObjekt2.visible:=true;
         ButtonObjekt3.Visible:=true;
         ButtonObjekt1.caption:='Unter dem Schreibtisch';
         ButtonObjekt2.Caption:='Auf dem roten Stuhl';
         ButtonObjekt3.Caption:='Um die Ecke';
         OrtmitObjekt := 3;
         end;

  if aktuellerOrt=Schlafzimmer2
     then
         begin
         ButtonObjekt1.visible:=true;
         ButtonObjekt2.visible:=true;
         ButtonObjekt3.Visible:=true;
         ButtonObjekt1.caption:='Im Klavier';
         ButtonObjekt2.Caption:='Unter dem Bett';
         ButtonObjekt3.Caption:='In der Kommode';
         OrtmitObjekt := 5;
         end;

  if aktuellerOrt=Spielraum
      then
          begin
          ButtonObjekt1.visible:=true;
          ButtonObjekt2.visible:=true;
          ButtonObjekt3.Visible:=true;
          ButtonObjekt1.caption:='Im Schloss';
          ButtonObjekt2.Caption:='Hinter dem Teddybären';
          ButtonObjekt3.Caption:='Hinter dem Dino';
          OrtmitObjekt := 6;
          end;

  //Abfrage, welches Bild gezeigt werden soll
  if aktuellerOrt = Abstellkammer then AbstellkammerBild.visible := true else AbstellkammerBild.visible := false;
  if aktuellerOrt = Bad then BadBild.visible := true else BadBild.visible := false;
  if aktuellerOrt = Bad1 then Bad1Bild.visible := true else Bad1Bild.visible := false;
  if aktuellerOrt = Gaestebad then GaestebadBild.visible := true else GaestebadBild.visible := false;
  if aktuellerOrt = Balkon then BalkonBild.visible := true else BalkonBild.visible := false;
  if aktuellerOrt = Buero then BueroBild.visible := true else BueroBild.visible := false;
  if aktuellerOrt = Eingangsbereich then EingangsbereichBild.visible := true else EingangsbereichBild.visible := false;
  if aktuellerOrt = Flur1 then Flur1OGBild.visible := true else Flur1OGBild.visible := false;
  if aktuellerOrt = Flur2 then Flur2OGBild.visible := true else Flur2OGBild.visible := false;
  if aktuellerOrt = FlurUG then FlurUGBild.visible := true else FlurUGBild.visible := false;
  if aktuellerOrt = Garten then GartenBild.visible := true else GartenBild.visible := false;
  if aktuellerOrt = Gaestezimmer then GaestezimmerBild.visible := true else GaestezimmerBild.visible := false;
  if aktuellerOrt = Haustuer then HaustuerBild.visible := true else HaustuerBild.visible := false;
  if aktuellerOrt = Schlafzimmer1 then Schlafzimmer1Bild.visible := true else Schlafzimmer1Bild.visible := false;
  if aktuellerOrt = Kueche then KuecheBild.visible := true else KuecheBild.visible := false;
  if aktuellerOrt = Schlafzimmer2 then Schlafzimmer2Bild.visible := true else Schlafzimmer2Bild.visible := false;
  if aktuellerOrt = Spielraum then SpielraumBild.visible := true else SpielraumBild.visible := false;
  if aktuellerOrt = TreppeOG1 then Treppe1OGBild.visible := true else Treppe1OGBild.visible := false;
  if aktuellerOrt = TreppeEG then TreppeEGBild.visible := true else TreppeEGBild.visible := false;
  if aktuellerOrt = GeheimeTreppe then TreppeGeheimBild.visible := true else TreppeGeheimBild.visible := false;
  if aktuellerOrt = TreppeUG then TreppeUGBild.visible := true else TreppeUGBild.visible := false;
  if aktuellerOrt = Vorplatz then VorplatzBild.visible := true else VorplatzBild.visible := false;
  if aktuellerOrt = Waschraum then WaschraumBild.visible := true else WaschraumBild.visible := false;
  if aktuellerOrt = Wohnzimmer then WohnzimmerBild.visible := true else WohnzimmerBild.visible := false;
  if aktuellerOrt = TreppeOG2 then TreppeOG2Bild.visible := true else TreppeOG2Bild.visible := false;

  //Procedure: Nachbar im Haus
  if NachbarImHaus= true
     then
         begin
         randomize;
         OrtNachbar:= Ortzufaellig[random(6)+1]; //zufällige Zuordnung der Räume
         if aktuellerOrt=OrtNachbar
            then
              begin
                //Ansicht des Spielers, wenn verloren
               memo1.text:='Der Nachbar hat dich gefunden. Er ruft die Polizei und du kommst ins Gefängnis! Aber wenigstens hast du deine Katze gefunden.';
               EndeBild.visible := true;
               VerlorenLabel1.visible := true;
               VerlorenLabel2.visible := true;

               //Buttons unsichtbar machen, sodass nicht mehr weitergespielt werden kann
               ButtonSueden.visible := false;
               ButtonNorden.visible := false;
               ButtonOsten.visible := false;
               ButtonWesten.visible := false;
               ButtonOben.visible := false;
               ButtonUnten.visible := false;
               ButtonObjekt1.visible := false;
               ButtonObjekt2.visible := false;
               ButtonObjekt3.visible := false;
               ButtonTipp.visible := false;
               ButtonMinispiel.visible := false;
               ButtonTutorial2.visible := false;

               //Minispiele anbieten
               LabelEnde1.visible := true;
               LabelEnde2.visible := true;
               ButtonMinispiel1.visible := true;
               ButtonMinispiel2.visible := true;
               ButtonMinispiel3.visible := true;
               ButtonMinispiel4.visible := true;
               ButtonMinispiel5.visible := true;
               ButtonMinispiel6.visible := true;
               ButtonMinispiel7.visible := true;
               ButtonMinispiel8.visible := true;
               end;
              end;
end;

procedure TForm1.ButtonWestenClick(Sender: TObject);
begin
  //Die Buttons für die Objekte unsichtbar machen
         ButtonObjekt1.visible:=false;
         ButtonObjekt2.visible:=false;
         ButtonObjekt3.Visible:=false;

  //einen Ort weiter gehen und Sichtbarkeit der Richtungen einstellen
  aktuellerOrt:= aktuellerOrt.GetWesten;

  if aktuellerOrt.GetNorden <>nil
     then buttonNorden.visible:=true
     else buttonNorden.visible:=false;

  if aktuellerOrt.GetOsten <>nil
     then buttonOsten.visible:=true
     else buttonOsten.visible:=false;

  if aktuellerOrt.GetSueden <>nil
     then buttonSueden.visible:=true
     else buttonSueden.visible:=false;

  if aktuellerOrt.GetWesten <>nil
     then buttonWesten.visible:=true
     else buttonWesten.visible:=false;

  if aktuellerOrt.GetOben <>nil
     then buttonOben.visible:=true
     else buttonOben.visible:=false;

  if aktuellerOrt.GetUnten <>nil
     then buttonUnten.visible:=true
     else buttonUnten.visible:=false;

  //Beschreibung der aktuellen Räume angezeigt
  memo1.text:= aktuellerOrt.GetBeschreibung;

  //Procedure Katze springt vom Balkon
  if aktuellerOrt=Balkon
     then if schonBesucht_Balkon=false
          then
              begin
              //Procedure Katze spring vom Balkon
              schonBesucht_Balkon:= true;
              memo1.lines.add('Da sitzt deine Katze! Endlich du hast sie gefunden! NEIN! Gerade war ein lautes Geräuch, sodass sie sich erschrocken hat und von dem Balkon gesprungen ist. Du siehst sie unten im Garten. Ihr scheint es gut zu gehen. Gehe schnell zu ihr.');
              schonBesucht_Garten:=false; //Procedure Gehe in Garten
              end;



  //Abfrage, welche Objekte im aktuellen Ort vorhanden sind

   if aktuellerOrt=Schlafzimmer2
     then
         begin
         ButtonObjekt1.visible:=true;
         ButtonObjekt2.visible:=true;
         ButtonObjekt3.Visible:=true;
         ButtonObjekt1.caption:='Im Klavier';
         ButtonObjekt2.Caption:='Unter dem Bett';
         ButtonObjekt3.Caption:='In der Kommode';
         OrtmitObjekt := 5;
         end;

    if aktuellerOrt=Waschraum
     then
         begin
         ButtonObjekt1.visible:=true;
         ButtonObjekt2.visible:=true;
         ButtonObjekt3.Visible:=true;
         ButtonObjekt1.caption:='In der Kommode';
         ButtonObjekt2.Caption:='Klamottenhaufen';
         ButtonObjekt3.Caption:='Wäschekorb';
         OrtmitObjekt := 8;
         end;

  //Abfrage, welches Bild gezeigt werden soll
  if aktuellerOrt = Abstellkammer then AbstellkammerBild.visible := true else AbstellkammerBild.visible := false;
  if aktuellerOrt = Bad then BadBild.visible := true else BadBild.visible := false;
  if aktuellerOrt = Bad1 then Bad1Bild.visible := true else Bad1Bild.visible := false;
  if aktuellerOrt = Gaestebad then GaestebadBild.visible := true else GaestebadBild.visible := false;
  if aktuellerOrt = Balkon then BalkonBild.visible := true else BalkonBild.visible := false;
  if aktuellerOrt = Buero then BueroBild.visible := true else BueroBild.visible := false;
  if aktuellerOrt = Eingangsbereich then EingangsbereichBild.visible := true else EingangsbereichBild.visible := false;
  if aktuellerOrt = Flur1 then Flur1OGBild.visible := true else Flur1OGBild.visible := false;
  if aktuellerOrt = Flur2 then Flur2OGBild.visible := true else Flur2OGBild.visible := false;
  if aktuellerOrt = FlurUG then FlurUGBild.visible := true else FlurUGBild.visible := false;
  if aktuellerOrt = Garten then GartenBild.visible := true else GartenBild.visible := false;
  if aktuellerOrt = Gaestezimmer then GaestezimmerBild.visible := true else GaestezimmerBild.visible := false;
  if aktuellerOrt = Haustuer then HaustuerBild.visible := true else HaustuerBild.visible := false;
  if aktuellerOrt = Schlafzimmer1 then Schlafzimmer1Bild.visible := true else Schlafzimmer1Bild.visible := false;
  if aktuellerOrt = Kueche then KuecheBild.visible := true else KuecheBild.visible := false;
  if aktuellerOrt = Schlafzimmer2 then Schlafzimmer2Bild.visible := true else Schlafzimmer2Bild.visible := false;
  if aktuellerOrt = Spielraum then SpielraumBild.visible := true else SpielraumBild.visible := false;
  if aktuellerOrt = TreppeOG1 then Treppe1OGBild.visible := true else Treppe1OGBild.visible := false;
  if aktuellerOrt = TreppeEG then TreppeEGBild.visible := true else TreppeEGBild.visible := false;
  if aktuellerOrt = GeheimeTreppe then TreppeGeheimBild.visible := true else TreppeGeheimBild.visible := false;
  if aktuellerOrt = TreppeUG then TreppeUGBild.visible := true else TreppeUGBild.visible := false;
  if aktuellerOrt = Vorplatz then VorplatzBild.visible := true else VorplatzBild.visible := false;
  if aktuellerOrt = Waschraum then WaschraumBild.visible := true else WaschraumBild.visible := false;
  if aktuellerOrt = Wohnzimmer then WohnzimmerBild.visible := true else WohnzimmerBild.visible := false;
  if aktuellerOrt = TreppeOG2 then TreppeOG2Bild.visible := true else TreppeOG2Bild.visible := false;

  //Procedure: Nachbar im Haus
  if NachbarImHaus= true
     then
         begin
         randomize;
         OrtNachbar:= Ortzufaellig[random(6)+1]; //zufällige Zuordnung der Räume
         if aktuellerOrt=OrtNachbar
            then
              begin
                //Ansicht des Spielers, wenn verloren
               memo1.text:='Der Nachbar hat dich gefunden. Er ruft die Polizei und du kommst ins Gefängnis! Aber wenigstens hast du deine Katze gefunden.';
               EndeBild.visible := true;
               VerlorenLabel1.visible := true;
               VerlorenLabel2.visible := true;

               //Buttons unsichtbar machen, sodass nicht mehr weitergespielt werden kann
               ButtonSueden.visible := false;
               ButtonNorden.visible := false;
               ButtonOsten.visible := false;
               ButtonWesten.visible := false;
               ButtonOben.visible := false;
               ButtonUnten.visible := false;
               ButtonObjekt1.visible := false;
               ButtonObjekt2.visible := false;
               ButtonObjekt3.visible := false;
               ButtonTipp.visible := false;
               ButtonMinispiel.visible := false;
               ButtonTutorial2.visible := false;

               //Minispiele anbieten
               LabelEnde1.visible := true;
               LabelEnde2.visible := true;
               ButtonMinispiel1.visible := true;
               ButtonMinispiel2.visible := true;
               ButtonMinispiel3.visible := true;
               ButtonMinispiel4.visible := true;
               ButtonMinispiel5.visible := true;
               ButtonMinispiel6.visible := true;
               ButtonMinispiel7.visible := true;
               ButtonMinispiel8.visible := true;
               end;
              end;
end;

procedure TForm1.ButtonObenClick(Sender: TObject);
begin
  //Die Buttons für die Objekte unsichtbar machen
         ButtonObjekt1.visible:=false;
         ButtonObjekt2.visible:=false;
         ButtonObjekt3.Visible:=false;

  //einen Ort weiter gehen und Sichtbarkeit der Richtungen einstellen
  aktuellerOrt:= aktuellerOrt.GetOben;

  if aktuellerOrt.GetNorden <>nil
     then buttonNorden.visible:=true
     else buttonNorden.visible:=false;

  if aktuellerOrt.GetOsten <>nil
     then buttonOsten.visible:=true
     else buttonOsten.visible:=false;

  if aktuellerOrt.GetSueden <>nil
     then buttonSueden.visible:=true
     else buttonSueden.visible:=false;

  if aktuellerOrt.GetWesten <>nil
     then buttonWesten.visible:=true
     else buttonWesten.visible:=false;

  if aktuellerOrt.GetOben <>nil
     then buttonOben.visible:=true
     else buttonOben.visible:=false;

  if aktuellerOrt.GetUnten <>nil
     then buttonUnten.visible:=true
     else buttonUnten.visible:=false;

  memo1.text:= aktuellerOrt.GetBeschreibung;


  //Abfrage, welches Bild gezeigt werden soll
  if aktuellerOrt = Abstellkammer then AbstellkammerBild.visible := true else AbstellkammerBild.visible := false;
  if aktuellerOrt = Bad then BadBild.visible := true else BadBild.visible := false;
  if aktuellerOrt = Bad1 then Bad1Bild.visible := true else Bad1Bild.visible := false;
  if aktuellerOrt = Gaestebad then GaestebadBild.visible := true else GaestebadBild.visible := false;
  if aktuellerOrt = Balkon then BalkonBild.visible := true else BalkonBild.visible := false;
  if aktuellerOrt = Buero then BueroBild.visible := true else BueroBild.visible := false;
  if aktuellerOrt = Eingangsbereich then EingangsbereichBild.visible := true else EingangsbereichBild.visible := false;
  if aktuellerOrt = Flur1 then Flur1OGBild.visible := true else Flur1OGBild.visible := false;
  if aktuellerOrt = Flur2 then Flur2OGBild.visible := true else Flur2OGBild.visible := false;
  if aktuellerOrt = FlurUG then FlurUGBild.visible := true else FlurUGBild.visible := false;
  if aktuellerOrt = Garten then GartenBild.visible := true else GartenBild.visible := false;
  if aktuellerOrt = Gaestezimmer then GaestezimmerBild.visible := true else GaestezimmerBild.visible := false;
  if aktuellerOrt = Haustuer then HaustuerBild.visible := true else HaustuerBild.visible := false;
  if aktuellerOrt = Schlafzimmer1 then Schlafzimmer1Bild.visible := true else Schlafzimmer1Bild.visible := false;
  if aktuellerOrt = Kueche then KuecheBild.visible := true else KuecheBild.visible := false;
  if aktuellerOrt = Schlafzimmer2 then Schlafzimmer2Bild.visible := true else Schlafzimmer2Bild.visible := false;
  if aktuellerOrt = Spielraum then SpielraumBild.visible := true else SpielraumBild.visible := false;
  if aktuellerOrt = TreppeOG1 then Treppe1OGBild.visible := true else Treppe1OGBild.visible := false;
  if aktuellerOrt = TreppeEG then TreppeEGBild.visible := true else TreppeEGBild.visible := false;
  if aktuellerOrt = GeheimeTreppe then TreppeGeheimBild.visible := true else TreppeGeheimBild.visible := false;
  if aktuellerOrt = TreppeUG then TreppeUGBild.visible := true else TreppeUGBild.visible := false;
  if aktuellerOrt = Vorplatz then VorplatzBild.visible := true else VorplatzBild.visible := false;
  if aktuellerOrt = Waschraum then WaschraumBild.visible := true else WaschraumBild.visible := false;
  if aktuellerOrt = Wohnzimmer then WohnzimmerBild.visible := true else WohnzimmerBild.visible := false;
  if aktuellerOrt = TreppeOG2 then TreppeOG2Bild.visible := true else TreppeOG2Bild.visible := false;

  //Procedure: Nachbar im Haus
  if NachbarImHaus= true
     then
         begin
         randomize;
         OrtNachbar:= Ortzufaellig[random(6)+1]; //zufällige Zuordnung der Räume
         if aktuellerOrt=OrtNachbar
            then
              begin
                //Ansicht des Spielers, wenn verloren
               memo1.text:='Der Nachbar hat dich gefunden. Er ruft die Polizei und du kommst ins Gefängnis! Aber wenigstens hast du deine Katze gefunden.';
               EndeBild.visible := true;
               VerlorenLabel1.visible := true;
               VerlorenLabel2.visible := true;

               //Buttons unsichtbar machen, sodass nicht mehr weitergespielt werden kann
               ButtonSueden.visible := false;
               ButtonNorden.visible := false;
               ButtonOsten.visible := false;
               ButtonWesten.visible := false;
               ButtonOben.visible := false;
               ButtonUnten.visible := false;
               ButtonObjekt1.visible := false;
               ButtonObjekt2.visible := false;
               ButtonObjekt3.visible := false;
               ButtonTipp.visible := false;
               ButtonMinispiel.visible := false;
               ButtonTutorial2.visible := false;

               //Minispiele anbieten
               LabelEnde1.visible := true;
               LabelEnde2.visible := true;
               ButtonMinispiel1.visible := true;
               ButtonMinispiel2.visible := true;
               ButtonMinispiel3.visible := true;
               ButtonMinispiel4.visible := true;
               ButtonMinispiel5.visible := true;
               ButtonMinispiel6.visible := true;
               ButtonMinispiel7.visible := true;
               ButtonMinispiel8.visible := true;
               end;
              end;

  //Prozedur Gewonnen
  If aktuellerOrt = Freiheit then
    begin
       //Ansicht Gewonnen
       LabelGewonnen.visible := true;
       VerlorenLabel2.visible := true;
       memo1.lines.add('Herzlichen Glückwunsch! Du hast den geheimen Weg in die Freiheit gefunden! Jetzt schnell wieder in dein Haus bevor dich noch der Nachbar sieht');


       //Buttons unsichtbar machen, sodass nicht mehr weitergespielt werden kann
       ButtonSueden.visible := false;
       ButtonNorden.visible := false;
       ButtonOsten.visible := false;
       ButtonWesten.visible := false;
       ButtonOben.visible := false;
       ButtonUnten.visible := false;
       ButtonObjekt1.visible := false;
       ButtonObjekt2.visible := false;
       ButtonObjekt3.visible := false;
       ButtonTipp.visible := false;
       ButtonMinispiel.visible := false;
       ButtonTutorial2.visible := false;


       //Minispiele anbieten
       LabelEnde1.visible := true;
       LabelEnde2.visible := true;
       ButtonMinispiel1.visible := true;
       ButtonMinispiel2.visible := true;
       ButtonMinispiel3.visible := true;
       ButtonMinispiel4.visible := true;
       ButtonMinispiel5.visible := true;
       ButtonMinispiel6.visible := true;
       ButtonMinispiel7.visible := true;
       ButtonMinispiel8.visible := true;

    end;
end;



procedure TForm1.ButtonUntenClick(Sender: TObject);
begin
  //Die Buttons für die Objekte unsichtbar machen
         ButtonObjekt1.visible:=false;
         ButtonObjekt2.visible:=false;
         ButtonObjekt3.Visible:=false;

  //einen Ort weiter gehen und Sichtbarkeit der Richtungen einstellen
  aktuellerOrt:= aktuellerOrt.GetUnten;

  if aktuellerOrt.GetNorden <>nil
     then buttonNorden.visible:=true
     else buttonNorden.visible:=false;

  if aktuellerOrt.GetOsten <>nil
     then buttonOsten.visible:=true
     else buttonOsten.visible:=false;

  if aktuellerOrt.GetSueden <>nil
     then buttonSueden.visible:=true
     else buttonSueden.visible:=false;

  if aktuellerOrt.GetWesten <>nil
     then buttonWesten.visible:=true
     else buttonWesten.visible:=false;

  if aktuellerOrt.GetOben <>nil
     then buttonOben.visible:=true
     else buttonOben.visible:=false;

  if aktuellerOrt.GetUnten <>nil
     then buttonUnten.visible:=true
     else buttonUnten.visible:=false;

  //Beschreibung der aktuellen Räume
  memo1.text:= aktuellerOrt.GetBeschreibung;



  //Abfrage, welches Bild gezeigt werden soll
  if aktuellerOrt = Abstellkammer then AbstellkammerBild.visible := true else AbstellkammerBild.visible := false;
  if aktuellerOrt = Bad then BadBild.visible := true else BadBild.visible := false;
  if aktuellerOrt = Bad1 then Bad1Bild.visible := true else Bad1Bild.visible := false;
  if aktuellerOrt = Gaestebad then GaestebadBild.visible := true else GaestebadBild.visible := false;
  if aktuellerOrt = Balkon then BalkonBild.visible := true else BalkonBild.visible := false;
  if aktuellerOrt = Buero then BueroBild.visible := true else BueroBild.visible := false;
  if aktuellerOrt = Eingangsbereich then EingangsbereichBild.visible := true else EingangsbereichBild.visible := false;
  if aktuellerOrt = Flur1 then Flur1OGBild.visible := true else Flur1OGBild.visible := false;
  if aktuellerOrt = Flur2 then Flur2OGBild.visible := true else Flur2OGBild.visible := false;
  if aktuellerOrt = FlurUG then FlurUGBild.visible := true else FlurUGBild.visible := false;
  if aktuellerOrt = Garten then GartenBild.visible := true else GartenBild.visible := false;
  if aktuellerOrt = Gaestezimmer then GaestezimmerBild.visible := true else GaestezimmerBild.visible := false;
  if aktuellerOrt = Haustuer then HaustuerBild.visible := true else HaustuerBild.visible := false;
  if aktuellerOrt = Schlafzimmer1 then Schlafzimmer1Bild.visible := true else Schlafzimmer1Bild.visible := false;
  if aktuellerOrt = Kueche then KuecheBild.visible := true else KuecheBild.visible := false;
  if aktuellerOrt = Schlafzimmer2 then Schlafzimmer2Bild.visible := true else Schlafzimmer2Bild.visible := false;
  if aktuellerOrt = Spielraum then SpielraumBild.visible := true else SpielraumBild.visible := false;
  if aktuellerOrt = TreppeOG1 then Treppe1OGBild.visible := true else Treppe1OGBild.visible := false;
  if aktuellerOrt = TreppeEG then TreppeEGBild.visible := true else TreppeEGBild.visible := false;
  if aktuellerOrt = GeheimeTreppe then TreppeGeheimBild.visible := true else TreppeGeheimBild.visible := false;
  if aktuellerOrt = TreppeUG then TreppeUGBild.visible := true else TreppeUGBild.visible := false;
  if aktuellerOrt = Vorplatz then VorplatzBild.visible := true else VorplatzBild.visible := false;
  if aktuellerOrt = Waschraum then WaschraumBild.visible := true else WaschraumBild.visible := false;
  if aktuellerOrt = Wohnzimmer then WohnzimmerBild.visible := true else WohnzimmerBild.visible := false;
  if aktuellerOrt = TreppeOG2 then TreppeOG2Bild.visible := true else TreppeOG2Bild.visible := false;

  //Procedure: Nachbar im Haus
  if NachbarImHaus= true
     then
         begin
         randomize;
         OrtNachbar:= Ortzufaellig[random(6)+1]; //zufällige Zuordnung der Räume
         if aktuellerOrt=OrtNachbar
            then
              begin
                //Ansicht des Spielers, wenn verloren
               memo1.text:='Der Nachbar hat dich gefunden. Er ruft die Polizei und du kommst ins Gefängnis! Aber wenigstens hast du deine Katze gefunden.';
               EndeBild.visible := true;
               VerlorenLabel1.visible := true;
               VerlorenLabel2.visible := true;

               //Buttons unsichtbar machen, sodass nicht mehr weitergespielt werden kann
               ButtonSueden.visible := false;
               ButtonNorden.visible := false;
               ButtonOsten.visible := false;
               ButtonWesten.visible := false;
               ButtonOben.visible := false;
               ButtonUnten.visible := false;
               ButtonObjekt1.visible := false;
               ButtonObjekt2.visible := false;
               ButtonObjekt3.visible := false;
               ButtonTipp.visible := false;
               ButtonMinispiel.visible := false;
               ButtonTutorial2.visible := false;

               //Minispiele anbieten
               LabelEnde1.visible := true;
               LabelEnde2.visible := true;
               ButtonMinispiel1.visible := true;
               ButtonMinispiel2.visible := true;
               ButtonMinispiel3.visible := true;
               ButtonMinispiel4.visible := true;
               ButtonMinispiel5.visible := true;
               ButtonMinispiel6.visible := true;
               ButtonMinispiel7.visible := true;
               ButtonMinispiel8.visible := true;
               end;
              end;
end;

procedure TForm1.ButtonObjekt1Click(Sender: TObject);
begin
  // Haustür Briefkasten
  if OrtmitObjekt = 1
    then
        begin
        Haustuer.setOrt(Eingangsbereich, nil, Vorplatz, nil, nil, nil, 'Du bist jetzt an der Haustür.');
        buttonNorden.visible := true;
        memo1.text := 'Du hast den Schlüssel gefunden! Gehe in das Haus hinein.';
        //Procedure: noch nicht im Haus gewesen
        schonBesucht_Haustuer:= true;
        schonBesucht_Balkon:=false;
        end;

  //Abstellkammer  Ritter
  if OrtmitObjekt = 2
    then if GeheimTreppeFreigeschaltet=false
        then memo1.lines.add('Ritter: Hier kommst du nicht durch. Finde erst deine Katze.')
        else memo1.lines.add('Gehe schnell durch die Geheimtür bevor dich der Nachbar findet');

  //Büro: Unter dem Schreibtisch
  if OrtmitObjekt = 3
    then
        begin
       memo1.lines.add('Glückwunsch, Du hast ganz viel Staub gefunden!');
        end;

//Schlafzimmer Kind: Unter dem Bett
  if OrtmitObjekt = 4
    then
        begin
        memo1.lines.add('Da liegt der Lieblingshase von Nico, dem Bewohner dieses unglaublich coolen Zimmers.');
        end;

//Schlafzimmer Eltern: Im Klavier
  if OrtmitObjekt = 5
    then
        begin
        memo1.lines.add('Dort liegen ganz viele Noten');
        memo1.lines.add('Du fragst dich, wie oft du hintereinander auf die gleiche Taste auf dem Klavier drücken kannst. In diesem Minispiel kannst du deine Künste austesten.');
        Minispiel := 4;
        ButtonMinispiel.visible := true;
        end;

//SpielraumBild: im Schloss
  if OrtmitObjekt = 6
    then
        begin
        memo1.lines.add('Drinnen steht eine Bionicles Actionfigur Wache, um die Prinzessin zu beschützen.');
        memo1.lines.add('Bevor die Actionfigur einen Besucher durchlässt, muss dieser möglichst schnell eine ausgedachte Zahl erraten.');
        memo1.lines.add('Teste deine Künste an diesem Minispiel aus!');
        Minispiel := 8;
        ButtonMinispiel.visible := true;
        end;

//Gästezimmer: Hinter dem Bett
  if OrtmitObjekt = 7
    then
        begin
        memo1.lines.add('Anscheinend haben die letzten Gäste ein Apple-Aufladekabel vergessen. Du lässt es dort liegen. Wer kann auch was damit anfangen?');
        end;
//WaschraumBild: In der Kommode
  if OrtmitObjekt = 8
     then
         begin
          memo1.lines.add('In der Kommode sind ganz viele Schuhe drin.');
         end;

end;

procedure TForm1.ButtonObjekt2Click(Sender: TObject);
begin
  //Haustür: Vase
  if OrtmitObjekt = 1
    then
        begin
        memo1.lines.add('Hier ist Nichts! Nur ein wenig Erde.');
        end;
  //Abstellkammer: Truhe
  if OrtmitObjekt = 2
    then memo1.lines.add('Hier ist es nur staubig');

 //Büro: Auf dem roten Stuhl
  if OrtmitObjekt = 3
    then if schonBesucht_Buero=false
          then
              begin
              schonBesucht_Buero:= true;
              memo1.lines.add('Du hast die Katze gefunden!');
              memo1.lines.add('Der böse Nachbar ist Zuhause. Du musst das Haus so schnell, wie möglich verlassen bevor er dich findet. Er bewegt sich im Erdgeschoss. Weil er dich sehen würde, kannst du nicht durch die Haustür oder das Wohnzimmer nach draußen gehen. Finde den geheimen Durchgang in die Freiheit.');
              NachbarImHaus:=true;
              GeheimTreppeFreigeschaltet:= true;
              Abstellkammer.setOrt(GeheimeTreppe,nil,FlurUG,nil,nil,nil,'Du siehst, dass hinter der Ritterrüstung noch eine Tür ist. Gehe zu ihr. Vielleicht befindest sich dort der geheime Ausgang.');
              GeheimeTreppe.setOrt(nil,nil,Abstellkammer,nil,Freiheit,nil,'Du hast die Geheime Treppe gefunden. Gehe nach oben in die Freiheit.');

              //Spieler kann das Haus nicht mehr durch die Haustür oder das Wohnzimer verlassen
              Wohnzimmer.SetOrt(nil, nil, Eingangsbereich, Kueche, nil, nil, 'Wohnzimmer');
              Eingangsbereich.SetOrt(Wohnzimmer, TreppeEG, nil, Bad, nil, nil, 'Eingangsbereich');
              end
           else memo1.lines.add('Hier ist es nur staubig');

//Schlafzimmer Kind: In der Truhe, Minispiel: Ampel
  if OrtmitObjekt = 4
    then
        begin
         memo1.lines.add('Du findest eine kleine Spielzeugampel mit einer passenden Fußgängerampel. Drücke auf "Minispiel", um mit der Ampel herumzuspielen.');
         Minispiel := 1;
         ButtonMinispiel.visible := true;
        end;

//Schlafzimmer Eltern: Unter dem Bett
  if OrtmitObjekt = 5
    then
        begin
        memo1.lines.add('Das willst du nicht wissen!!');
        end;

//SpielraumBild: Hinter dem Teddybären
  if OrtmitObjekt = 6
    then
        begin
        memo1.lines.add('Hier ist ein großer Fleck an der Wand! Der soll wohl versteckt bleiben. Du legst den Bären schnell wieder zurück.');
        end;

//Gästezimmer: Unter dem Bett
  if OrtmitObjekt = 7
    then
        begin
        memo1.lines.add('Ganz viele Tierhaare. Vielleicht kommen die von deiner Katze?');
        end;
//WaschraumBild: Klamottenhaufen
  if OrtmitObjekt = 8
     then
         begin
          memo1.lines.add('Hier ist leider Nichts drin!');
         end;
end;

procedure TForm1.ButtonObjekt3Click(Sender: TObject);
begin
   //Haustür: Lampe
  if OrtmitObjekt = 1
    then
        begin
        memo1.lines.add('Du hast in ein Spinnennetz gegriffen!');
        end;

  //Abstellkammer: Uhr
  if OrtmitObjekt = 2
    then memo1.lines.add('Hier ist es nur staubig. Versuche es bei einem anderem Objekt');


//Büro: Um die Ecke
  if OrtmitObjekt = 3
    then
        begin
        memo1.lines.add('Hier an der Wand hängt mitunter das Abiturzeugnis des bösen Nachbarn.');
        memo1.lines.add('Finde heraus, ob du es an der Schule des Nachbarn zum Abiturienten geschafft hättest. Versuche dafür im Minispiel keine Fehler zu haben. Aber denk dran, du kannst es jeder Zeit abbrechen, da es kein Ende gibt.');
        Minispiel := 7;
        ButtonMinispiel.visible := true;
        end;

//Schlafzimmer Kind: großer Teddybär
  if OrtmitObjekt = 4
    then
        begin
        memo1.lines.add('Hat der Teddybär dir gerade zugezwinkert??');
        memo1.lines.add('Teddybär: Hallo! Bitte spiele ein Spiel mit mir. Lass uns ganz viele Kreise und Vierecke malen. Drücke dafür nur auf den Minispiel Button.');
        Minispiel := 2;
        ButtonMinispiel.visible := true;
        end;

//Schlafzimmer Eltern: In der Kommode
  if OrtmitObjekt = 5
    then
        begin
        memo1.lines.add('Da liegen nur ein paar Urkunden drin.');
        memo1.lines.add('Die Eltern sind anscheinend Erste in einem S-Klasse Turnier im Standardtanz geworden.');
        memo1.lines.add('Die müssen ziemlich gut sein.');
        end;

//SpielraumBild: Hinter dem Dino
  if OrtmitObjekt = 6
    then
        begin
        memo1.lines.add('Der Dino erwacht zum Leben.');
        memo1.lines.add('Dino: Übe mit mir die Buchstaben und Zahlen!');
        memo1.lines.add('Dino: In diesem kleinen Minispiel können wir versuchen Palindrome zu bilden.');
        memo1.lines.add('Dino: Ich sage dir, ob du richtig liegst oder nicht.');
        Minispiel := 5;
        ButtonMinispiel.visible := true;
        end;

//Gästezimmer: In der Kommode
  if OrtmitObjekt = 7
    then
        begin
        memo1.lines.add('Du findest eine elektronische Geburtstagsglückwunsch-Karte. Im Minispiel kannst du das Alter eingeben, das jemand geworden ist. Finde heraus, wie dein Glückwunsch lautet.');
        Minispiel := 3;
        ButtonMinispiel.visible := true;
        end;
//WaschraumBild: Wäschekorb
  if OrtmitObjekt = 8
     then
         begin
          memo1.lines.add('Hier hat sich anscheinend eine kleine Taschenlampe eingeschlichen. Im Minispiel kannst du sie an- und wieder ausschalten.');
         Minispiel := 6;
         ButtonMinispiel.visible := true;
         end;

  end;

procedure TForm1.ButtonTippClick(Sender: TObject);
begin
//Damit der Button beim zweiten mal wieder geschlossen wird
if TippAN= false
   then
       begin
       TippAN := true;
       //Tipps für den Spieler
          if schonBesucht_Haustuer=false
             then
                 memo1.lines.add('Schaue mal bei den verfügbaren Objekten bei der Haustür nach')
                 else
                    if schonBesucht_Balkon=false
                      then
                          memo1.lines.add('Schau dich mal in der Nähe des Zimmers der Eltern um')
                          else
                            if  schonBesucht_Garten=false
                               then
                                   memo1.lines.add('Gärten befinden sich meist im Erdgeschoss')
                                   else
                                     if schonBesucht_Buero=false
                                        then
                                            memo1.lines.add('Aus dem zweiten Stock hörst du ein Miauen.')
                                               else
                                                 if Abstellkammer.GetNorden = GeheimeTreppe
                                                  then
                                                    memo1.Lines.add('Schau mal im Keller nach.')
                                                     else memo1.lines.add('Gerade stehen leider keine Tipps zur Verfügung.');
        end
    else
        begin
             TippAN:= false;
             memo1.text:= aktuellerOrt.beschreibung;
        end;
end;





procedure TForm1.ButtonMinispielClick(Sender: TObject);
begin


 If Minispiel = 1
then SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/Ampel.exe'), '''')
 else
 If Minispiel = 2
then SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/CanvasZeichnen.exe'), '''')
 else
 If Minispiel = 3
then SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/Geburtstagswunsch.exe'), '''')
 else
 If Minispiel = 4
then SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/klickzaehler.exe'), '''')
 else
 If Minispiel = 5
then SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/Palindrompruefer.exe'), '''')
 else
 If Minispiel = 6
then SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/Taschenlampe.exe'), '''')
 else
 If Minispiel = 7
then SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/WerWirdAbiturient.exe'), '''')
 else
 If Minispiel = 8
then SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/ZahlRaten.exe'), '''');

ButtonMinispiel.Visible := false;

end;



procedure TForm1.ButtonStoryClick(Sender: TObject);
begin
  memo1.text := 'Es ist ein ganz normaler Tag. Wie jeden Morgen lässt du deine Katze in den Garten. Plötzlich siehst du, wie sie auf das Haus deines bösen Nachbarn zuläuft. Du rennst hinterher, aber bist zu spät. Deine Katze ist in das Haus geschlichen. Das darf doch nicht wahr sein!  Schon letzte Woche ist sie in das Haus deines Nachbarn gelaufen. Dabei ist er ausgerastet. Die Beziehung zu den Nachbarn möchtest du nicht riskieren. Zwischen Nachbarn sollte man doch ein gutes Verhältnis haben. Du musst deine Katze wiederfinden, bevor dein Nachbar wiederkommt. Gehe schnell ins Haus! Viel Glück bei der Suche!';
end;

procedure TForm1.ButtonTutorialClick(Sender: TObject);
begin
  memo1.text := 'Damit du deine Katze findest, musst du durch die verschiedenen Räume bewegen. In diesem Textfeld wird dir angegeben, wo du dich befindest. Darunter erscheinen Buttons, welche die möglichen Wege zu Nachbarräumen angeben. Die anliegenden Räume können sich in den Richtungen Norden, Osten, Süden, Westen, Oben, Unten befinden. Zusätzlich gibt es in einigen Räumen Buttons für Objekte. Diese geben unterschiedliche Objekte an, hinter denen sich die Katze befinden kann. Es kann aber auch sein, dass dir diese Buttons andere Dinge zeigen. Manchmal erscheint auch ein Button mit der Aufschrift Minispiel. Dann hast du die Möglichkeit dieses Minispiel, so lange wie du willst, zu spielen. Aber du musst es nicht, da die Minispiele auf die Suche der Katze keinen Einfluss haben. Falls du an einer Stelle nicht weiter kommst, kannst du jederzeit den Tipp Button betätigen. Du kannst aber auch den Tutorial Button betätigen, falls dir die Steuerung nicht mehr ganz klar ist.';

end;
procedure TForm1.ButtonTutorial2Click(Sender: TObject);
begin
   if TutorialAN= false
      then
          begin
           memo1.text := 'Damit du deine Katze findest, musst du durch die verschiedenen Räume bewegen. In diesem Textfeld wird dir angegeben, wo du dich befindest. Darunter erscheinen Buttons, welche die möglichen Wege zu Nachbarräumen angeben. Die anliegenden Räume können sich in den Richtungen Norden, Osten, Süden, Westen, Oben, Unten befinden. Zusätzlich gibt es in einigen Räumen Buttons für Objekte. Diese geben unterschiedliche Objekte an, hinter denen sich die Katze befinden kann. Es kann aber auch sein, dass dir diese Buttons andere Dinge zeigen. Manchmal erscheint auch ein Button mit der Aufschrift Minispiel. Dann hast du die Möglichkeit dieses Minispiel, so lange wie du willst, zu spielen. Aber du musst es nicht, da die Minispiele auf die Suche der Katze keinen Einfluss haben. Falls du an einer Stelle nicht weiter kommst, kannst du jederzeit den Tipp Button betätigen. Du kannst aber auch den Tutorial Button betätigen, falls dir die Steuerung nicht mehr ganz klar ist.';
           TutorialAN:=true;
          end
      else
          begin
           memo1.text := aktuellerOrt.beschreibung;
           TutorialAN:= false;
          end;

end;
//Buttons der Minispiele am Ende des Spiels

procedure TForm1.ButtonMinispiel1Click(Sender: TObject);
begin
  SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/Ampel.exe'), '''');
end;

procedure TForm1.ButtonMinispiel2Click(Sender: TObject);
begin
  SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/CanvasZeichnen.exe'), '''');
end;

procedure TForm1.ButtonMinispiel3Click(Sender: TObject);
begin
  SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/Geburtstagswunsch.exe'), '''');
end;

procedure TForm1.ButtonMinispiel4Click(Sender: TObject);
begin
  SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/klickzaehler.exe'), '''');
end;

procedure TForm1.ButtonMinispiel5Click(Sender: TObject);
begin
   SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/Palindrompruefer.exe'), '''');
end;

procedure TForm1.ButtonMinispiel6Click(Sender: TObject);
begin
   SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/Taschenlampe.exe'), '''');
end;

procedure TForm1.ButtonMinispiel7Click(Sender: TObject);
begin
  SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/WerWirdAbiturient.exe'), '''');
end;

procedure TForm1.ButtonMinispiel8Click(Sender: TObject);
begin
   SysUtils.ExecuteProcess( UTF8ToSys( 'Minispiele/ZahlRaten.exe'), '''');
end;

end.

