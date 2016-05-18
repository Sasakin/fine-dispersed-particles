 function y = P_tfix_in_p(t,dt,x,P)
X=(t)*dt;
hold on;
plot(x,P(t,:));
grid on;
title(X );
xlabel('x , м' );
ylabel('P , Па');
gtext('в момент времени');
gtext(num2str(X));
gtext('секунд');
end