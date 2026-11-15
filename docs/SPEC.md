# DREAM 6800 — specifica per il core

Distillata in F0 (2026-11-15) da: articoli Electronics Australia parti 1–4 (mag–ago 1979) ed
espansione 4K (dic 1980), `VDG_Timing_Diagram.jpg` (M.J. Bauer 1978), `CHIPOS68.asm`,
`CHIPOS_calls.pdf`, driver MAME `ausnz/d6800.cpp`. Tutto in `ref/` (non versionata).
**[STIMA]** = scelta nostra dove le fonti tacciono; da confermare con MAME o con le foto.

---

## 1. Clock

| Segnale | Valore | Fonte |
|---|---|---|
| Quarzo | 4,000 MHz sul generatore di clock MC6875 | EA parte 1 |
| CPU (φ1/φ2, E) | 4 MHz / 4 = **1,000 MHz** | EA, MAME |
| Clock dei punti | **2,000 MHz** (uscita ausiliaria del 6875), 500 ns per punto | schema tempi |
| Riga | 128 punti = **64 µs** | schema tempi |
| Campo | 312 righe = **19,968 ms (50,08 Hz)**, non interlacciato | schema tempi |

Nel core: `clk_sys` multiplo di 2 MHz, `ce_cpu` a 1 MHz, `ce_dot` a 2 MHz, in fase.

## 2. Mappa di memoria

| Indirizzi | Contenuto | Note |
|---|---|---|
| `0000–007F` | variabili CHIPOS e stack | `0000` vettore IRQ in RAM (CHIPOS ci mette `RTC`), `0002` BEGA, `0004` ENDA, `0006` ADRS, `0020` TIME, `0021` TONE, `0030–003F` V0–VF, stack CHIP-8 fino a `005F`, stack monitor fino a `007F` |
| `0080`, `0083` | gestori SWI e NMI facoltativi in RAM | vettori in ROM puntano lì |
| `0100–01FF` | **schermo** (256 byte = 64×32 bit) | letto dal video in DMA |
| `0200–` | programmi CHIP-8 / codice macchina | |
| RAM base | 1 KB `0000–03FF` | |
| RAM espansa | 4 KB `0000–0FFF` (scheda EA dic. 1980: A10–A11 scelgono il blocco da 1K, l'interprete indirizza 12 bit) | |
| `8010–8013` | **MC6821 PIA**: `8010` porta/DDR A, `8011` CRA, `8012` porta/DDR B, `8013` CRB | CHIPOS usa solo questi |
| `C000–C3FF` | **CHIPOS** (2708, 1 KB) | ripetuta su tutto `C000–FFFF`: i vettori a `FFF8–FFFF` sono gli ultimi 8 byte della ROM |

[STIMA] decodifica parziale come sulla scheda: RAM ripetuta ogni "dimensione RAM" in `0000–7FFF`;
PIA ripetuta in `8000–BFFF` (registri su A0–A1). Opzione OSD **RAM: 1K / 2K / 4K**, predefinito 4K.

Vettori (fine di CHIPOS): IRQ → `IRQ` (salto indiretto via `0000`), SWI → `0080`, NMI → `0083`,
RESET → `START` (monitor, `C3xx`). Partenza dell'interprete CHIP-8: **`C000`** (pulisce lo schermo,
PC CHIP-8 = `0200`); `C002` parte senza pulire.

## 3. Video (VDG a logica TTL)

Dallo schema dei tempi:

- **Orizzontale**: contatore punti 0–127. Punti **0–63 = immagine** (H64 basso), 8 byte per riga,
  un byte caricato nel registro a scorrimento (4014) ogni 8 punti (LOAD), **bit 7 a sinistra**.
  HOR-EN = H64 ritardato di ~600 ns (compensa l'accesso alla RAM): l'immagine è spostata di poco,
  irrilevante per noi. **HSYNC = punti 88–95** (H64·/H32·H16·H8), 4 µs.
- **Verticale**: righe contate a gruppi di 4 = "righe di punti" 0–77 (78 × 4 = 312), azzerate a 78.
  **Righe di punti 0–31 = immagine** (VERT-EN = /V64·/V32), cioè 128 righe TV.
  **VSYNC** = monostabile di ~300 µs che parte alla riga di punti 56 (V32·V16·V8).
  Quindi l'immagine comincia 22 righe di punti (88 righe TV) dopo il VSYNC.
- Ogni pixel è **4 righe × 1 punto** (500 ns × 4 righe ≈ quadrato su un TV PAL).
- Indirizzo del byte: `0x100 | (riga_di_punti << 3) | (punto >> 3)`.
- Video composito, positivo (bianco su nero), sincronismo negativo.

### DMA e arresto della CPU (decide la velocità dei giochi)

- Durante VERT-EN **la CPU è ferma**: VERT-EN pilota l'ingresso **HALT** del 6800; il video legge la
  RAM quando la CPU ha rilasciato il bus (**BA** alto apre i buffer degli indirizzi del video).
- È ferma per **tutte le 128 righe** dell'immagine (anche nei ritorni orizzontali): 128/312 = 41 %
  del tempo. CPU utile ≈ **590 kHz** (MAME usa proprio 589 744 Hz con lo schermo acceso).
- **DMA-ENAB = CB2 della PIA** (alto = acceso). Con CB2 basso VERT-EN è forzato basso: niente
  arresto, CPU a 1 MHz pieno, **schermo nero**. CHIPOS lo spegne solo durante la cassetta.
- Il 6800 vero, ricevuto HALT, **finisce l'istruzione in corso** (fino a 12 cicli) e solo dopo alza BA.
  Nel core: usare l'ingresso `halt` di `cpu68` (stessa semantica), non `hold`; il video legge la RAM
  comunque (in FPGA la RAM ha due porte), quindi niente spazzatura a inizio schermo [STIMA: sull'originale
  i primi byte della prima riga potevano essere sbagliati per qualche µs; ignorato].

## 4. PIA MC6821 — come la programma CHIPOS

### Porta A = tastierino

- DDR A = `F0`: **PA4–PA7 righe** in uscita (a 0), **PA0–PA3 colonne** in ingresso con pull-up interni.
- Un tasto premuto porta bassa una colonna → porta AND → **CA1 sale** (CRA = `06`: CA1 fronte di
  salita, interrupt disabilitato, si legge il flag in CRA bit 7).
- Decodifica (`KEYINP`): legge le colonne → bit 0–1 del codice; inverte i versi (DDR `0F`, colonne
  in uscita) e legge le righe → bit 2–3. **Codice = riga × 4 + colonna**, ritardo antirimbalzo
  3,33 ms. Nessun tasto o lettura sbagliata → flag BADRED e nuova attesa.
- **FN** = trigger di Schmitt (porta AND con reazione) su **CA2**, ingresso, flag sul **fronte di discesa**
  (CRA bit 6). GETKEY con FN restituisce `8C`.
- **RST** = reset all'ingresso POR del 6875 → reset della CPU (e della PIA, come in MAME).
- Matrice (dal driver MAME): riga 0 = `0 1 2 3`, riga 1 = `4 5 6 7`, riga 2 = `8 9 A B`, riga 3 = `C D E F`.
  Disposizione fisica dei tasti: tastierino Digitran 4×4; FN a destra e RST a sinistra, sopra il
  tastierino (EA parte 2). Disposizione esatta dei tasti → da foto (fase grafica).

### Porta B = cassetta, suono, orologio

- DDR B = `7F`: PB0–PB6 uscite, **PB7 ingresso** (dati dalla cassetta).
- **PB0** = dato seriale in uscita / frequenza del NE556 (LM566 sulla scheda): 1 = 2400 Hz, 0 = 1200 Hz.
- **PB6** = altoparlante acceso. L'altoparlante è muto quando CB2 (DMA) è basso.
- CRB = `3F` (schermo acceso) / `37` (spento): CB1 interrupt abilitato su **fronte di salita**,
  CB2 uscita manuale = DMA-ENAB.
- **CB1 = impulso a ogni campo** (50 Hz), genera l'IRQ dell'orologio: `RTC` decrementa TIME e TONE
  e legge PIAB per azzerare il flag. [STIMA] il fronte è il VSYNC (riga di punti 56); MAME lo dà
  al VBLANK.

## 5. Suono

- `BLEEP` = PB `41` (2400 Hz + altoparlante) per 4 tick = **80 ms**, poi PB `01`.
- CHIP-8 `FX18` (TONE = VX): bip a 2400 Hz di VX × 20 ms (CHIPOS aspetta la fine: è bloccante).
- Nel core: onda quadra 1200/2400 Hz, opzione volume; filtro passa-basso leggero per un suono da
  altoparlantino [STIMA].

## 6. Cassetta (Kansas City, 300 baud)

- Frequenze: **2400 Hz = 1 (mark)**, **1200 Hz = 0**; 300 bit/s.
- Byte = start (0) + 8 bit dal meno significativo + stop (1). Nessun header, nessun checksum:
  prima del caricamento l'utente scrive in `0002` l'inizio e in `0004` la fine+1 (big-endian),
  poi FN 1 (carica) o FN 2 (salva). Durante la cassetta CHIPOS spegne il DMA, quindi i ritardi
  software (3,33 ms per bit) sono esatti solo a **1 MHz pieni**.
- Demodulatore: comparatore (741) → monostabile 74121 di **312 µs** (3/4 di periodo a 2400 Hz) →
  flip-flop: se il segnale è ancora alto allo scadere → 1200 Hz. PB7 = 1 per 2400 Hz.
- Nel core: ingresso audio del MiSTer (ADC) con la stessa logica (misura del semiperiodo);
  uscita sull'audio sinistro/destro come l'originale (bip e cassetta escono dallo stesso NE556).
- I programmi di Bauer sono MP3 di nastri (`dream6800_programs_mp3.zip`): tutti CHIP-8 (carica a `0200`,
  parte da `C000`) tranne Dream Invaders (codice macchina, `0200`), dal suo read-me. `tools/tape2bin.py` li converte.

## 7. Interfaccia utente di CHIPOS (per i test)

- Dopo il reset: schermo con le ultime 7 righe di punti accese (`SHOADR` riempie da `01C8`) e
  l'indirizzo ADRS in cifre 3×5 in negativo alla riga 26 (`VY = 1A`), colonna 16.
- Comandi: 4 cifre esadecimali = indirizzo (aggiorna lo schermo solo alla 4ª); FN 0 = modifica
  memoria (2 cifre per byte, FN salta), FN 1 = carica da nastro, FN 2 = salva, FN 3 = esegui da ADRS.
- Avvio di un programma CHIP-8: RST, `C000`, FN, 3.
- `F000` in CHIP-8 = torna al monitor.

## 8. Caricamento rapido (nostro, come il quickload di MAME)

- File `.c8`/`.ch8`: copiati da `0200`, avvio da `C000` (interprete). File `.bin`: da `0200`, avvio
  da `0200` (codice macchina). Massimo `RAM − 0x200` byte.
- Meccanismo [STIMA]: CPU in reset mentre `ioctl` scrive la RAM; poi la CPU esce dal reset con il
  vettore di RESET sostituito per un solo prelievo (`C000` o `0200`), così CHIPOS non sovrascrive nulla.
  Variante da valutare in F1: mantenere `START` e simulare la sequenza di tasti.

## 9. Casi di test per F1 (Verilator, confronto con MAME)

Uscita del testbench: fotogrammi 64×32 in testo (`#`/`.`), più contatori (cicli CPU, tick RTC).

| # | Caso | Atteso |
|---|---|---|
| T1 | Reset → schermata del monitor | uguale a MAME al fotogramma 50 |
| T2 | Tasti `C 0 0 0` | indirizzo `C000` a schermo dopo la 4ª cifra, bip di 80 ms per tasto |
| T3 | FN 0 su `0200`, scrivo `F0 00`, RST, `C000` FN 3 | lo schermo si pulisce e torna al monitor |
| T4 | Generatore casuale (programma di EA parte 2 a `0200`) | stessi fotogrammi di MAME (semi uguali) |
| T5 | Dream Invaders (`invaders_code.bin`, `0200`, codice macchina) | fotogrammi uguali a MAME ai fotogrammi 100/300/600 |
| T6 | Tempi: ciclo CHIP-8 noto, misura dei fotogrammi fino alla fine | entro ±1 % di MAME; più esatto è il nostro (arresto a fine istruzione) |
| T7 | RTC | TIME scende di 1 ogni 19,968 ms |
| T8 | Cassetta in anello | FN 2 di `0200–02FF` → uscita audio → ingresso → FN 1 su `0300–03FF`, memoria identica |
| T9 | DMA spento (CRB `37`) | schermo nero, CPU a 1 MHz (ritardo di 1600 cicli = 1,6 ms) |

## 10. Dubbi aperti

1. Fronte di CB1: VSYNC o fine dell'immagine? Cambia di qualche ms la fase dell'orologio rispetto
   al disegno, non la frequenza. Confronto con MAME + articolo parte 1 (schema del circuito).
2. Decodifica di RAM e PIA (ripetizioni): schema del circuito, non leggibile nell'OCR; ininfluente
   per i programmi normali.
3. Disposizione fisica dei 16 tasti e dei due pulsanti: dalle foto.
4. ~~Velocità del `cpu68`~~ — verificata in F1: T6 dà 212 tick contro 211 di MAME (entro 1 tick,
   0,5 %); la cassetta (ritardi software a 1 MHz) carica il nastro originale di Bauer senza errori.
