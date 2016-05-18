     function y = K(k,n,ro)
        if(n<=14)
            y=700;
        end
        if((n>14)&&(n<110))
             y=ro(n,k);
             for j=2:k-1
                if(y>ro(n,j));
                 y=ro(n,j);
                end
             end   
             if(y<150)
                 y=150;
             end
             disp(y);
         end
         
          if((n>=110)&&(n<250))
             y=ro(n,k);
             for j=2:k-1
                if(y>ro(n,j));
                 y=ro(n,j)+1;
                end
             end   
               if(y>150)
                 y=150;
                end
               if(y<60)
                   y=60;
               end
          end
          
          if((n>=250)&&(n<350))
              y=18;
          end
          
          if((n>=350)&&(n<1000))
              y=12;
          end
          
          if((n>=1000)&&(n<1500))
              y=2.5;
          end
          if((n>=1500))
             y=1.5;
          end
          if((n>=2500))
             y=1;
          end
         if((n>=4000))
             y=0.5;
         end
