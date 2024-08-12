clear all;
clc;

%% Massa e Inerzia del modello
    m = 115;        %[kg]
    I = 5.98;       %[kg*m^2]

%% Coefficienti di resistenza
    C_lu=17.24;     % [kg/s]
    C_qu=106.03;    % [kg/m]

    C_lw=38.06;     % [kg/s]
    C_qw=84.1;      % [kg/m]

    C_lq=1.18;      % [kg*m^2]
    C_qq=7.51;      % [kg*m^2/rad^2]

%% Dimensioni ambiente di lavoro
    D1=300;         %[m]
    D2=50;          %[m]

%% Parametri globali di sample time | varianza usati nei blocchi simulink 

    % Varianze relative agli ingressi
    
    var_w_u = 0.1;      %[N^2]
    var_w_w = 0.1;      %[N^2]
    var_w_q = 0.05;     %[N^2*m^2]
    
    % Varianze relative ai sensori

    var_v_z = 0.4;              %[m^2]
    var_v_theta = 0.1;          %[rad^2]
    var_v_db = 0.2;             %[m^2] 

    % Frequenze dei sensori

    freq_z = 30;                %[Hz]
    freq_theta = 50;            %[Hz]
    freq_db = 40;               %[Hz]

    % Tempo di campionamento dei sensori (Simulink richiede sample time)

    T_z = 1/freq_z;             %[s]
    T_theta = 1/freq_theta;     %[s]
    T_db = 1/freq_db;           %[s]
    
    % Tempo di campionamento usato per i filtri, faccio lavorare i filtri
    % alla stessa frequenza del sensore più veloce
    sample_time = min([T_z T_theta T_db]);

%% EKF
    % Inizializzazione algoritmo
    P_init = eye(6);
    q_hat_init = 0;                   %[rad/s]
    w_hat_init = 0;                   %[m/s]
    u_hat_init = 0;                   %[m/s]
    theta_hat_init = pi/8*rand(1,1);  %[rad]
    z_hat_init = 20+10*rand(1,1);     %[m]
    x_hat_init = 140+20*rand(1,1);    %[m]

%% PARTICLE FILTER
    % Inizializzazione algoritmo
    N=10000;                              % Numero di particelle
    weights_init = 1/N*ones(N,1);         % Pesi (pdf uniforme)
 
    x_p=149+3*rand(N,1);                  % Condizioni iniziali per le particelle 
    z_p=24+2*rand(N,1);                   
    theta_p=(pi/16)*rand(N,1);             
    u_p=zeros(N,1);                          
    w_p=zeros(N,1);                       
    q_p=zeros(N,1);                       
    P0=0.1*eye(6);                        % Matrice di covarianza associata

    xi0=[x_p z_p theta_p u_p w_p q_p];
    particles_init = mvnrnd(xi0, P0, N);  % Genero le particelle