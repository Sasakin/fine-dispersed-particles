 function y = ro_tfix_in_p(P,dt,x,ro)
X=(P)*dt;
hold on;
plot(x,ro(P,:));
grid on;
title(X);
xlabel('x , м' );
ylabel('ro , kg/m^3');
gtext('в момент времени');
gtext(num2str(X));
gtext('секунд');
end

