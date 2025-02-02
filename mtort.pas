unit mTOrt;  //Klasse für die Erstellung der einzelnen Räume

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TOrt= class

    public
      //Beschreibung der einzelnen Räume
      beschreibung: string;
      //Richtungen, wo die angrenzenden Räume liegen können
      norden: TOrt;
      osten: TOrt;
      sueden: Tort;
      westen: TOrt;
      oben: TOrt;
      unten:Tort;

    public
      constructor create; virtual;
      //Set Methoden
      procedure setOrt(pNorden, pOsten, pSueden, pWesten, pOben, pUnten: TOrt; pBeschreibung: string); virtual;
      procedure setNorden (pNorden: TOrt); virtual;
      procedure setOsten (pOsten: TOrt); virtual;
      procedure setSueden (pSueden: TOrt); virtual;
      procedure setWesten (pWesten: TOrt); virtual;
      procedure setOben (pOben: TOrt); virtual;
      procedure setUnten (pUnten: TOrt); virtual;
      procedure setBeschreibung (pBeschreibung: string); virtual;
      //Get Methoden
      function getNorden: TOrt; virtual;
      function getOsten: TOrt; virtual;
      function getSueden: TOrt; virtual;
      function getWesten: TOrt; virtual;
      function getOben: TOrt; virtual;
      function getUnten: TOrt; virtual;
      function getBeschreibung: string; virtual;

 end;

implementation

constructor TOrt.create;
begin

end;

//set Methoden

procedure TOrt.setNorden (pNorden: TOrt);
begin
   Norden := pNorden;
end;

procedure TOrt.setOsten (pOsten: TOrt);
begin
   Osten := pOsten;
end;

procedure TOrt.setSueden (pSueden: TOrt);
begin
   Sueden := pSueden;
end;

procedure TOrt.setWesten (pWesten: TOrt);
begin
   Westen := pWesten;
end;

procedure TOrt.setOben (pOben: TOrt);
begin
   Oben := pOben;
end;

procedure TOrt.setUnten (pUnten: TOrt);
begin
   Unten := pUnten;
end;

procedure TOrt.setBeschreibung (pBeschreibung: string);
begin
   Beschreibung := pBeschreibung;
end;


procedure TOrt.setOrt(pNorden, pOsten, pSueden, pWesten, pOben, pUnten: TOrt; pBeschreibung: string);
begin
   setNorden(pNorden);
   setOsten(pOsten);
   setSueden(pSueden);
   setWesten(pWesten);
   setOben(pOben);
   setUnten(pUnten);
   setBeschreibung(pBeschreibung);

end;



//Get Mothoden
function TOrt.getNorden: TOrt;
begin
   result := Norden;
  end;
  function TOrt.getOsten: TOrt;
  begin
     result := Osten;
    end;

  function TOrt.getSueden: TOrt;
  begin
   result := Sueden;
  end;

  function TOrt.getWesten: TOrt;
begin
     result := Westen;
  end;

  function TOrt.getOben: TOrt;
  begin
   Result := Oben;
  end;

  function TOrt.getUnten: Tort;
  begin
     result := Unten;
  end;

  function TOrt.getBeschreibung: string;
  begin
     result := Beschreibung
  end;

end.

