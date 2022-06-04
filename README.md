# PIC-Programmierung mit PICkit 2 unter Linux
#### Von Manuel Lippert für den Kurs \enquote{Prozessrechner und Elektronik} an der Universität Bayreuth

## Content


## Einleitung
Die Programmierung eines PIC-Microchip unter Linux hat sich für mich als Linux-Nutzer damals zu einer kleinen Herausforderung entwickelt, weswegen ich versucht habe eine möglichst nahe Programmierung über den Terminal zu suchen. Diese Methode hat den Vorteil, dass man mit einem Editor seiner Wahl Assembler-Code schreiben kann und ihn einfach über Commands im Terminal ausführen kann.

In diesen kleinen Anleitung erkläre ich, wie man dieses Verfahren unter Linux (Ubuntu) aufsetzen lässt. In einem optionalen Schritt zeige ich noch weiterhin, wie man über Visual Studio Code seine Assembler Programmierung aufsetzen kann.

Bei Fragen stehe ich Ihnen gerne über [GitHub](https://github.com/Phi-Laboratorys/PBWP2-AssemblerVSCode) zur Verfügung. Schreiben sie einfach ein Issue zu Ihrem Problem.

## Compiler
Zuallererst benötigen wir einen Compiler welcher uns ```.asm```-Files in ```.hex```-Files kompiliert. Als Compiler benutzen wir das Packages ```gputils```, welches über den folgenden Befehl installiert werden kann:
```
sudo apt install gputils
```

Damit ist man nun in der Lage mithilfe von ```gpasm``` über den Terminal ```.asm```-Files zu kompilieren. Bei einem gegeben File ```foo.asm``` wäre dann der Befehl im Terminal:
```
gpasm foo.asm
```

Dabei entstehen 3 weitere Files ```foo.cod ```, ```foo.hex ``` (Dieses File wird benötigt) und ```foo.lst```. Damit ```foo.hex```-File auf den PIC-Microchip geladen werden kann wird das folgende Tool benötigt.

Wenn der Prozessor, in unserem Fall der PIC16F84A,  nicht in der ```.asm```-File mit dem Befehl ```processor	PIC16F84A``` definiert worden ist, kann dies in ```gpasm``` gemacht werden mit:
```
gpasm -p16f84a foo.asm
```

## pk2cmd

Das {\ttfamily pk2cmd} Commandline-Tool ermöglicht Linux (Es gibt auch eine Mac und Windows Version) mit dem PICkit 2 PIC-Microchip über den Terminal anzusteuern. Hier wird es dafür benötigt um den compilierten Assembler-Code auf den PIC-Microchip zu laden.

### Installation
[Quelle](https://www.making-sound.co.uk/tech-notes/pickit2-linux.html)

1) Zuerst ladet man die nötigen Pakete um {\ttfamily pk2cmd} zu installieren. Das erfolgt über diesen Befehl im Terminal:

