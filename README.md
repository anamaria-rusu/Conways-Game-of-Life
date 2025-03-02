# 🧩 Conway's Game of Life în Assembly - x86

## 📌 Descriere  
Acest proiect implementează **Conway's Game of Life** utilizând **AT&T Assembly x86**. În plus, este implementată o metodă de criptare bazată pe **evoluțiile k ale jocului**, care transformă stările jocului într-un **șir de biți** pentru a crea un sistem de criptare. Folosind regulile jocului și evoluțiile aplicate unui **Sₖ** (matricea extinsă), se poate genera un **cheie criptografică** pentru criptarea și decriptarea mesajelor.

## 📖 Funcționalități principale
- Dezvoltarea aplicației **Conway's Game of Life** în **Assembly**, simulând evoluția celulelor într-o matrice bidimensională pe baza unor reguli simple.
  
  Reguli:
  - **Subpopulație**: O celulă vie cu mai puțin de două vecine vii moare în următoarea generație.
  - **Supraviețuire**: O celulă vie cu două sau trei vecini vii supraviețuiește.
  - **Suprapopulație**: O celulă vie cu mai mult de trei vecini vii moare.
  - **Creare**: O celulă moartă cu exact trei vecini vii devine vie.
  - **Stază**: Orice celulă moartă care nu respectă regula de creare rămâne moartă.

- **Criptare bazată pe evoluțiile jocului** – Definirea unei chei de criptare pornind de la o configurație inițială **S₀** și aplicând o **k-evoluție** pentru a produce un șir de biți. Criptarea unui mesaj **m** se face prin XOR între mesaj și cheia generată de joc.

- **Virtualizare și debugging** – Folosirea **Oracle VM VirtualBox** pentru a crea un mediu izolat de dezvoltare și **Linux** pentru debugging. **GDB** este utilizat pentru analiza stării registrelor și a fluxului de execuție.

## 🛠️ Tehnologii și concepte utilizate  
- **Limbaj de programare**: Assembly (AT&T x86)  
- **Criptare**: XOR, utilizând evoluțiile jocului pentru a genera chei criptografice  
- **Virtualizare**: Oracle VM VirtualBox  

## 📂 Structura proiectului  
1. **Codul jocului Life** – Implementarea algoritmului de actualizare a stării celulelor și evoluția acestora în funcție de reguli.  
2. **Generarea cheii criptografice** – Aplicarea evoluțiilor k pentru a obține un șir de biți utilizat pentru criptarea și decriptarea mesajelor.  
 
