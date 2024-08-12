#Stima dinamica dello stato di un sistema subacqueo
	Autori: Matteo Bonato, Luca Morello, Giovanni Paolicelli

Il programma è stato scritto per stimare la traiettoria di un drone subacqueo tramite l'applicazione del filtro di Kalman esteso (EKF) e del filtro a particelle (PF).

##Prerequisiti

1. MATLAB R2022b o versione superiore
2. Simulink R2022b Update 2 o versione superiore
3. Statistics and Machine Learning Toolbox di MATLAB

##Installazione

I file param.m, dataplot.m, smoothing.m e auv.slx devono essere tutti nella stessa directory per garantire l'esecuzione automatica degli script.
Per eseguire il programma è sufficiente aprire il modello Simulink auv.slx e avviare la simulazione con il pulsante Run.

##Descrizione dei file

Nel file param.m sono riportati i parametri del progetto e dei relativi filtri.
Il file dataplot.m viene utilizzato per la realizzazione dei grafici usati nella relazione.
Il file smoothing.m invece presenta l'algoritmo di smoothing di Rauch-Tung-Striebel per EKF.

##Come cambiare i parametri del progetto

1. MATLAB

Nel file param.m sono modificabili: 
	- i parametri relativi al drone (come massa e inerzia), le dimensioni dell'ambiente operativo, i disturbi sugli ingressi e sulle misure e la frequenza di campionamento dei sensori;
	- per il filtro di Kalman esteso può essere modificata la stima della posizione iniziale;
	- per il filtro a particelle può essere modificata la stima della posizione iniziale, il numero di particelle che verranno utilizzate dal filtro e il loro peso.

2. Simulink

Gli input del drone possono essere modificati nei relativi blocchi in ingresso al subsystem della dinamica.
Le condizioni iniziali del drone sono modificabili componente per componente (posizione e velocità) nei blocchi integratori nel subsystem della dinamica.