%% SMOOTHING 
    % Rinomino le variabili in uscita da Simulink
    sc=(out.csi_ekf.Data);             % Stima dello stato corretta (filtrata)           
    vp=(out.csi_pred.Data);            % Stima dello stato predetta
    P_correction=out.P_ekf.Data;       % Covarianza associata alla stima corretta (filtrata)
    P_prediction=out.P_pred.Data;      % Covarianza associata alla stima predetta
    F=out.F.Data;                      % Jacobiano F del modello di processo

    % Inizializzazione dello stato regolarizzato
    P_smooth(:,:,size(P_correction,3)) = P_correction(:,:,size(P_prediction,3));
    smoothed_state(size(sc,1),:) = sc(size(sc,1),:);

    % L'algoritmo parte dalle considerazioni finali operando a ritroso fino alle condizioni iniziali del filtro EKF
    % N.B. parto da n-1, la predizione fa riferimento alla stima filtrata al passo precedente 
    for k = size(vp,1)-1:-1:1
        % Applico l'algoritmo di Rauch-Tung-Striebel
        Ck = P_correction(:,:,k)*F(:,:,k+1)'/(P_prediction(:,:,k+1));
        smoothed_state(k,:)=sc(k,:)'+Ck*(smoothed_state(k+1,:)-vp(k+1,:))';
        P_smooth(:,:,k) = P_correction(:,:,k) + Ck*(P_smooth(:,:,k+1) - P_prediction(:,:,k+1))*Ck';
    end