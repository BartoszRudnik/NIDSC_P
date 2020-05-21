%-----------------------------------------
k = 1;       %liczba bit�w w message
n = 3;       %liczba bit�w w codeWord
size = 3;   %rozmiar wiadomo�ci
sigma = 20;   %odchylenie standardowe

%----------GENERATOR----------
message = randi([0,1],1,size) %tablica 0 i 1 o wielko�ci 1 x size

disp ('Wiadomo�� =') %wypisanie codeWord w Command Window
disp(message);
%----------KODER----------
codeWord = 1 : n * length(message); %rozmiar tablicy codeWord - n razy d�u�sza ni� message
m = 1; %zmienna pomocnicza 

for i = 1 : length(message) %p�tla przechodz�ca przez ca�� tablic� message
  for j= 1 : n %p�tla potrajaj�ca bity
    codeWord(m) = message(i);
    m++;
  endfor
endfor

disp ('S�owo kodowe =') %wypisanie codeWord w Command Window
disp(codeWord);
%----------KANA�----------
codeWordwNoise = codeWord + normrnd(0, sigma, [1, length(codeWord)]);
    
for i = 1 : length(codeWordwNoise)
  if codeWordwNoise(i) <= 0
    codeWordwNoise(i) = 0;
  else
    codeWordwNoise(i) = 1;
  endif
endfor

disp ('S�owo kodowe po przej�ciu przez kana� =') %wypisanie codeWordwNoise w Command Window
disp(codeWordwNoise);
%----------DEKODER----------
messageAfterTransmition = 1 : length(codeWordwNoise) / n; %tablica messageAfterTransmition - wiadomo�� po zdekodowaniu
u = 1; %zmienna pomocnicza
sum = 0; %suma bloku n - elementowego

for i = 1 : length(codeWordwNoise)
  if codeWordwNoise(i) == 1
    sum ++; %wyznaczanie sumy znak�w bloku n - elementowego
  endif
  if mod(i, n) == 0 %w momencie w kt�rym doszli�my do ko�ca bloku zostaje sprawdzona warto�� sumy
    if sum > 1
      messageAfterTransmition(u) = 1; %kombinacje takie jak: 011,101,110,111. Sum = 2 lub 3 (og�lnie > 1)
    else
      messageAfterTransmition(u) = 0; %kombinacje takie jak: 000,001,010,100. Sum = 0 lub 1 (og�lnie <= 1)
    endif
    sum = 0;
    u++;
  endif
endfor

disp ('Wiadomo�� po przej�ciu przez kana� =') %wypisanie messageAfterTransmition w Command Window
disp(messageAfterTransmition);
%----------WYNIKI PROGRAMU----------
errorBits = 0; %zmienna przechowuj�ca ilo�� bit�w przek�amanych

for i = 1 : length(codeWord)
  if codeWord(i) != codeWordwNoise(i) %por�wnanie s�owa kodowego przed i po przej�ciu przez kana�
    errorBits++; %zliczanie bit�w przek�amanych 
  endif
endfor

BER = errorBits / length(codeWord); %wyznaczenie BER = ilo�� bit�w b��dnie odebranych / ilo�� bit�w wys�anych 

disp ('Bit Error Rate =') %wypisanie warto�ci BER
disp(BER);
%-----------------------------------