figure(1);              % Traiettorie nel piano xz
tiledlayout(1,3)
nexttile
plot(out.x.Data,out.z.Data);
daspect([1 1 1]);
set(gca, 'YDir','reverse');
xlim([147.5 154.5]);
grid on;
title('Traiettoria');
xlabel('x [m]');
ylabel('z [m]');
nexttile
plot(out.csi_ekf.Data(:,1),out.csi_ekf.Data(:,2));
daspect([1 1 1]);
set(gca, 'YDir','reverse');
xlim([147.5 154.5]);
grid on;
title('Traiettoria, EKF');
xlabel('x [m]');
ylabel('z [m]');
nexttile
plot(out.csi_pf.Data(1,:),out.csi_pf.Data(2,:));
daspect([1 1 1]);
set(gca, 'YDir','reverse');
xlim([147.5 154.5]);
grid on;
title('Traiettoria, PF');
xlabel('x [m]');
ylabel('z [m]');

figure(2);              % Confronto traiettoria-filtri
tiledlayout(1,2)
nexttile
plot(out.x.Data,out.z.Data,'LineStyle','--');
hold on;
plot(out.csi_ekf.Data(:,1),out.csi_ekf.Data(:,2));
daspect([1 1 1]);
set(gca, 'YDir','reverse');
xlim([147.5 154.5]);
grid on;
%title('Traiettoria');
xlabel('x [m]');
ylabel('z [m]');
legend('Traiettoria','EKF','Location','southeast');
nexttile
plot(out.x.Data,out.z.Data,'LineStyle','--');
hold on;
plot(out.csi_pf.Data(1,:),out.csi_pf.Data(2,:));
daspect([1 1 1]);
set(gca, 'YDir','reverse');
xlim([147.5 154.5]);
grid on;
%title('Traiettoria, PF');
xlabel('x [m]');
ylabel('z [m]');
legend('Traiettoria','PF','Location','southeast');

figure(3);              % Errori di stima
tiledlayout(2,2)
nexttile                                                                                 
plot(out.csi_ekf.Time,out.x_disc.Data-out.csi_ekf.Data(:,1));                        
hold on;                                                     
plot(out.csi_ekf.Time,out.z_disc.Data-out.csi_ekf.Data(:,2));                                   
plot(out.csi_ekf.Time,out.theta_disc.Data-out.csi_ekf.Data(:,3));  
grid on;   
grid minor;
pbaspect([2 1 1]);
ylim([-0.4 0.4]);
title('Errore componenti posizione, EKF');
xlabel('t');
ylabel('m, rad');
legend('e_{x}','e_{z}','e_{\theta}'); 
legend('e_{x}','e_{z}','e_{\theta}');
nexttile
plot(out.csi_pf.Time,out.x_disc.Data-out.csi_pf.Data(1,:)');                            
hold on;                                                                                
plot(out.csi_pf.Time,out.z_disc.Data-out.csi_pf.Data(2,:)');                            
plot(out.csi_pf.Time,out.theta_disc.Data-out.csi_pf.Data(3,:)');                        
grid on;  
grid minor;
pbaspect([2 1 1]);
ylim([-0.4 0.4]);
title('Errore componenti posizione, PF');
xlabel('t');
ylabel('m, rad');
legend('e_{x}','e_{z}','e_{\theta}');
nexttile
plot(out.csi_ekf.Time,out.u_disc.Data-out.csi_ekf.Data(:,4));                                               
hold on;                          
plot(out.csi_ekf.Time,out.w_disc.Data-out.csi_ekf.Data(:,5));                                          
plot(out.csi_ekf.Time,out.q_disc.Data-out.csi_ekf.Data(:,6));                         
grid on;  
grid minor;
pbaspect([2 1 1]);
ylim([-0.4 0.4]);
title('Errore componenti velocità, EKF');
xlabel('t');
ylabel('m/s, rad/s');
legend('e_{u}','e_{w}','e_{q}'); 
nexttile                                                                          
plot(out.csi_pf.Time,out.u_disc.Data-out.csi_pf.Data(4,:)');                            
hold on;                                                                                        
plot(out.csi_pf.Time,out.w_disc.Data-out.csi_pf.Data(5,:)');                            
plot(out.csi_pf.Time,out.q_disc.Data-out.csi_pf.Data(6,:)');                          
grid on;
grid minor;
pbaspect([2 1 1]);
ylim([-0.4 0.4]);
title('Errore componenti velocità, PF');
xlabel('t');
ylabel('m/s, rad/s');
legend('e_{u}','e_{w}','e_{q}');

figure(4);              % RTS smoothing
tiledlayout(1,3)
nexttile
plot(smoothed_state(:,1),smoothed_state(:,2));
daspect([1 1 1]);
set(gca, 'YDir','reverse');
xlim([147.5 154.5]);
grid on;
xlabel('x [m]');
ylabel('z [m]');
nexttile
plot(out.csi_ekf.Data(:,1),out.csi_ekf.Data(:,2),'LineStyle','--');
hold on;
plot(smoothed_state(:,1),smoothed_state(:,2));
daspect([1 1 1]);
set(gca, 'YDir','reverse');
xlim([147.5 154.5]);
grid on;
title('Traiettoria, RTS-smoothed EKF');
xlabel('x [m]');
ylabel('z [m]');
legend('EKF','RTS','Location','southeast');
nexttile
plot(out.x.Data,out.z.Data,'LineStyle','--');
hold on;
plot(smoothed_state(:,1),smoothed_state(:,2));
daspect([1 1 1]);
set(gca, 'YDir','reverse');
xlim([147.5 154.5]);
grid on;
xlabel('x [m]');
ylabel('z [m]');
legend('Traiettoria','RTS','Location','southeast');
