 function y = v_tfix_in_p(P,dt,x,v)
X=(P)*dt;
hold on;
plot(x,v(P,:));
grid on;
title(X);
xlabel('x , м' );
ylabel('v , м/сек');
gtext('в момент времени');
gtext(num2str(X));
gtext('секунд');
end