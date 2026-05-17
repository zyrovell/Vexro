--Made by Zyrovell Roblox:Oyuncu15q Discord:_ege.
-- V3 Dynamic Theme / Added Emote Player Like Video Players
-- OPEN SOURCE FOREVER!

--[[



$$\    $$\ $$$$$$$$\ $$\   $$\ $$$$$$$\   $$$$$$\         $$$$$$\  $$\   $$\       $$$$$$$$\  $$$$$$\  $$$$$$$\        $$\ 
$$ |   $$ |$$  _____|$$ |  $$ |$$  __$$\ $$  __$$\       $$  __$$\ $$$\  $$ |      \__$$  __|$$  __$$\ $$  __$$\       $$ |
$$ |   $$ |$$ |      \$$\ $$  |$$ |  $$ |$$ /  $$ |      $$ /  $$ |$$$$\ $$ |         $$ |   $$ /  $$ |$$ |  $$ |      $$ |
\$$\  $$  |$$$$$\     \$$$$  / $$$$$$$  |$$ |  $$ |      $$ |  $$ |$$ $$\$$ |         $$ |   $$ |  $$ |$$$$$$$  |      $$ |
 \$$\$$  / $$  __|    $$  $$<  $$  __$$< $$ |  $$ |      $$ |  $$ |$$ \$$$$ |         $$ |   $$ |  $$ |$$  ____/       \__|
  \$$$  /  $$ |      $$  /\$$\ $$ |  $$ |$$ |  $$ |      $$ |  $$ |$$ |\$$$ |         $$ |   $$ |  $$ |$$ |                
   \$  /   $$$$$$$$\ $$ /  $$ |$$ |  $$ | $$$$$$  |       $$$$$$  |$$ | \$$ |         $$ |    $$$$$$  |$$ |            $$\ 
    \_/    \________|\__|  \__|\__|  \__| \______/        \______/ \__|  \__|         \__|    \______/ \__|            \__|
                                                                                                                           
                                                                                                                           
                                                                                                                           
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then return end

-- ===============================================================
-- SYNC CONFIGURATION  (Raspberry Pi URL ve API key'i buraya gir)
-- ===============================================================
return(function(...)local J={"\079\075\106\078\053\076\114\074\075\080\071\104\108\076\069\099\075\050\065\085\117\089\068\069\090\049\061\061","\104\066\087\049\118\066\084\117","\106\051\069\073\118\105\089\069\106\050\104\107\076\086\061\061";"\057\053\070\113\122\113\113\088\105\066\084\118\057\051\089\113","","\055\053\073\051\066\050\110\090\076\102\105\065\082\107\070\051","\114\111\099\087\114\071\084\067\113\110\115\102\104\066\070\083\113\075\113\061";"\104\050\097\043\104\066\072\047\089\111\121\061";"\055\051\105\108\114\078\089\075";"\089\083\070\108\089\057\061\061","\105\083\073\051\082\053\108\070\057\110\070\072\113\053\053\061";"\084\078\081\107\104\066\097\053\084\075\070\085\082\120\084\088","\105\050\070\108\055\050\105\088\121\071\069\075\104\050\105\107\104\050\105\053\121\057\061\061";"\111\072\097\073\114\051\069\075\106\086\061\061","\122\087\069\054\056\090\117\066\080\106\089\101\114\112\102\069\050\084\119\071\049\119\055\114\084\108\120\104\077\071\103\118\050\050\043\108\122\102\105\080\079\100\051\049\065\069\047\087\076\065\100\076\049\056\043\100\100\118\068\083\112\085\115\077\112\080\102\084\051\065\086\071\047\054\047\114\121\078\085\105\106\099\120\070\052\119\049\053\078\111\081\110";"\089\078\084\072\118\099\061\061","\089\053\073\108\069\113\075\056\105\105\067\090\069\053\069\110\104\110\049\061";"\114\066\070\110\098\086\061\061";"\089\051\115\052\114\078\121\061";"\106\066\072\089\098\111\084\113\106\103\082\110\105\075\070\053\114\086\061\061","\055\078\069\088\098\066\087\085","\113\105\070\067\084\103\069\050\076\065\116\074","\114\050\097\116\089\102\084\110\055\051\075\043\089\049\061\061";"\069\072\069\083\118\110\087\050\055\085\104\088\104\083\069\117\066\057\061\061";"\111\072\097\056\089\066\090\061";"\076\102\069\110\055\071\104\075\104\086\061\061";"\122\099\061\061","\057\085\075\122\057\083\097\066\055\065\069\111\098\078\067\090","\104\050\097\065\104\102\077\073\114\051\055\061","\055\083\105\110\114\066\105\110\118\111\069\116\118\051\115\075";"\055\051\070\043\089\050\097\108";"\114\103\071\061";"\113\051\116\069\089\103\069\105\118\051\073\115\084\050\097\117\122\071\090\061";"\122\047\099\075\089\068\067\073\122\099\061\061","\089\111\077\088\114\078\121\061";"\089\083\105\110\089\083\105\043\104\099\061\061","\110\056\053\069\117\086\050\084\122\116\074\071\068\050\102\048\115\112\057\100\104\053\088\049\075\122\068\084\089\048\048\109\107\057\084\053\055\049\065\072\104\111\067\103\097\066\043\071\099\049\097\113\073\043\080\119\097\048\081\048\110\097\053\067\051\083\067\061","\082\083\075\047\104\120\081\110\113\070\116\121\076\050\104\051","\111\072\097\085\118\049\061\061";"\111\072\097\108\089\111\069\116\104\050\070\047\114\050\113\061","\118\085\075\110\089\057\061\061";"\114\113\105\109\114\083\071\087\082\113\087\056\089\120\089\070\120\051\084\066";"\089\083\072\116\104\050\084\067";"\114\103\121\061","\114\050\105\043","\070\066\050\088\076\119\070\077\057\119\103\109\067\070\075\106","\104\050\070\047\114\050\113\061","\055\050\084\116\114\050\049\061";"\112\122\065\080\122\105\078\115\103\050\106\076\114\065\080\055";"\118\083\116\116\055\099\061\061","\118\083\097\043\118\083\070\110","\084\050\067\065\066\075\116\073\118\120\104\078\076\078\116\117\076\083\118\061"}local function U(U)return J[U-(641377+-595414)]end for U,q in ipairs({{162402+-162401;-286356+286408};{-902766-(-902767),505978-505927};{659344+-659292;943851-943799}})do while q[784797-784796]<q[419715+-419713]do J[q[295085+-295084]],J[q[539920-539918]],q[-1015077+1015078],q[544805-544803]=J[q[-160401+160403]],J[q[110080-110079]],q[373169-373168]+(581799+-581798),q[-1023886+1023888]-(649045-649044)end end do local U={Q=299988-299987;V=-365588+365588,N=963729+-963674,Z=-785627+785683,["\055"]=269069-269041;["\053"]=154065-154029,R=839178+-839166;U=188178+-188139,I=-682233+682274,M=-181042+181051;h=-542145+542174;F=-507765+507770,j=-192123+192153;n=841761+-841709,e=525295-525253,J=-578235+578246;X=-748726+748776,["\056"]=576061-576017;s=-526393-(-526442),g=644562-644559,l=-72568+72613,Y=-482293+482318,r=-240167-(-240194),z=650503-650489;b=-977062+977088;E=470300+-470283,["\048"]=-808567+808629,B=2310-2288;L=943833-943815,o=-647512+647535;["\049"]=-815279+815327;t=815459+-815426,q=470136-470116,k=-1008617+1008652,P=915570+-915507,c=598236-598204,G=-223103-(-223107),K=971949-971912,T=110079-110066,["\050"]=177698+-177692;w=7161+-7146;["\052"]=292534-292487,p=-38356+38387;S=-221704-(-221758),H=950333-950280,C=357043-357003;v=-49841-(-49865),i=425012+-424991;A=814116+-814065;x=819188-819169;m=494479-494469,f=-865483-(-865490);u=733885+-733842;a=1026579-1026518;["\051"]=-50432-(-50470);W=641584-641527;D=-784272-(-784274);d=648173+-648113,["\047"]=-341708+341742,["\054"]=825707-825649,y=552263+-552255;["\057"]=706167-706151;O=241722+-241663,["\043"]=-637631-(-637677)}local q=string.len local B=table.concat local l=string.sub local G=J local E=type local p=table.insert local d=math.floor local b=string.char for J=885906-885905,#G,727552-727551 do local f=G[J]if E(f)=="\115\116\114\105\110\103"then local E=q(f)local A={}local D=238852-238851 local r=-704188+704188 local a=328377+-328377 while D<=E do local J=l(f,D,D)local q=U[J]if q then r=r+q*(1006944-1006880)^((777260-777257)-a)a=a+(681499+-681498)if a==419952+-419948 then a=-202065+202065 local J=d(r/(7405-(-58131)))local U=d((r%(172015-106479))/(-342726-(-342982)))local q=r%(-80999-(-81255))p(A,b(J,U,q))r=715491+-715491 end elseif J=="\061"then p(A,b(d(r/(-170000+235536))))if D>=E or l(f,D+(365311-365310),D+(792946+-792945))~="\061"then p(A,b(d((r%(562529+-496993))/(275245-274989))))end break end D=D+(366320+-366319)end G[J]=B(A)end end end return(function(J,B,l,G,E,p,d,b,f,A,h,g,a,H,r,Y,D,x,q,e)f,e,x,H,a,q,g,D,A,r,h,Y,b={},function(J,U)local B=r(U)local l=function(...)return q(J,{...},U,B)end return l end,function(J,U)local B=r(U)local l=function(l)return q(J,{l},U,B)end return l end,function(J)f[J]=f[J]-(-940189-(-940190))if f[J]==337916-337916 then f[J],b[J]=nil,nil end end,function(J)local U,q=-510030-(-510031),J[1018350+-1018349]while q do f[q],U=f[q]-(-899699+899700),(-423744+423745)+U if f[q]==-817024-(-817024)then f[q],b[q]=nil,nil end q=J[U]end end,function(q,l,G,E)local X,m,j,N,T,y,D,K,V,u,W,o,r,c,d,F,i,L,Q,I,O,C,e,z,f,k,S,Z,n,R,M,a,v,w while q do if q<8843549-(-260525)then if q<5360829-89306 then if q<1930473-(-1043273)then if q<1848601-(-160706)then if q<536023-(-56483)then if q<185183-(-325589)then if q<-344530+644806 then q=true q=q and 3220036-1022081 or 6384101-(-25760)else K=g(13664921-728125,{})z=-671182-(-671247)Q=A()b[Q]=d m=617672-617669 q=b[y]d=q(m,z)q=-695747-(-695747)m=A()b[m]=d O=U(-514221+560231)z=q q=496605-496605 d=J[O]I=q O={d(K)}q={B(O)}O=q d=-96113-(-96115)q=O[d]d=U(-433262-(-479232))K=q Z=U(-672576+718567)q=J[d]C=b[r]k=J[Z]Z=k(K)k=U(-7415+53411)W=C(Z,k)C={W()}d=q(B(C))C=A()q=203195+1400397 b[C]=d d=703463+-703462 W=b[m]k=W W=1000940+-1000939 Z=W W=-738198-(-738198)j=Z<W W=d-Z end else f=U(424697-378703)d=U(-249640-(-295646))q=J[d]d=J[f]f=U(144131-98137)J[f]=q f=U(406224+-360218)q=8089380-(-1021176)J[f]=d f=b[G[-910546-(-910547)]]D=f()end else if q<215945-(-554713)then q=d and 545116+6550955 or 15986259-(-363207)else L=not j W=W+Z d=W<=k d=L and d L=W>=k L=j and L d=L or d L=5056674-120917 q=d and L d=364118+13269106 q=q or d end end else if q<-828128+3396501 then if q<704751+1806780 then Z=525038+-525037 j=-181568+181574 q=b[y]k=q(Z,j)q=U(-299781+345787)j=U(-334213+380219)J[q]=k Z=J[j]j=-809007-(-809009)q=Z>j q=q and-557444+17187153 or 12596380-709285 else r=b[G[-498296-(-498302)]]D=r==f q=786065+14875662 d=D end else if q<2779463-(-145944)then d={D}q=J[U(821813-775847)]else D=b[G[-261994+261996]]r=-291221-(-291234)f=D*r D=11048679003357-(-442172)d=f+D f=35184371522888-(-565944)q=d%f b[G[-432452-(-432454)]]=q D=-327701-(-327702)f=b[G[-836026+836029]]q=14627643-(-10310)d=f~=D end end end else if q<4505346-564531 then if q<557314+3281204 then if q<2682198-(-1030349)then if q<2757349-(-870354)then q=true q=q and 4258049-315157 or 709338+10838893 else f=U(-672659-(-718656))r=835269-835269 q=J[f]D=b[G[-225377-(-225385)]]f=q(D,r)q=-778811+13827131 end else y=556919+-556664 q={}b[G[-712499+712501]]=q d=b[G[221886+-221883]]e=-595341+35184372684173 a=d d=D%e M=U(-770412+816395)b[G[-39152+39156]]=d N=D%y y=456991+-456989 e=N+y b[G[-500390-(-500395)]]=e y=J[M]M=U(-338621+384628)N=y[M]y=N(f)N=U(188918-142951)m=328562+-328561 M=654691+-654690 r[D]=N N=512720+-512471 Q=y q=14308538-(-490332)z=m m=134497-134497 I=z<m m=M-z end else if q<3630364-(-273420)then C=#O j=-483200+483200 q=7373865-(-289530)K=C==j else r=U(-202653+248662)D=J[r]q=J[U(-957684-(-1003698))]r=U(810363+-764392)f=D[r]r=b[G[-637153+637154]]D={f(r)}d={B(D)}end end else if q<-107720+4719712 then if q<-992853+5035065 then q=398522+-122235 else q=b[G[274811+-274801]]D=b[G[-602707+602718]]f[q]=D q=b[G[576743+-576731]]D={q(f)}q=J[U(695058-649068)]d={B(D)}end else if q<910177+4025074 then q=J[U(957410+-911441)]d={}else L=A()R=U(471341+-425361)b[L]=W V=317782-317527 d=J[R]R=U(-734866+780859)o=1016835-1016735 q=d[R]R=843653+-843652 n=652786+-652786 d=q(R,o)R=A()c=687181-677181 o=-835669+835669 b[R]=d q=b[y]d=q(o,V)o=A()V=705912+-705911 b[o]=d i=48601-48600 q=b[y]v=b[R]d=q(V,v)u=112481+-112479 V=A()b[V]=d S=U(-493190-(-539181))d=b[y]v=d(i,u)d=129451-129450 q=v==d d=U(-100+46096)v=A()b[v]=q u=U(-628037-(-674026))w=J[S]F=b[y]q=U(-610627-(-656605))T={F(n,c)}q=K[q]S=w(B(T))w=U(789900+-743911)X=S..w i=u..X q=q(K,d,i)u=U(351983+-305973)i=A()X=h(-178653+12982401,{y,L;m,r,D,C;v,i,R;V;o,Q})b[i]=q d=J[u]u={d(X)}q={B(u)}u=q q=b[v]q=q and 11541703-(-572372)or 8254825-776984 end end end end else if q<7255485-(-432474)then if q<5724874-(-661492)then if q<6371744-209243 then if q<6136959-171067 then if q<6778972-971907 then j=-238652+238652 C=#O K=C==j q=K and 6086456-(-241299)or-922855+8586250 else b[D]=d q=7621108-(-687076)end else Q=217142-217140 D=b[G[750015-750012]]r=769685-769653 f=D%r a=b[G[886697+-886693]]z=-540295-(-540308)y=b[G[245080+-245078]]K=b[G[-979997-(-980000)]]O=K-f K=702587-702555 I=O/K m=z-I M=Q^m N=y/M e=a(N)a=4295079061-111765 r=e%a e=-863017-(-863019)a=e^f D=r/a a=b[G[247194+-247190]]M=-1005119+1005120 y=D%M M=-199086+4295166382 N=y*M e=a(N)Q=-457732-(-457988)a=b[G[990573-990569]]y=-786573-(-852109)N=a(D)r=e+N e=731988+-666452 D=nil a=r%e q=6718+3898298 N=r-a e=N/y y=912664+-912408 N=a%y M=a-N y=M/Q Q=65185-64929 a=nil r=nil M=e%Q z=903371-903115 f=nil m=e-M e=nil Q=m/z m={N,y;M,Q}b[G[1007109+-1007108]]=m M=nil y=nil Q=nil N=nil end else if q<-778368+7097585 then w=q T=362779-362778 F=u[T]T=false S=F==T X=S q=S and 9359141-899275 or 12862482-(-520566)else R=U(462338+-416346)K={}C=A()a=nil O=nil u=U(741237-695235)b[C]=K z=nil M=nil L=A()j=h(541745+10334458,{C;Q,m,e})o={}v=U(894935+-848959)K=A()M=25486079274734-(-704365)b[K]=j S=nil e=H(e)e=U(-157942-(-203940))N=nil j={}b[L]=j j=J[R]i=b[L]V={[v]=i,[u]=S}y=nil R=j(o,V)q=J[U(-874066+920052)]j=Y(929456+15447324,{L;C;I,Q,m;K})K=H(K)r=j m=H(m)L=H(L)D=R I=H(I)a=J[e]z=25057967174843-689959 y=U(-735457-(-781465))Q=H(Q)Q=454267+15635547762165 e=a()C=H(C)N=r(y,M)a=D[N]M=U(-756180+802179)y=r(M,Q)N=D[y]e[a]=N M=26533671667608-(-960683)e=U(809444+-763446)y=U(632373+-586362)d={}a=J[e]e=a()Q=-697520+25156517646962 N=r(y,M)M=U(434772-388757)a=D[N]y=r(M,Q)N=D[y]e[a]=N y=U(390148-344176)e=U(-952448+998433)m=U(568131+-522154)a=J[e]N=J[y]Q=r(m,z)M=D[Q]Q=U(384512+-338524)r=nil D=nil Q=N[Q]y={Q(N,M)}e=a(B(y))a=e()end end else if q<7413125-(-63483)then if q<7803220-877967 then q=J[U(-967661+1013656)]d={}else d=U(-741123-(-787093))q=J[d]f=b[G[-252871+252875]]a=U(373004+-327013)Q=g(11924671-(-805825),{})r=J[a]M=U(-406553+452563)y=J[M]M={y(Q)}N={B(M)}y=-247080-(-247082)e=N[y]a=r(e)r=U(-458555+504551)D=f(a,r)f={D()}d=q(B(f))f=d D=b[G[-107569-(-107574)]]d=D q=D and 2921449-401919 or 15354546-(-307181)end else if q<6710512-(-810766)then w=b[D]q=w and-990309+10096222 or-42159+13541575 X=w else C=484330+-484329 o=-472254+472255 j=#O K=a(C,j)C=N(O,K)j=b[I]K=nil q=6557041-926372 R=C-o L=y(R)j[C]=L C=nil end end end else if q<9148507-829068 then if q<7580159-(-440930)then if q<8111942-123835 then if q<-35896+7771513 then M=m Z=U(668428+-622445)k=J[Z]Z=U(-9422-(-55425))W=k[Z]k=W(f,M)W=b[G[612292+-612286]]Z=W()C=k+Z K=C+N C=586637+-586381 O=K%C C=r[D]N=O q=531126+14267744 M=nil Z=390132-390131 k=N+Z W=a[k]K=C..W r[D]=K else f=U(-1001315-(-1047290))d=U(-576532+622529)q=J[d]d=q(f)d={}q=J[U(1006583-960609)]end else q=3447803-553164 end else if q<361195+7892651 then f=l r=U(626128-580145)D=A()q=true y=U(-323275-(-369285))b[D]=q e=A()d=J[r]r=U(830113-784108)q=d[r]r=A()a=A()b[r]=q q=x(-496372+8471445,{})M=h(11592782-451541,{e})b[a]=q q=false b[e]=q N=J[y]y=N(M)q=y and 12942514-933221 or 10744432-(-776359)d=y else o=H(o)R=H(R)i=H(i)u=nil L=H(L)V=H(V)v=H(v)q=2558457-954865 end end else if q<47992+8410897 then if q<-569738+9006225 then C=C+L K=C<=j o=not R K=o and K o=C>=j o=R and o K=o or K o=11334726-(-569505)q=K and o K=4260494-390218 q=q or K else M=306052-306052 D=r q=b[G[141619+-141618]]Q=-567116-(-567371)y=q(M,Q)f[D]=y q=16431619-490099 D=nil end else if q<-222636+9186640 then T=-550709-(-550711)F=u[T]T=b[i]S=F==T q=12669833-(-713215)X=S else q=956492+-680205 end end end end end else if q<-917735+13703474 then if q<10705600-(-869159)then if q<10168190-(-971031)then if q<11018968-320449 then if q<8634926-(-548701)then if q<8354233-(-755620)then S=-439089+439090 w=u[S]q=13271214-(-228202)X=w else q=true q=q and-884615+1433557 or-102020+4722713 end else r=-135681+135682 D=b[G[877432+-877429]]f=D~=r q=f and 6622046-519074 or 14259640-(-378313)end else if q<-917301+11937918 then f=b[G[217333-217332]]d=#f f=879806-879806 q=d==f q=q and 3225592-295618 or-138578+4043594 else d=Q q=m q=Q and 293876-(-26219)or 14354849-131665 end end else if q<11708887-317311 then if q<510277+10781992 then q=true b[G[-202605-(-202606)]]=q q=J[U(-192071+238071)]d={}else O=U(870639+-824630)I=J[O]O=U(894733-848769)q=11160879-110577 z=I[O]Q=z end else if q<1016338+10523823 then N=d y=U(924239-878259)d=J[y]y=U(-100346-(-146339))M=U(-558740+604749)q=d[y]y=A()b[y]=q d=J[M]M=U(12241-(-33772))I=U(794431-748422)q=d[M]m=q z=J[I]M=q Q=z q=z and 349226+10946622 or 10426367-(-623935)else q=Y(915732+11400396,{a})k={q()}q=J[U(241315-195347)]d={B(k)}end end end else if q<-376367+12552282 then if q<12345716-432681 then if q<-571225+12472964 then if q<971712+10755380 then b[D]=W q=b[D]q=q and 107502+15212503 or-757790+13030389 else j=U(-767373+813379)q=J[j]j=U(1092649-1046655)J[j]=q q=9278047-271238 end else q=876240+7517239 K=C o=K O[K]=o K=nil end else if q<12689307-609359 then N=b[e]d=N q=132690+11388101 else X=b[D]q=X and 5536674-(-781464)or 313121+5531599 d=X end end else if q<-174884+12529548 then if q<-1039768+13341321 then q=true q=10533462-(-1014769)else q=-691132+9801688 end else if q<12570948-137290 then r=H(r)e=H(e)D=H(D)N=nil N=U(-193686+239666)D=nil C=H(C)z=nil M=nil y=H(y)O=nil K=nil y=U(-257200-(-303180))m=H(m)e=J[N]a=H(a)K=929693+-929692 Q=H(Q)N=U(1045619+-999638)Q=U(544165+-498182)M=U(-847701-(-893710))r=nil a=e[N]I=nil e=A()b[e]=a N=J[y]y=U(988903+-942910)a=N[y]q=398911+7994568 y=J[M]M=U(758393+-712422)O={}N=y[M]M=J[Q]Q=U(990268+-944256)C=-159057-(-159313)y=M[Q]Q=A()I=A()m=A()M=-419551-(-419551)z={}b[Q]=M M=875448+-875446 b[m]=M M={}b[I]=z z=79272-79272 j=C C=-707886-(-707887)L=C C=-947009+947009 R=L<C C=K-L else r=-230352+1085115 D=U(963604+-917600)d=579063-360543 f=D^r q=d-f d=U(563308-517335)f=q q=d/f d={q}q=J[U(312582-266600)]end end end end else if q<182225+14821173 then if q<-607136+14210566 then if q<110566+12984705 then if q<-703025+13655829 then if q<-535944+13341213 then e=-1010977+1010979 D=b[G[450174-450173]]a=290128-290127 r=D(a,e)D=-894165-(-894166)f=r==D q=f and-775923+1497126 or 15443013-(-693748)d=f else d=1019933+10961687 D=U(-144370+190335)r=-646157+4297808 f=D^r q=d-f d=U(-269293+315277)f=q q=d/f d={q}q=J[U(-83191+129170)]end else q={}r=b[G[-303170+303179]]f=q q=910319+15031201 D=-508386+508387 a=r r=697593-697592 e=r r=431215-431215 N=e<r r=D-e end else if q<807638+12607087 then d=X q=w q=5337411-(-507309)else b[D]=X n=-228478-(-228479)T=b[V]F=T+n S=u[F]w=z+S S=538094-537838 q=w%S z=q F=b[o]q=-770303+9078487 S=I+F F=-988663+988919 w=S%F I=w end end else if q<14856936-497209 then if q<14349658-281782 then k=b[D]W=k q=k and 1002437+14999058 or-366869+11992312 else m=U(-74586+120550)Q=J[m]q=-767585+1087680 d=Q end else if q<13796839-(-903164)then D=b[G[-634154-(-634157)]]r=-305369-(-305452)f=D*r D=-599049+599306 d=f%D b[G[177357-177354]]=d q=-458299+9798134 else O=not I m=m+z M=m<=Q M=O and M O=m>=Q O=I and O M=O or M O=8235569-530576 q=M and O M=-901872+16558310 q=q or M end end end else if q<983926+15152571 then if q<16091922-246180 then if q<835039+14822360 then if q<15744773-115322 then q=171462+12212465 else a=nil y=nil q=-812584+3707223 N=nil end else f=nil b[G[342832-342827]]=d q=16637514-288048 end else if q<15521057-(-445162)then r=r+e y=not N D=r<=a D=y and D y=r>=a y=N and y D=y or D y=12362+8435147 q=D and y D=4068186-(-542763)q=q or D else q=12071683-446240 k=z==I W=k end end else if q<-1001265+17365076 then if q<15364568-(-963111)then q=783384+-62181 D=b[G[698142-698140]]r=b[G[-455243+455246]]f=D==r d=f else q=b[G[-946015+946022]]q=q and-553933+4248494 or 12297965-(-750355)end else if q<16815604-363914 then D=l[-329850+329852]q=b[G[-684941+684942]]f=l[-810944+810945]r=q q=r[D]q=q and 39557+7953486 or 807549+3027168 else Z=U(441974+-395983)L=U(-620528-(-666522))q=J[Z]j=J[L]Z=q(j)q=U(462644-416638)J[q]=Z q=9199626-192817 end end end end end end end q=#E return B(d)end,function(J,U)local B=r(U)local l=function()return q(J,{},U,B)end return l end,-285986+285986,function()D=D+(-180935-(-180936))f[D]=30735-30734 return D end,function(J)for U=-933662-(-933663),#J,-553569+553570 do f[J[U]]=(784915+-784914)+f[J[U]]end if l then local q=l(true)local B=E(q)B[U(-526070-(-572046))],B[U(-97452+143453)],B[U(581038-535051)]=J,a,function()return 1701474-(-760592)end return q else return G({},{[U(-72300-(-118301))]=a;[U(598867-552891)]=J;[U(1073603-1027616)]=function()return 2788572-326506 end})end end,function(J,U)local B=r(U)local l=function(l,G)return q(J,{l,G},U,B)end return l end,function(J,U)local B=r(U)local l=function(l,G,E,p,d)return q(J,{l;G;E;p;d},U,B)end return l end,{}return(e(-1029400+9173496,{}))(B(d))end)(getfenv and getfenv()or _ENV,unpack or table[U(428833+-382869)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
local old = playerGui:FindFirstChild("VexroEmotes")
if old then old:Destroy() end

-- ===============================================================
-- DATA SYSTEM
-- ===============================================================

local DATA_FILE = "VexroEmotes_Data.json"
local Settings = {theme = "Dark", speed = 1, notifications = true, loopEmote = true, language = nil, copyEmoteEnabled = false}
local Favorites = {}
local RecentEmotes = {}
-- Bridge: _VexroExtend içindeki HUD fonksiyonlarını dış kapsama bağlar
local _onSpeedChanged  -- function(); HUD hız butonlarını + info panel'i günceller
local MAX_RECENT = 20

local function SaveData()
	pcall(function()
		if writefile then
			writefile(DATA_FILE, HttpService:JSONEncode({
				favorites = Favorites,
				recent = RecentEmotes,
				settings = Settings
			}))
		end
	end)
end

local function LoadData()
	pcall(function()
		if readfile and isfile and isfile(DATA_FILE) then
			local data = HttpService:JSONDecode(readfile(DATA_FILE))
			if data then
				-- FIX: ID'leri sayıya çevirerek yüklüyoruz (String hatasını önler)
				Favorites = {}
				if data.favorites then
					for _, v in pairs(data.favorites) do
						table.insert(Favorites, tonumber(v)) 
					end
				end
				
				RecentEmotes = {}
				if data.recent then
					for _, v in pairs(data.recent) do
						table.insert(RecentEmotes, tonumber(v))
					end
				end

				if data.settings then
					Settings.theme = data.settings.theme or "Dark"
					Settings.speed = data.settings.speed or 1
					Settings.notifications = data.settings.notifications ~= false
					Settings.loopEmote = data.settings.loopEmote ~= false
					Settings.language = data.settings.language or nil
					Settings.copyEmoteEnabled = data.settings.copyEmoteEnabled == true
				end
			end
		end
	end)
end

LoadData()

-- ===============================================================
-- SYNC HELPERS
-- ===============================================================

local function _httpRequest(options)
	if request then return request(options) end
	if http and http.request then return http.request(options) end
	if syn and syn.request then return syn.request(options) end
	return nil
end

local function SyncPush()
	if SYNC_URL == "" then return end
	task.spawn(function()
		pcall(function()
			_httpRequest({
				Url     = SYNC_URL .. "/favorites",
				Method  = "POST",
				Headers = {
					["Content-Type"] = "application/json",
					["X-Api-Key"]    = SYNC_API_KEY,
				},
				Body = HttpService:JSONEncode({
					userId    = tostring(player.UserId),
					favorites = Favorites,
				}),
			})
		end)
	end)
end

local _syncLoaded = false
local function SyncPull(onDone)
	if SYNC_URL == "" then return end
	task.spawn(function()
		local ok, res = pcall(function()
			return _httpRequest({
				Url     = SYNC_URL .. "/favorites?userId=" .. tostring(player.UserId),
				Method  = "GET",
				Headers = { ["X-Api-Key"] = SYNC_API_KEY },
			})
		end)
		if not ok or not res or res.StatusCode ~= 200 then return end
		local parsed = pcall(function()
			local data = HttpService:JSONDecode(res.Body)
			if not data or not data.favorites then return end
			-- Sunucudan gelen favorilerle yerel listeyi birleştir (sunucu öncelikli)
			local newFavs = {}
			local newSet  = {}
			for _, idRaw in ipairs(data.favorites) do
				local id = tonumber(idRaw)
				if id and not newSet[id] and #newFavs < MAX_FAVORITES then
					newSet[id] = true
					newFavs[#newFavs + 1] = id
				end
			end
			Favorites    = newFavs
			FavoritesSet = newSet
			SaveData()
			_syncLoaded  = true
		end)
		if onDone then task.defer(onDone) end
	end)
end

-- Hash set for O(1) favorite lookups
local FavoritesSet = {}
for _, v in ipairs(Favorites) do FavoritesSet[v] = true end

-- Lookup table for O(1) emote-by-ID access (populated after emotes load)
local EmotesById = {}

-- Cache for async-fetched Roblox catalog metadata (keyed by numeric asset ID)
local _emoteMetaCache = {}

-- ===============================================================
-- UTILITIES
-- ===============================================================

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Auto Image/Decal resolver with cache
local _resolvedCache = {}
local function ResolveAssetImage(assetIdOrUrl)
	if not assetIdOrUrl then return "" end
	local str = tostring(assetIdOrUrl)
	local rawId = str:gsub("rbxassetid://", ""):gsub("[^%d]", "")
	if rawId == "" then return str end
	if _resolvedCache[rawId] then return _resolvedCache[rawId] end
	local resolved = nil
	pcall(function()
		local objects = game:GetObjects("rbxassetid://" .. rawId)
		if objects and #objects > 0 then
			local obj = objects[1]
			if obj:IsA("Decal") or obj:IsA("Texture") then
				resolved = obj.Texture
			elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
				resolved = obj.Image
			end
		end
	end)
	if not resolved or resolved == "" then
		resolved = "rbxthumb://type=Asset&id=" .. rawId .. "&w=420&h=420"
	end
	_resolvedCache[rawId] = resolved
	return resolved
end

local logo = [[

                                                                                  
                                                                               ▄▄ 
██  ██ ██████ ██  ██ █████▄  ▄████▄   ▄████▄ ███  ██   ██████ ▄████▄ █████▄    ██ 
██▄▄██ ██▄▄    ████  ██▄▄██▄ ██  ██   ██  ██ ██ ▀▄██     ██   ██  ██ ██▄▄█▀    ██ 
 ▀██▀  ██▄▄▄▄ ██  ██ ██   ██ ▀████▀   ▀████▀ ██   ██     ██   ▀████▀ ██        ▄▄ 
                                                                                                                                                                                                            
]]

print(logo)

-- ===============================================================
-- THEMES
-- ===============================================================

local Themes = {
	Dark = {
		primary = Color3.fromRGB(12, 12, 16),
		secondary = Color3.fromRGB(18, 18, 24),
		tertiary = Color3.fromRGB(26, 26, 34),
		sidebar = Color3.fromRGB(10, 10, 14),
		accent = Color3.fromRGB(180, 180, 180),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(150, 150, 160),
		stroke = Color3.fromRGB(60, 60, 80),
		critical = Color3.fromRGB(220, 60, 60),
		success = Color3.fromRGB(80, 200, 100)
	},
	Purple = {
		primary = Color3.fromRGB(12, 8, 20),
		secondary = Color3.fromRGB(20, 15, 34),
		tertiary = Color3.fromRGB(30, 22, 50),
		sidebar = Color3.fromRGB(15, 10, 26),
		accent = Color3.fromRGB(138, 43, 226),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(180, 160, 220),
		stroke = Color3.fromRGB(75, 0, 130),
		critical = Color3.fromRGB(255, 60, 100),
		success = Color3.fromRGB(100, 240, 120)
	},
	Blue = {
		primary = Color3.fromRGB(8, 12, 22),
		secondary = Color3.fromRGB(16, 22, 38),
		tertiary = Color3.fromRGB(24, 32, 54),
		sidebar = Color3.fromRGB(10, 16, 30),
		accent = Color3.fromRGB(0, 160, 255),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(150, 180, 220),
		stroke = Color3.fromRGB(30, 80, 160),
		critical = Color3.fromRGB(250, 60, 80),
		success = Color3.fromRGB(60, 230, 140)
	},
	Green = {
		primary = Color3.fromRGB(8, 16, 12),
		secondary = Color3.fromRGB(14, 28, 20),
		tertiary = Color3.fromRGB(22, 40, 30),
		sidebar = Color3.fromRGB(10, 22, 14),
		accent = Color3.fromRGB(0, 230, 120),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(160, 220, 180),
		stroke = Color3.fromRGB(30, 120, 60),
		critical = Color3.fromRGB(240, 80, 80),
		success = Color3.fromRGB(120, 255, 120)
	},
	Red = {
		primary = Color3.fromRGB(22, 8, 10),
		secondary = Color3.fromRGB(36, 14, 18),
		tertiary = Color3.fromRGB(50, 20, 26),
		sidebar = Color3.fromRGB(28, 10, 12),
		accent = Color3.fromRGB(255, 60, 80),
		text = Color3.new(1, 1, 1),
		textDim = Color3.fromRGB(220, 160, 170),
		stroke = Color3.fromRGB(150, 40, 60),
		critical = Color3.fromRGB(255, 30, 30),
		success = Color3.fromRGB(80, 240, 100)
	},
	Light = {
		primary = Color3.fromRGB(240, 240, 245),
		secondary = Color3.fromRGB(250, 250, 255),
		tertiary = Color3.fromRGB(255, 255, 255),
		sidebar = Color3.fromRGB(235, 235, 242),
		accent = Color3.fromRGB(90, 90, 110),
		text = Color3.fromRGB(30, 30, 36),
		textDim = Color3.fromRGB(120, 120, 130),
		stroke = Color3.fromRGB(200, 200, 215),
		critical = Color3.fromRGB(220, 60, 60),
		success = Color3.fromRGB(60, 180, 80)
	},
	MaterialYou = {
		primary = Color3.fromRGB(17, 19, 27),
		secondary = Color3.fromRGB(25, 28, 40),
		tertiary = Color3.fromRGB(33, 37, 52),
		sidebar = Color3.fromRGB(13, 15, 22),
		accent = Color3.fromRGB(130, 177, 255),
		text = Color3.fromRGB(225, 228, 240),
		textDim = Color3.fromRGB(140, 145, 165),
		stroke = Color3.fromRGB(55, 65, 92),
		critical = Color3.fromRGB(255, 130, 120),
		success = Color3.fromRGB(120, 210, 160)
	}
}

local currentTheme = Themes[Settings.theme] or Themes.Dark
local themeElements = {}
local mainStrokeGrad, miniIconGrad -- Forward declaration for the theme system
local UpdateTabStyles
local UpdateTabData

local function RegisterTheme(el, prop, key)
	if el then themeElements[#themeElements + 1] = {el = el, prop = prop, key = key} end
end

local function Notify(title, text)
	if not Settings.notifications then return end
	pcall(function()
		local screenGui = playerGui:FindFirstChild("VexroEmotes") or game:GetService("CoreGui"):FindFirstChild("VexroEmotes")
		if not screenGui then
			game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = text, Duration = 3})
			return
		end
		
		local container = screenGui:FindFirstChild("NotificationContainer")
		if not container then
			container = Instance.new("Frame")
			container.Name = "NotificationContainer"
			container.Size = UDim2.new(0, 300, 1, -40)
			container.Position = UDim2.new(0.5, -150, 0, 20)
			container.BackgroundTransparency = 1
			container.ZIndex = 30000
			container.Parent = screenGui
			
			local uiList = Instance.new("UIListLayout")
			uiList.Padding = UDim.new(0, 10)
			uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
			uiList.VerticalAlignment = Enum.VerticalAlignment.Top
			uiList.Parent = container
		end
		
		local theme = currentTheme or Themes.Dark
		
		-- Wrapper for animation compatibility with UIListLayout
		local wrapper = Instance.new("Frame")
		wrapper.BackgroundTransparency = 1
		wrapper.Size = UDim2.new(1, 0, 0, 60)
		wrapper.ClipsDescendants = true
		wrapper.Parent = container
		
		local toast = Instance.new("Frame")
		toast.Size = UDim2.new(1, 0, 1, 0)
		toast.Position = UDim2.new(0, 0, -1, -20)
		toast.BackgroundColor3 = theme.secondary
		toast.ZIndex = 30001
		toast.Parent = wrapper
		Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 10)
		
		local toastStroke = Instance.new("UIStroke")
		toastStroke.Color = theme.stroke
		toastStroke.Thickness = 2
		toastStroke.Parent = toast
		
		local titleLbl = Instance.new("TextLabel")
		titleLbl.Size = UDim2.new(1, -15, 0, 25)
		titleLbl.Position = UDim2.new(0, 10, 0, 5)
		titleLbl.BackgroundTransparency = 1
		titleLbl.Text = title
		titleLbl.Font = Enum.Font.GothamBold
		titleLbl.TextSize = 15
		titleLbl.TextColor3 = theme.text
		titleLbl.TextXAlignment = Enum.TextXAlignment.Left
		titleLbl.ZIndex = 30002
		titleLbl.Parent = toast
		
		local textLbl = Instance.new("TextLabel")
		textLbl.Size = UDim2.new(1, -15, 0, 25)
		textLbl.Position = UDim2.new(0, 10, 0, 30)
		textLbl.BackgroundTransparency = 1
		textLbl.Text = text
		textLbl.Font = Enum.Font.Gotham
		textLbl.TextSize = 13
		textLbl.TextColor3 = theme.textDim
		textLbl.TextXAlignment = Enum.TextXAlignment.Left
		textLbl.TextWrapped = true
		textLbl.ZIndex = 30002
		textLbl.Parent = toast
		
		-- Tween inside wrapper
		TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
		
		task.delay(3, function()
			local outTween = TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, -1, -20)})
			outTween:Play()
			task.wait(0.4)
			wrapper:Destroy()
		end)
	end)
end

local function ApplyTheme(name)
	currentTheme = Themes[name] or Themes.Dark
	-- Clean up destroyed elements and apply theme
	local alive = {}
	for i = 1, #themeElements do
		local t = themeElements[i]
		if t.el and t.el.Parent then
			alive[#alive + 1] = t
			if currentTheme[t.key] then
				pcall(function()
					TweenService:Create(t.el, TweenInfo.new(0.3), {[t.prop] = currentTheme[t.key]}):Play()
				end)
			end
		end
	end
	themeElements = alive
	
	if mainStrokeGrad then
		mainStrokeGrad.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, currentTheme.stroke),
			ColorSequenceKeypoint.new(0.33, currentTheme.accent),
			ColorSequenceKeypoint.new(0.66, currentTheme.stroke),
			ColorSequenceKeypoint.new(1, currentTheme.accent)
		}
	end
	
	if miniIconGrad then
		miniIconGrad.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, currentTheme.stroke),
			ColorSequenceKeypoint.new(0.33, currentTheme.accent),
			ColorSequenceKeypoint.new(0.66, currentTheme.stroke),
			ColorSequenceKeypoint.new(1, currentTheme.accent)
		}
	end

	if UpdateTabStyles then UpdateTabStyles() end
end

-- ===============================================================
-- GUI
-- ===============================================================

local gui = Instance.new("ScreenGui")
gui.Name = "VexroEmotes"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

-- ===============================================================
-- LANGUAGE SELECTION
-- ===============================================================

local selectedLang = nil
local rememberLang = false

-- Kayıtlı dil varsa direkt kullan, dil ekranını atla
if Settings.language and Settings.language ~= "" then
	selectedLang = Settings.language
end

if not selectedLang then

local langScreen = Instance.new("Frame")
langScreen.Size = UDim2.fromScale(1, 1)
langScreen.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
langScreen.ZIndex = 20000
langScreen.Parent = gui

for i = 1, 15 do
	local particle = Instance.new("Frame")
	local s = math.random(3, 8)
	particle.Size = UDim2.new(0, s, 0, s)
	particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
	particle.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
	particle.BackgroundTransparency = math.random(5, 8) / 10
	particle.ZIndex = 20000
	particle.Parent = langScreen
	Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)
	
	task.spawn(function()
		while particle.Parent do
			TweenService:Create(particle, TweenInfo.new(math.random(3, 6), Enum.EasingStyle.Sine), {
				Position = UDim2.new(math.random(), 0, math.random(), 0)
			}):Play()
			task.wait(math.random(3, 6))
		end
	end)
end

local langBox = Instance.new("Frame")
langBox.Size = UDim2.new(0, 0, 0, 0)
langBox.Position = UDim2.fromScale(0.5, 0.5)
langBox.AnchorPoint = Vector2.new(0.5, 0.5)
langBox.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
langBox.ZIndex = 20001
langBox.Rotation = -15
langBox.Parent = langScreen
Instance.new("UICorner", langBox).CornerRadius = UDim.new(0, 20)

local langBoxStroke = Instance.new("UIStroke")
langBoxStroke.Color = Color3.fromRGB(100, 100, 180)
langBoxStroke.Thickness = 2
langBoxStroke.Parent = langBox

local langStrokeGrad = Instance.new("UIGradient")
langStrokeGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(75, 0, 130)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
langStrokeGrad.Parent = langBoxStroke

task.spawn(function()
	local rot = 0
	while langBoxStroke.Parent do
		rot = rot + 360
		TweenService:Create(langStrokeGrad, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = rot}):Play()
		task.wait(2)
	end
end)

local langTitle = Instance.new("TextLabel")
langTitle.Size = UDim2.new(1, 0, 0, 45)
langTitle.Position = UDim2.new(0, 0, 0, 20)
langTitle.BackgroundTransparency = 1
langTitle.Text = "🌐 Select Language"
langTitle.TextColor3 = Color3.new(1, 1, 1)
langTitle.Font = Enum.Font.GothamBold
langTitle.TextScaled = true
langTitle.ZIndex = 20002
langTitle.Parent = langBox

local function MakeLangBtn(txt, index, lang)
	local col = index <= 4 and 0 or 1
	local row = (index - 1) % 4
	local x = col == 0 and 0.04 or 0.52
	local y = 80 + (row * 65)

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.44, 0, 0, 55)
	btn.Position = UDim2.new(x, 0, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	btn.Text = txt
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = isMobile and 14 or 16
	btn.ZIndex = 20003
	btn.Parent = langBox
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
	
	local btnStroke = Instance.new("UIStroke")
	btnStroke.Color = Color3.fromRGB(70, 70, 100)
	btnStroke.Transparency = 0.5
	btnStroke.Parent = btn
	
	local shine = Instance.new("Frame")
	shine.Size = UDim2.new(0, 0, 1, 0)
	shine.BackgroundColor3 = Color3.new(1, 1, 1)
	shine.BackgroundTransparency = 0.9
	shine.ZIndex = 20004
	shine.Parent = btn
	Instance.new("UICorner", shine).CornerRadius = UDim.new(0, 12)
	
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 90)}):Play()
		TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0, Color = Color3.fromRGB(138, 43, 226)}):Play()
		TweenService:Create(shine, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 1, 0)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 60)}):Play()
		TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.5, Color = Color3.fromRGB(70, 70, 100)}):Play()
		TweenService:Create(shine, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 1, 0)}):Play()
	end)
	btn.MouseButton1Click:Connect(function()
		local ripple = Instance.new("Frame")
		ripple.Size = UDim2.new(0, 0, 0, 0)
		ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
		ripple.AnchorPoint = Vector2.new(0.5, 0.5)
		ripple.BackgroundColor3 = Color3.new(1, 1, 1)
		ripple.BackgroundTransparency = 0.7
		ripple.ZIndex = 20005
		ripple.Parent = btn
		Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
		
		TweenService:Create(ripple, TweenInfo.new(0.4), {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}):Play()
		TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(138, 43, 226)}):Play()
		task.delay(0.4, function() ripple:Destroy() end)
		task.wait(0.15)
		selectedLang = lang
	end)
end

MakeLangBtn("🇹🇷  Türkçe",   1, "TR")
MakeLangBtn("🇬🇧  English",  2, "EN")
MakeLangBtn("🇪🇸  Español",  3, "ES")
MakeLangBtn("🇸🇦  العربية",  4, "AR")
MakeLangBtn("🇫🇷  Français", 5, "FR")
MakeLangBtn("🇮🇳  हिन्दी",   6, "HI")
MakeLangBtn("🇵🇹  Português",7, "PT")
MakeLangBtn("🇷🇺  Русский",  8, "RU")

-- Remember Language butonu
local rememberBtn = Instance.new("TextButton")
rememberBtn.Size = UDim2.new(0.92, 0, 0, 40)
rememberBtn.Position = UDim2.new(0.04, 0, 1, -50)
rememberBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
rememberBtn.Text = "💾  Remember Language"
rememberBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
rememberBtn.Font = Enum.Font.GothamBold
rememberBtn.TextSize = isMobile and 13 or 15
rememberBtn.ZIndex = 20003
rememberBtn.Parent = langBox
Instance.new("UICorner", rememberBtn).CornerRadius = UDim.new(0, 12)

local rememberStroke = Instance.new("UIStroke")
rememberStroke.Color = Color3.fromRGB(70, 70, 100)
rememberStroke.Transparency = 0.5
rememberStroke.Parent = rememberBtn

rememberBtn.MouseButton1Click:Connect(function()
	rememberLang = not rememberLang
	if rememberLang then
		TweenService:Create(rememberBtn, TweenInfo.new(0.2),
			{BackgroundColor3 = Color3.fromRGB(60, 140, 80)}):Play()
		rememberBtn.Text       = "✅  Remember Language"
		rememberBtn.TextColor3 = Color3.new(1, 1, 1)
	else
		TweenService:Create(rememberBtn, TweenInfo.new(0.2),
			{BackgroundColor3 = Color3.fromRGB(40, 40, 60)}):Play()
		rememberBtn.Text       = "💾  Remember Language"
		rememberBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
	end
end)

local targetSize = isMobile and UDim2.new(0, 380, 0, 410) or UDim2.new(0, 480, 0, 410)
TweenService:Create(langBox, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = targetSize, Rotation = 0}):Play()

repeat task.wait(0.1) until selectedLang

-- Dil hatırlama seçiliyse kaydet
if rememberLang then
	Settings.language = selectedLang
	SaveData()
end

TweenService:Create(langBox, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Rotation = 360}):Play()
TweenService:Create(langScreen, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
task.wait(0.4)
langScreen:Destroy()

end -- if not selectedLang

-- ===============================================================
-- LANGUAGE
-- ===============================================================

local isTR, isES, isAR, isFR, isHI, isPT, isRU = selectedLang == "TR", selectedLang == "ES", selectedLang == "AR", selectedLang == "FR", selectedLang == "HI", selectedLang == "PT", selectedLang == "RU"
local L = {
	r6Msg = isTR and "Sadece R15!" or (isES and "Solo R15!" or (isAR and "R15 فقط!" or (isFR and "R15 uniquement!" or (isHI and "केवल R15!" or (isPT and "Apenas R15!" or (isRU and "Только R15!" or "R15 only!")))))),
	loading = isTR and "Yükleniyor..." or (isES and "Cargando..." or (isAR and "جار التحميل..." or (isFR and "Chargement..." or (isHI and "लोड हो रहा है..." or (isPT and "Carregando..." or (isRU and "Загрузка..." or "Loading...")))))),
	madeBy = isTR and "Oyuncu15q tarafından yapıldı" or (isES and "Hecho por Oyuncu15q" or (isAR and "صنع بواسطة Oyuncu15q" or (isFR and "Fait par Oyuncu15q" or (isHI and "Oyuncu15q द्वारा निर्मित" or (isPT and "Feito por Oyuncu15q" or (isRU and "Сделано Oyuncu15q" or "Made by Oyuncu15q")))))),
	search = isTR and "Ara..." or (isES and "Buscar..." or (isAR and "بحث..." or (isFR and "Rechercher..." or (isHI and "खोजें..." or (isPT and "Pesquisar..." or (isRU and "Поиск..." or "Search...")))))),
	playing = isTR and "Oynatılıyor" or (isES and "Reproduciendo" or (isAR and "تشغيل" or (isFR and "En lecture" or (isHI and "चल रहा है" or (isPT and "Reproduzindo" or (isRU and "Воспроизведение" or "Playing")))))),
	stopped = isTR and "Durduruldu" or (isES and "Detenido" or (isAR and "توقف" or (isFR and "Arrêté" or (isHI and "रुक गया" or (isPT and "Parado" or (isRU and "Остановлено" or "Stopped")))))),
	ready = isTR and "Hazır!" or (isES and "Listo!" or (isAR and "جاهز!" or (isFR and "Prêt!" or (isHI and "तैयार!" or (isPT and "Pronto!" or (isRU and "Готово!" or "Ready!")))))),
	emotes = isTR and "Emoteler" or (isES and "Emotes" or (isAR and "رقصات" or (isFR and "Emotes" or (isHI and "इमोट्स" or (isPT and "Emotes" or (isRU and "Эмоции" or "Emotes")))))),
	favorites = isTR and "Favoriler" or (isES and "Favoritos" or (isAR and "المفضلة" or (isFR and "Favoris" or (isHI and "पसंदीदा" or (isPT and "Favoritos" or (isRU and "Избранное" or "Favorites")))))),
	recent = isTR and "Son Kullanılanlar" or (isES and "Recientes" or (isAR and "الأخيرة" or (isFR and "Récents" or (isHI and "हाल ही के" or (isPT and "Recentes" or (isRU and "Недавние" or "Recent")))))),
	settings = isTR and "Ayarlar" or (isES and "Ajustes" or (isAR and "الإعدادات" or (isFR and "Paramètres" or (isHI and "सेटिंग्स" or (isPT and "Configurações" or (isRU and "Настройки" or "Settings")))))),
	noFav = isTR and "Favori yok" or (isES and "Sin favoritos" or (isAR and "لا يوجد مفضلة" or (isFR and "Pas de favoris" or (isHI and "कोई पसंदीदा नहीं" or (isPT and "Sem favoritos" or (isRU and "Нет избранного" or "No favorites")))))),
	noRecent = isTR and "Geçmiş yok" or (isES and "Sin recientes" or (isAR and "لا يوجد سجل" or (isFR and "Pas de récents" or (isHI and "कोई हाल का नहीं" or (isPT and "Sem recentes" or (isRU and "Нет недавних" or "No recent")))))),
	theme = isTR and "Tema" or (isES and "Tema" or (isAR and "المظهر" or (isFR and "Thème" or (isHI and "थीम" or (isPT and "Tema" or (isRU and "Тема" or "Theme")))))),
	speed = isTR and "Hız" or (isES and "Velocidad" or (isAR and "السرعة" or (isFR and "Vitesse" or (isHI and "गति" or (isPT and "Velocidade" or (isRU and "Скорость" or "Speed")))))),
	notif = isTR and "Bildirimler" or (isES and "Notificaciones" or (isAR and "الإشعارات" or (isFR and "Notifications" or (isHI and "सूचनाएं" or (isPT and "Notificações" or (isRU and "Уведомления" or "Notifications")))))),
	on = isTR and "Açık" or (isES and "On" or (isAR and "تشغيل" or (isFR and "Activé" or (isHI and "चालू" or (isPT and "Ligado" or (isRU and "Вкл" or "On")))))),
	off = isTR and "Kapalı" or (isES and "Off" or (isAR and "إيقاف" or (isFR and "Désactivé" or (isHI and "बंद" or (isPT and "Desligado" or (isRU and "Выкл" or "Off")))))),
	copied = isTR and "Kopyalandı!" or (isES and "Copiado!" or (isAR and "تم النسخ!" or (isFR and "Copié!" or (isHI and "कॉपी किया गया!" or (isPT and "Copiado!" or (isRU and "Скопировано!" or "Copied!")))))),
	loopText    = isTR and "Döngü"         or (isES and "Bucle"         or (isAR and "تكرار"        or (isFR and "Boucle"          or (isHI and "लूप"           or (isPT and "Loop"        or (isRU and "Цикл"         or "Loop")))))),
	comboTitle  = isTR and "Combo Sırası" or (isES and "Cola de Combo" or (isAR and "قائمة الكومبو" or (isFR and "File Combo"       or (isHI and "कॉम्बो कतार"    or (isPT and "Fila de Combo" or (isRU and "Очередь комбо" or "Combo Queue")))))),
	addEmote    = isTR and "+ Ekle"       or (isES and "+ Añadir"      or (isAR and "+ إضافة"       or (isFR and "+ Ajouter"        or (isHI and "+ जोड़ें"       or (isPT and "+ Adicionar"   or (isRU and "+ Добавить"    or "+ Add")))))),
	playCombo   = isTR and "Oynat"        or (isES and "Reproducir"    or (isAR and "تشغيل"         or (isFR and "Jouer"            or (isHI and "चलाएं"         or (isPT and "Reproduzir"    or (isRU and "Играть"        or "Play")))))),
	clearCombo  = isTR and "Temizle"      or (isES and "Limpiar"       or (isAR and "مسح"           or (isFR and "Effacer"          or (isHI and "साफ़ करें"      or (isPT and "Limpar"        or (isRU and "Очистить"      or "Clear")))))),
	selectFirst = isTR and "Önce seç!"      or (isES and "¡Selecciona!"   or (isAR and "اختر أولاً!"    or (isFR and "Choisir d'abord!" or (isHI and "पहले चुनें!"    or (isPT and "Selecione!"     or (isRU and "Выберите!"      or "Select first!")))))),
	slotLabel   = isTR and "Slot"           or (isES and "Ranura"         or (isAR and "خانة"           or (isFR and "Slot"             or (isHI and "स्लॉट"          or (isPT and "Slot"           or (isRU and "Слот"           or "Slot")))))),
	-- Bilgi paneli
	infoTitle   = isTR and "Emote Bilgisi" or (isES and "Info del Emote" or (isAR and "معلومات الحركة" or (isFR and "Infos de l'Emote" or (isHI and "इमोट जानकारी"   or (isPT and "Info do Emote"  or (isRU and "Инфо Эмоции"    or "Emote Info")))))),
	noDesc      = isTR and "Açıklama yok"  or (isES and "Sin descripción" or (isAR and "لا يوجد وصف"   or (isFR and "Sans description" or (isHI and "कोई विवरण नहीं" or (isPT and "Sem descrição"   or (isRU and "Нет описания"   or "No description")))))),
	freePrice   = isTR and "Ücretsiz"      or (isES and "Gratis"          or (isAR and "مجاني"          or (isFR and "Gratuit"          or (isHI and "मुफ़्त"          or (isPT and "Grátis"          or (isRU and "Бесплатно"      or "Free")))))),
	copyId           = isTR and "ID Kopyala"         or (isES and "Copiar ID"              or (isAR and "نسخ المعرف"          or (isFR and "Copier ID"             or (isHI and "ID कॉपी करें"      or (isPT and "Copiar ID"            or (isRU and "Скопировать ID"    or "Copy ID")))))),
	copyEmote        = isTR and "Emote Kopyala"      or (isES and "Copiar Emote"           or (isAR and "نسخ الحركة"           or (isFR and "Copier Emote"          or (isHI and "इमोट कॉपी करें"    or (isPT and "Copiar Emote"         or (isRU and "Скопировать"       or "Copy Emote")))))),
	favLimit         = isTR and "Maksimum 25 favori!" or (isES and "¡Máximo 25 favoritos!"  or (isAR and "الحد الأقصى 25!"       or (isFR and "Maximum 25 favoris!"   or (isHI and "अधिकतम 25 पसंदीदा!" or (isPT and "Máximo 25 favoritos!" or (isRU and "Максимум 25!"       or "Max 25 favorites!")))))),
	copyEmoteDesc    = isTR and "Bir oyuncunun kullandığı emote'u kopyalar" or (isES and "Copia el emote que usa otro jugador" or (isAR and "ينسخ حركة يستخدمها لاعب آخر" or (isFR and "Copie l'émote utilisé par un autre joueur" or (isHI and "किसी खिलाड़ी का इमोट कॉपी करता है" or (isPT and "Copia o emote de outro jogador" or (isRU and "Копирует эмоцию другого игрока" or "Copies the emote used by another player")))))),
}

local Icons = {
	Emote = "rbxassetid://138124492647096",
	Sort = "rbxassetid://113816420281431", 
	Refresh = "rbxassetid://105648271243690",
	Info = "rbxassetid://84622089809608",
	Crown = "rbxassetid://73989246452336",
	Minus = "rbxassetid://113043537756950", 
	Close = "rbxassetid://71734731066706", -- X
	Search = "rbxassetid://100759629447583",
	FavoriteEmpty = "rbxassetid://139336655769578",
	FavoriteFull = "rbxassetid://114412745011584",
	Stop = "STOP_SHAPE", 
	Settings = "rbxassetid://94488099205692", 
	Recent = "rbxassetid://89358357551545", 
	Check = "rbxassetid://71514022902819",
	Quatrefoil = "rbxassetid://98400541052448", 
}

-- ===============================================================
-- R15 CHECK
-- ===============================================================

local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid", 5)
if not hum or hum.RigType == Enum.HumanoidRigType.R6 then
	Notify(utf8.char(0x274C), L.r6Msg)
	gui:Destroy()
	return
end

-- ===============================================================
-- SPLASH SCREEN
-- ===============================================================

local splash = Instance.new("Frame")
splash.Size = UDim2.fromScale(1, 1)
splash.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
splash.ZIndex = 10000
splash.Parent = gui

local splashBgGrad = Instance.new("UIGradient")
splashBgGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 8, 18)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 10, 30)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 18))
}
splashBgGrad.Rotation = 45
splashBgGrad.Parent = splash

task.spawn(function()
	local rot = 0
	while splash.Parent do
		rot = (rot + 1) % 360
		splashBgGrad.Rotation = rot
		task.wait(0.05)
	end
end)

local splashBox = Instance.new("Frame")
splashBox.Size = UDim2.new(0, 0, 0, 0)
splashBox.Position = UDim2.fromScale(0.5, 0.5)
splashBox.AnchorPoint = Vector2.new(0.5, 0.5)
splashBox.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
splashBox.Rotation = -180
splashBox.ZIndex = 10001
splashBox.Parent = splash
Instance.new("UICorner", splashBox).CornerRadius = UDim.new(0, 22)

local splashStroke = Instance.new("UIStroke")
splashStroke.Color = Color3.fromRGB(138, 43, 226)
splashStroke.Thickness = 3
splashStroke.Parent = splashBox

local splashStrokeGrad = Instance.new("UIGradient")
splashStrokeGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
	ColorSequenceKeypoint.new(0.33, Color3.fromRGB(75, 0, 130)),
	ColorSequenceKeypoint.new(0.66, Color3.fromRGB(186, 85, 211)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
splashStrokeGrad.Parent = splashStroke

task.spawn(function()
	local rot = 0
	while splashStroke.Parent do
		rot = rot + 360
		TweenService:Create(splashStrokeGrad, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Rotation = rot}):Play()
		task.wait(1.5)
	end
end)

local avatarHolder = Instance.new("Frame")
avatarHolder.Size = UDim2.new(1, -24, 0, 50)
avatarHolder.Position = UDim2.new(0, 12, 0, 12)
avatarHolder.BackgroundTransparency = 1
avatarHolder.ZIndex = 10002
avatarHolder.Parent = splashBox

local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.new(0, 44, 0, 44)
avatar.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=3164346931&width=150&height=150&format=png"
avatar.ZIndex = 10003
avatar.Parent = avatarHolder
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)

local avatarGlow = Instance.new("UIStroke")
avatarGlow.Color = Color3.fromRGB(138, 43, 226)
avatarGlow.Thickness = 2
avatarGlow.Parent = avatar

task.spawn(function()
	while avatar.Parent do
		TweenService:Create(avatarGlow, TweenInfo.new(1, Enum.EasingStyle.Sine), {Color = Color3.fromRGB(186, 85, 211)}):Play()
		task.wait(1)
		TweenService:Create(avatarGlow, TweenInfo.new(1, Enum.EasingStyle.Sine), {Color = Color3.fromRGB(138, 43, 226)}):Play()
		task.wait(1)
	end
end)

local madeByLbl = Instance.new("TextLabel")
madeByLbl.Size = UDim2.new(1, -54, 1, 0)
madeByLbl.Position = UDim2.new(0, 52, 0, 0)
madeByLbl.BackgroundTransparency = 1
madeByLbl.Text = L.madeBy
madeByLbl.TextColor3 = Color3.fromRGB(180, 180, 220)
madeByLbl.Font = Enum.Font.GothamBold
madeByLbl.TextScaled = true
madeByLbl.TextXAlignment = Enum.TextXAlignment.Left
madeByLbl.ZIndex = 10003
madeByLbl.Parent = avatarHolder

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, -24, 0, 60)
logo.Position = UDim2.new(0, 12, 0, 70)
logo.BackgroundTransparency = 1
logo.Text = "Vexro Emotes"
logo.TextColor3 = Color3.new(1, 1, 1)
logo.Font = Enum.Font.GothamBlack
logo.TextScaled = true
logo.ZIndex = 10003
logo.Parent = splashBox

local logoGrad = Instance.new("UIGradient")
logoGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
	ColorSequenceKeypoint.new(0.25, Color3.fromRGB(186, 85, 211)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(75, 0, 130)),
	ColorSequenceKeypoint.new(0.75, Color3.fromRGB(186, 85, 211)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
logoGrad.Parent = logo

task.spawn(function()
	while logo.Parent do
		TweenService:Create(logoGrad, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Offset = Vector2.new(1, 0)}):Play()
		task.wait(2)
		TweenService:Create(logoGrad, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Offset = Vector2.new(-1, 0)}):Play()
		task.wait(2)
	end
end)

local loadingLbl = Instance.new("TextLabel")
loadingLbl.Size = UDim2.new(1, 0, 0, 30)
loadingLbl.Position = UDim2.new(0, 0, 0, 140)
loadingLbl.BackgroundTransparency = 1
loadingLbl.Text = L.loading
loadingLbl.TextColor3 = Color3.fromRGB(150, 150, 180)
loadingLbl.Font = Enum.Font.GothamBold
loadingLbl.TextSize = 16
loadingLbl.ZIndex = 10003
loadingLbl.Parent = splashBox

task.spawn(function()
	local dots = {"", ".", "..", "..."}
	local i = 1
	while loadingLbl.Parent do
		loadingLbl.Text = "Vexro Emotes " .. L.loading .. dots[i]
		i = i % 4 + 1
		task.wait(0.4)
	end
end)

local loadingBarBg = Instance.new("Frame")
loadingBarBg.Size = UDim2.new(0.8, 0, 0, 6)
loadingBarBg.Position = UDim2.new(0.1, 0, 0, 175)
loadingBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
loadingBarBg.ZIndex = 10003
loadingBarBg.Parent = splashBox
Instance.new("UICorner", loadingBarBg).CornerRadius = UDim.new(1, 0)

local loadingBar = Instance.new("Frame")
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
loadingBar.ZIndex = 10004
loadingBar.Parent = loadingBarBg
Instance.new("UICorner", loadingBar).CornerRadius = UDim.new(1, 0)

local loadingBarGrad = Instance.new("UIGradient")
loadingBarGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(186, 85, 211)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
loadingBarGrad.Parent = loadingBar

local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(0.85, 0, 0, 42)
discordBtn.Position = UDim2.new(0.075, 0, 1, -55)
discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discordBtn.Text = "Discord: 4Bs9WYSabf"
discordBtn.TextColor3 = Color3.new(1, 1, 1)
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextSize = 14
discordBtn.ZIndex = 10003
discordBtn.Parent = splashBox
Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0, 10)

discordBtn.MouseButton1Click:Connect(function()
	pcall(function() if setclipboard then setclipboard("https://discord.gg/4Bs9WYSabf") end end)
	Notify(utf8.char(0x2705), L.copied)
end)

local splashSize = isMobile and UDim2.new(0, 300, 0, 240) or UDim2.new(0, 400, 0, 280)
TweenService:Create(splashBox, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = splashSize, Rotation = 0}):Play()

-- ===============================================================
-- EMOTE LOADING
-- ===============================================================

local Emotes = {}

TweenService:Create(loadingBar, TweenInfo.new(0.5), {Size = UDim2.new(0.3, 0, 1, 0)}):Play()
task.wait(0.3)

local function LoadEmotes()
	local success, result = pcall(function()
		local response = game:HttpGet("https://raw.githubusercontent.com/zyrovell/Vexro/main/emotes.json")
		return HttpService:JSONDecode(response)
	end)
	
	if success and result then
		local data = type(result) == "table" and (result.data or result)
		for _, emote in ipairs(data) do
			if emote.id and emote.name then
				local numId = tonumber(emote.id)
				if numId then
					Emotes[#Emotes + 1] = {
						name          = tostring(emote.name),
						id            = numId,
						creatorName   = tostring(emote.creatorName      or ""),
						description   = tostring(emote.description      or ""),
						price         = emote.price,
						priceStatus   = tostring(emote.priceStatus      or ""),
						favoriteCount = emote.favoriteCount,
						createdUtc    = tostring(emote.itemCreatedUtc   or ""),
					}
				end
			end
		end
	end
	
	if #Emotes == 0 then
		Emotes = {
			{name = "Wave", id = 3576686446},
			{name = "Point", id = 3576823880},
			{name = "Dance", id = 3576720708},
			{name = "Laugh", id = 3576777185},
			{name = "Cheer", id = 3576738018}
		}
	end
end

LoadEmotes()

-- Build lookup table for O(1) emote access by ID
for _, emote in ipairs(Emotes) do
	EmotesById[emote.id] = emote
end
TweenService:Create(loadingBar, TweenInfo.new(1), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(1)

loadingLbl.Text = utf8.char(0x2705) .. " " .. #Emotes .. " emotes!"
task.wait(1)

TweenService:Create(splash, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(splashBox, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Rotation = 720}):Play()
task.wait(0.5)
splash:Destroy()

-- Emotes yüklendi → sunucudan favorileri çek, UI güncelle
SyncPull(function()
	if UpdateTabData then UpdateTabData() end
end)

-- ===============================================================
-- UI SIZE SETTINGS
-- ===============================================================
local ICON_SCALE = 1.5     -- İkonların resim boyutu (1.0 = normal, 1.5 = %50 daha büyük)
local BUTTON_SCALE = 1.1   -- Kırpılmayı önlemek için buton kutusunu büyütme (1.0 = normal)
local FONT_SCALE = 1.2     -- Yazı karakteri ve zar/menü sembol boyutu

-- ===============================================================
-- VARIABLES
-- ===============================================================

local EMOTE_ICON = "rbxassetid://120313093991132"
local currentData, filtered = Emotes, Emotes
local currentTab = "emotes"
local page, perPage, pages, cols = 1, 14, 1, 7 -- Default to 7 cols
local cards = {}
local sideBarW = math.floor((isMobile and 50 or 60) * BUTTON_SCALE)
local bottomBarH = isMobile and 26 or 22
local currentCardSize = 0 -- Dynamic card size

-- ===============================================================
-- FAVORITES & RECENT
-- ===============================================================

local function IsFavorite(id)
	return FavoritesSet[tonumber(id)] == true
end

local MAX_FAVORITES = 25

local function ToggleFavorite(id)
	id = tonumber(id)
	if FavoritesSet[id] then
		FavoritesSet[id] = nil
		for i = #Favorites, 1, -1 do
			if Favorites[i] == id then
				table.remove(Favorites, i)
				break
			end
		end
		SaveData()
		SyncPush()
		return false
	end
	if #Favorites >= MAX_FAVORITES then
		Notify("⭐ " .. L.favLimit, "")
		return false
	end
	if #Favorites >= MAX_FAVORITES then
		Notify("⭐ " .. L.favLimit, "")
		return false
	end
	FavoritesSet[id] = true
	Favorites[#Favorites + 1] = id
	SaveData()
	SyncPush()
	return true
end

local function AddToRecent(id)
	id = tonumber(id)
	for i = #RecentEmotes, 1, -1 do
		if RecentEmotes[i] == id then
			table.remove(RecentEmotes, i)
		end
	end
	table.insert(RecentEmotes, 1, id)
	while #RecentEmotes > MAX_RECENT do
		table.remove(RecentEmotes)
	end
	SaveData()
end

-- ===============================================================
-- EMOTE & SPEED SYSTEM
-- ===============================================================

local currentAnimTrack = nil
local lastEmoteTime = 0

local function GetAnimator()
	local character = player.Character
	if not character then return nil end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return nil end
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end
	return animator
end

local function StopAllTracks()
	local animator = GetAnimator()
	if animator then
		for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
			pcall(function() 
				track:Stop(0.1)
			end)
		end
	end
	currentAnimTrack = nil
end

local function ApplySpeedToAllTracks()
	local animator = GetAnimator()
	if animator then
		for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
			pcall(function() track:AdjustSpeed(Settings.speed) end)
		end
	end
end


local function StopEmote(showNotif)
	StopAllTracks()
	if showNotif then Notify("[||]", L.stopped) end
end

RunService.Heartbeat:Connect(function()
	if currentAnimTrack and currentAnimTrack.IsPlaying then
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.MoveDirection.Magnitude > 0 then
				StopEmote(false)
			end
		end
	end
end)

-- Animation objesi cache (her emote ID için bir kez GetObjects çağrılır, lag önlenir)
local _animCache = {}

local function PlayEmote(id, name, silent)
	local animator = GetAnimator()
	if not animator then return end
	
	-- FIX: Yeni emote çalmadan önce eski emoteyi durdur (hareket etmeden geçişte takılmayı önler)
	StopAllTracks()
	
	-- MODIFIED: Save last played emote for Auto-Reload (Continue)
	getgenv().lastVexroEmote = {id = id, name = name}
	
	-- FIX: Catalog ID'leri direkt LoadAnimation ile çalışmadığı için game:GetObjects ile asıl Animation'ı çekiyoruz.
	-- Cache kullanarak tekrarlanan çağrılardan kaynaklanan kasılmayı önlüyoruz.
	local success, err = pcall(function()
		local anim = _animCache[id]
		
		if not anim then
			local successObj, objects = pcall(function()
				return game:GetObjects("rbxassetid://" .. id)
			end)
			
			if successObj and objects and #objects > 0 then
				local item = objects[1]
				if item:IsA("Animation") then
					anim = item
				else
					-- Folder içindeki asıl Animation objesini bul (Face animasyonları yerine vücudu bulur)
					anim = item:FindFirstChildWhichIsA("Animation", true)
				end
			end
			
			-- Eğer exploit GetObjects desteklemiyorsa veya çalışmazsa normal şekilde dene
			if not anim then
				anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://" .. id
			end
			
			_animCache[id] = anim
		end
		
		local track = animator:LoadAnimation(anim)
		track.Priority = Enum.AnimationPriority.Action4
		track.Looped = Settings.loopEmote
		track:Play(0.1)
		
		task.delay(0.05, function()
			track:AdjustSpeed(Settings.speed)
		end)
		
		currentAnimTrack = track
		AddToRecent(id)
	end)
	
	if success then
		if not silent then
			local speedTxt = Settings.speed ~= 1 and " (" .. Settings.speed .. "x)" or ""
			Notify(utf8.char(0x25B6, 0xFE0F) .. " " .. L.playing .. speedTxt, name)
		end
		lastEmoteTime = tick()
	else
		Notify(utf8.char(0x274C), "Emote yüklenemedi!")
	end
end

-- ===============================================================
-- MAIN MENU
-- ===============================================================

-- TARGET CARD SIZES (Made larger for better visibility)
local TARGET_PC_CARD = 75 -- Was 75
local TARGET_MOBILE_CARD = 55 -- Was 55

local function GetDefaultSize()
	-- Calculate width needed for 7 columns exactly + padding
	local PAD = isMobile and 4 or 6
	local targetCard = isMobile and TARGET_MOBILE_CARD or TARGET_PC_CARD
	
	-- Width for 7 cards + sidebar
	local perfectWidth = (targetCard * 7) + (PAD * 6) + sideBarW + 20
	
	local vp = workspace.CurrentCamera.ViewportSize
	local finalW = math.clamp(perfectWidth, 400, vp.X * 0.95)
	
	-- Height for 2 rows approx
	local cardH = targetCard + (targetCard * 0.3 * 2) + PAD -- approx card total height
	local perfectHeight = (cardH * 2) + 60 + bottomBarH + 20
	
	local finalH = math.clamp(perfectHeight, 300, vp.Y * 0.8)
	
	return UDim2.new(0, finalW, 0, finalH)
end

local main = Instance.new("Frame")
main.Name = "MainMenu"
main.Size = UDim2.new(0, 0, 0, 0)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = currentTheme.primary
main.BackgroundTransparency = 0 -- Saydamlığı kaldırdık ki içi dolsun
main.ClipsDescendants = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 20) -- Daha yumuşak köşeler
RegisterTheme(main, "BackgroundColor3", "primary")

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.new(1, 1, 1) -- Gradient kullanılacak
mainStroke.Thickness = 3
mainStroke.Transparency = 0
mainStroke.Parent = main

mainStrokeGrad = Instance.new("UIGradient")
mainStrokeGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, currentTheme.stroke),
	ColorSequenceKeypoint.new(0.33, currentTheme.accent),
	ColorSequenceKeypoint.new(0.66, currentTheme.stroke),
	ColorSequenceKeypoint.new(1, currentTheme.accent)
}
mainStrokeGrad.Parent = mainStroke

-- Animasyonu başlat
task.spawn(function()
	local rot = 0
	while mainStroke.Parent do
		rot = rot + 360
		TweenService:Create(mainStrokeGrad, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = rot}):Play()
		task.wait(2)
	end
end)

-- Background Particles
local bgParticles = Instance.new("Frame")
bgParticles.Name = "BgParticles"
bgParticles.Size = UDim2.new(1, 0, 1, 0)
bgParticles.BackgroundTransparency = 1
bgParticles.ZIndex = 1
bgParticles.Parent = main

for i = 1, 20 do
	local particle = Instance.new("Frame")
	local s = math.random(5, 12)
	particle.Size = UDim2.new(0, s, 0, s)
	particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
	particle.BackgroundColor3 = currentTheme.accent
	particle.BackgroundTransparency = math.random(4, 8) / 10
	particle.ZIndex = 1
	particle.Parent = bgParticles
	Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)
	
	RegisterTheme(particle, "BackgroundColor3", "accent")
	
	task.spawn(function()
		while particle.Parent do
			TweenService:Create(particle, TweenInfo.new(math.random(4, 8), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				Position = UDim2.new(math.random(), 0, math.random(), 0)
			}):Play()
			task.wait(math.random(4, 8))
		end
	end)
end

-- ===============================================================
-- SIDEBAR
-- ===============================================================

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, sideBarW, 1, 0)
sidebar.BackgroundColor3 = currentTheme.sidebar
sidebar.ZIndex = 8
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 14)
RegisterTheme(sidebar, "BackgroundColor3", "sidebar")

local sideOverlay = Instance.new("Frame")
sideOverlay.Size = UDim2.new(0, 10, 1, 0)
sideOverlay.Position = UDim2.new(1, -10, 0, 0)
sideOverlay.BackgroundColor3 = currentTheme.sidebar
sideOverlay.BorderSizePixel = 0
sideOverlay.ZIndex = 7
sideOverlay.Parent = sidebar
RegisterTheme(sideOverlay, "BackgroundColor3", "sidebar")

local tabBtns = {}
local tabBtnS = math.floor((isMobile and 40 or 48) * BUTTON_SCALE)

local function CreateTabBtn(icon, tabName, yPos, customScale)
	local isUrl = type(icon) == "string" and (string.find(icon, "rbxassetid://") or string.find(icon, "http") or string.find(icon, "rbxthumb://"))
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, tabBtnS, 0, tabBtnS)
	btn.Position = UDim2.new(0.5, -tabBtnS/2, 0, yPos)
	btn.BackgroundColor3 = currentTheme.sidebar
	btn.BackgroundTransparency = 0.8
	btn.Text = ""
	btn.TextSize = isMobile and 28 or 34
	btn.Font = Enum.Font.GothamBold
	btn.TextColor3 = currentTheme.text
	btn.ZIndex = 9
	btn.Parent = sidebar
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = currentTheme.sidebar
	stroke.Thickness = 2
	stroke.Transparency = 0.7
	stroke.Parent = btn
	
	local imgElement = nil
	if isUrl then
		local img = Instance.new("ImageLabel")
		local s = (tabName == "emotes") and 0.85 or (0.95 * ICON_SCALE)
		img.Size = UDim2.fromScale(s, s)
		img.Position = UDim2.fromScale(0.5, 0.5)
		img.AnchorPoint = Vector2.new(0.5, 0.5)
		img.BackgroundTransparency = 1
		img.Image = ResolveAssetImage(icon)
		img.ImageColor3 = currentTheme.text
		img.ZIndex = 110
		img.Parent = btn
		RegisterTheme(img, "ImageColor3", "text")
		imgElement = img
	else
		btn.Text = icon
		RegisterTheme(btn, "TextColor3", "text")
	end
	
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.4, Size = UDim2.new(0, tabBtnS + 4, 0, tabBtnS + 4)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		local active = currentTab == tabName
		TweenService:Create(btn, TweenInfo.new(0.15), {
			BackgroundTransparency = active and 0.2 or 0.8,
			Size = UDim2.new(0, tabBtnS, 0, tabBtnS)
		}):Play()
	end)
	
	-- Quatrefoil indicator (MaterialYou theme - asset tabanlı)
	local qSize = tabBtnS + 10
	local quatrefoil = Instance.new("ImageLabel")
	quatrefoil.Name = "Quatrefoil"
	quatrefoil.Size = UDim2.new(0, qSize, 0, qSize)
	quatrefoil.Position = UDim2.new(0.5, -qSize/2, 0, yPos + tabBtnS/2 - qSize/2)
	quatrefoil.BackgroundTransparency = 1
	quatrefoil.Image = ResolveAssetImage(Icons.Quatrefoil)
	quatrefoil.ImageColor3 = currentTheme.accent
	quatrefoil.ImageTransparency = 0.3
	quatrefoil.ScaleType = Enum.ScaleType.Fit
	quatrefoil.ZIndex = 9
	quatrefoil.Visible = false
	quatrefoil.Parent = sidebar
	
	tabBtns[tabName] = {btn = btn, stroke = stroke, img = imgElement, quatrefoil = quatrefoil}
	return btn
end

CreateTabBtn(Icons.Emote, "emotes", 8)
CreateTabBtn(Icons.FavoriteFull, "favorites", 8 + tabBtnS + 6)
CreateTabBtn(Icons.Recent, "recent", 8 + (tabBtnS + 6) * 2)
CreateTabBtn(Icons.Settings, "settings", 8 + (tabBtnS + 6) * 3)

-- ===============================================================
-- CONTENT
-- ===============================================================

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -sideBarW, 1, 0)
content.Position = UDim2.new(0, sideBarW, 0, 0)
content.BackgroundTransparency = 1
content.Parent = main

local titleH = isMobile and 38 or 46
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, titleH)
titleBar.BackgroundColor3 = currentTheme.secondary
titleBar.ZIndex = 5
titleBar.Parent = content
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)
RegisterTheme(titleBar, "BackgroundColor3", "secondary")

local titleOverlay = Instance.new("Frame")
titleOverlay.Size = UDim2.new(0, 14, 1, 0)
titleOverlay.BackgroundColor3 = currentTheme.secondary
titleOverlay.BorderSizePixel = 0
titleOverlay.ZIndex = 4
titleOverlay.Parent = titleBar
RegisterTheme(titleOverlay, "BackgroundColor3", "secondary")

local titleIconSz = math.floor((isMobile and 32 or 36) * ICON_SCALE)
local titleIcon = Instance.new("ImageLabel")
titleIcon.Size = UDim2.new(0, titleIconSz, 0, titleIconSz)
titleIcon.Position = UDim2.new(0, 10, 0.5, 0)
titleIcon.AnchorPoint = Vector2.new(0, 0.5)
titleIcon.BackgroundTransparency = 1
titleIcon.Image = ResolveAssetImage(Icons.Emote)
titleIcon.ImageColor3 = currentTheme.text
titleIcon.ZIndex = 6
titleIcon.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -160, 1, 0)
title.Position = UDim2.new(0, 10 + titleIconSz + 6, 0, 0)
title.BackgroundTransparency = 1
title.Text = L.emotes
title.TextColor3 = currentTheme.text
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 5
title.Parent = titleBar
Instance.new("UITextSizeConstraint", title).MaxTextSize = isMobile and 16 or 20
RegisterTheme(title, "TextColor3", "text")

local btnS = math.floor((isMobile and 28 or 36) * BUTTON_SCALE)

local function MakeBtn(icon, px, colorKey, customSize)
	local s = customSize or btnS
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, s, 0, s)
	b.Position = UDim2.new(1, px, 0.5, -s/2)
	b.BackgroundColor3 = currentTheme.tertiary
	b.Text = ""
	b.ZIndex = 10
	b.Parent = titleBar
	Instance.new("UICorner", b).CornerRadius = UDim.new(0.25, 0)
	
	local useWhite = (colorKey == "critical" or colorKey == "accent" or colorKey == "success")
	
	local isImg = type(icon) == "string" and (string.find(icon, "rbxassetid://") or string.find(icon, "http") or string.find(icon, "rbxthumb://"))
	if isImg then
		local img = Instance.new("ImageLabel")
		img.Size = UDim2.new(0, math.floor(42 * ICON_SCALE), 0, math.floor(42 * ICON_SCALE))
		img.Position = UDim2.new(0.5, 0, 0.5, 0)
		img.AnchorPoint = Vector2.new(0.5, 0.5)
		img.BackgroundTransparency = 1
		img.Parent = b
		img.Image = ResolveAssetImage(icon)
		img.ImageColor3 = useWhite and Color3.new(1, 1, 1) or currentTheme.text
		img.ZIndex = 110
		if not useWhite then
			RegisterTheme(img, "ImageColor3", "text")
		end
	else
		-- Minus için bold metin kullan (Görünürlük için en iyisi)
		if icon == "STOP_SHAPE" then
			b.Text = ""
			local sq = Instance.new("Frame")
			sq.BorderSizePixel = 0
			sq.Size = UDim2.new(0.55, 0, 0.55, 0)
			sq.Position = UDim2.new(0.5, 0, 0.5, 0)
			sq.AnchorPoint = Vector2.new(0.5, 0.5)
			sq.BackgroundColor3 = useWhite and Color3.new(1, 1, 1) or currentTheme.text
			sq.ZIndex = 110
			sq.Parent = b
			Instance.new("UICorner", sq).CornerRadius = UDim.new(0, 4)
			if not useWhite then
				RegisterTheme(sq, "BackgroundColor3", "text")
			end
		elseif icon == "CLOSE_SHAPE" then
			b.Text = ""
			local line1 = Instance.new("Frame")
			line1.BorderSizePixel = 0
			line1.Size = UDim2.new(0.40, 0, 0, math.floor(2 * math.max(1, ICON_SCALE))) -- Fixed: Reduced X size
			line1.Position = UDim2.new(0.5, 0, 0.5, 0)
			line1.AnchorPoint = Vector2.new(0.5, 0.5)
			line1.Rotation = 45
			line1.BackgroundColor3 = useWhite and Color3.new(1, 1, 1) or currentTheme.text
			line1.ZIndex = 110
			line1.Parent = b
			Instance.new("UICorner", line1).CornerRadius = UDim.new(0, 2)
			
			local line2 = line1:Clone()
			line2.Rotation = -45
			line2.Parent = b
			
			if not useWhite then
				RegisterTheme(line1, "BackgroundColor3", "text")
				RegisterTheme(line2, "BackgroundColor3", "text")
			end
		elseif icon == Icons.Minus or icon == "-" then
			b.Text = ""
			local line = Instance.new("Frame")
			line.BorderSizePixel = 0
			line.Size = UDim2.new(0.40, 0, 0, math.floor(2 * math.max(1, ICON_SCALE))) -- Fixed: Reduced Minus size
			line.Position = UDim2.new(0.5, 0, 0.5, 0)
			line.AnchorPoint = Vector2.new(0.5, 0.5)
			line.BackgroundColor3 = useWhite and Color3.new(1, 1, 1) or currentTheme.text
			line.ZIndex = 110
			line.Parent = b
			Instance.new("UICorner", line).CornerRadius = UDim.new(0, 2)
			if not useWhite then
				RegisterTheme(line, "BackgroundColor3", "text")
			end
		elseif icon == Icons.Sort then
			b.Text = icon
			b.TextSize = math.floor((isMobile and 32 or 46) * FONT_SCALE)
		else
			b.Text = icon
			b.TextSize = math.floor((isMobile and 12 or 16) * FONT_SCALE)
		end
		b.TextColor3 = useWhite and Color3.new(1, 1, 1) or currentTheme.text
		b.Font = Enum.Font.GothamBlack
		if not useWhite then
			RegisterTheme(b, "TextColor3", "text")
		end
	end

	b.MouseEnter:Connect(function()
		local s = customSize or btnS
		TweenService:Create(b, TweenInfo.new(0.1), {
			Size = UDim2.new(0, s + 4, 0, s + 4),
			Position = UDim2.new(1, px - 2, 0.5, -(s + 4)/2)
		}):Play()
	end)
	b.MouseLeave:Connect(function()
		local s = customSize or btnS
		TweenService:Create(b, TweenInfo.new(0.1), {
			Size = UDim2.new(0, s, 0, s),
			Position = UDim2.new(1, px, 0.5, -s/2)
		}):Play()
	end)
	return b
end

local stopBtn = MakeBtn("STOP_SHAPE", -(btnS*4 + 18), "critical")
local randBtn = MakeBtn(Icons.Sort, -(btnS*3 + 12), "accent")
local minBtn = MakeBtn("-", -(btnS*2 + 6), "textDim")
local closeBtn = MakeBtn("CLOSE_SHAPE", -(btnS + 2), "critical")

RegisterTheme(stopBtn, "BackgroundColor3", "critical")
RegisterTheme(randBtn, "BackgroundColor3", "accent")
RegisterTheme(minBtn, "BackgroundColor3", "stroke")
RegisterTheme(closeBtn, "BackgroundColor3", "critical")

local _isPaused = false
stopBtn.MouseButton1Click:Connect(function()
	if currentAnimTrack and currentAnimTrack.IsPlaying then
		-- Çalan emoteyi mevcut pozisyonda dondur (hız=0)
		pcall(function() currentAnimTrack:AdjustSpeed(0) end)
		_isPaused = true
	elseif currentAnimTrack and _isPaused then
		-- Zaten dondurulmuşsa devam ettir
		pcall(function() currentAnimTrack:AdjustSpeed(Settings.speed) end)
		_isPaused = false
	else
		StopEmote(true)
	end
end)
randBtn.MouseButton1Click:Connect(function()
	if #currentData > 0 then
		local r = currentData[math.random(#currentData)]
		local speedTxt = Settings.speed ~= 1 and " (" .. Settings.speed .. "x)" or ""
		Notify("[~] " .. L.playing .. speedTxt, r.name)
		PlayEmote(r.id, r.name, true) -- Passing true to silence the default notification
	end
end)

local searchH = isMobile and 32 or 38
local search = Instance.new("TextBox")
search.Size = UDim2.new(1, -16, 0, searchH)
search.Position = UDim2.new(0, 8, 0, titleH + 6)
search.BackgroundColor3 = currentTheme.tertiary
search.PlaceholderText = L.search
search.PlaceholderColor3 = currentTheme.textDim
search.Text = ""
search.TextColor3 = currentTheme.text
search.TextSize = isMobile and 13 or 15
search.Font = Enum.Font.Gotham
search.ZIndex = 5
search.ClearTextOnFocus = false
search.Parent = content
Instance.new("UICorner", search).CornerRadius = UDim.new(0, 10)
Instance.new("UIPadding", search).PaddingLeft = UDim.new(0, 10)
RegisterTheme(search, "BackgroundColor3", "tertiary")
RegisterTheme(search, "TextColor3", "text")

local pageH = isMobile and 30 or 36
local pageBar = Instance.new("Frame")
pageBar.Size = UDim2.new(1, -16, 0, pageH)
pageBar.Position = UDim2.new(0, 8, 1, -(pageH + bottomBarH + 8))
pageBar.BackgroundColor3 = currentTheme.secondary
pageBar.ZIndex = 5
pageBar.Parent = content
Instance.new("UICorner", pageBar).CornerRadius = UDim.new(0, 10)
RegisterTheme(pageBar, "BackgroundColor3", "secondary")

local pageBtnW = isMobile and 45 or 60

local prevBtn = Instance.new("TextButton")
prevBtn.Size = UDim2.new(0, pageBtnW, 1, -4)
prevBtn.Position = UDim2.new(0, 2, 0, 2)
prevBtn.BackgroundColor3 = currentTheme.accent
prevBtn.Text = ""
prevBtn.ZIndex = 6
prevBtn.Parent = pageBar
Instance.new("UICorner", prevBtn).CornerRadius = UDim.new(0, 8)
RegisterTheme(prevBtn, "BackgroundColor3", "accent")

local function CreateChevron(parent, isNext)
	local container = Instance.new("Frame")
	container.Name = "ChevronIcon"
	container.Size = UDim2.new(1, 0, 1, 0)
	container.BackgroundTransparency = 1
	container.ZIndex = 7
	container.Parent = parent
	
	local effScale = math.min(ICON_SCALE, 1.4)
	local len = math.floor(14 * effScale)
	local thick = math.floor(1.6 * math.max(1, effScale))
	local offset = math.floor(len * 0.353)
	
	local tipX = isNext and offset or -offset
	local dx = isNext and -offset or offset
	
	local topL = Instance.new("Frame")
	topL.BorderSizePixel = 0
	topL.Size = UDim2.new(0, len, 0, thick)
	topL.AnchorPoint = Vector2.new(0.5, 0.5)
	topL.Position = UDim2.new(0.5, tipX + dx, 0.5, -offset)
	topL.Rotation = isNext and 45 or -45
	topL.BackgroundColor3 = Color3.new(1, 1, 1)
	topL.ZIndex = 7
	topL.Parent = container
	Instance.new("UICorner", topL).CornerRadius = UDim.new(0, 2)
	
	local botL = Instance.new("Frame")
	botL.BorderSizePixel = 0
	botL.Size = UDim2.new(0, len, 0, thick)
	botL.AnchorPoint = Vector2.new(0.5, 0.5)
	botL.Position = UDim2.new(0.5, tipX + dx, 0.5, offset)
	botL.Rotation = isNext and -45 or 45
	botL.BackgroundColor3 = Color3.new(1, 1, 1)
	botL.ZIndex = 7
	botL.Parent = container
	Instance.new("UICorner", botL).CornerRadius = UDim.new(0, 2)
end

local nextBtn = prevBtn:Clone()
nextBtn.Position = UDim2.new(1, -(pageBtnW + 2), 0, 2)
nextBtn.Parent = pageBar

CreateChevron(prevBtn, false)
CreateChevron(nextBtn, true)
RegisterTheme(nextBtn, "BackgroundColor3", "accent")

local pageNum = Instance.new("TextLabel")
pageNum.Size = UDim2.new(1, -(pageBtnW*2 + 16), 1, 0)
pageNum.Position = UDim2.new(0, pageBtnW + 8, 0, 0)
pageNum.BackgroundTransparency = 1
pageNum.Text = "1/1"
pageNum.TextColor3 = currentTheme.textDim
pageNum.Font = Enum.Font.GothamBold
pageNum.TextScaled = true
pageNum.ZIndex = 6
pageNum.Parent = pageBar
RegisterTheme(pageNum, "TextColor3", "textDim")

local emptyLbl = Instance.new("TextLabel")
emptyLbl.Size = UDim2.new(1, -20, 0, 50)
emptyLbl.Position = UDim2.fromScale(0.5, 0.45)
emptyLbl.AnchorPoint = Vector2.new(0.5, 0.5)
emptyLbl.BackgroundTransparency = 1
emptyLbl.Text = ""
emptyLbl.TextColor3 = currentTheme.textDim
emptyLbl.Font = Enum.Font.GothamBold
emptyLbl.TextScaled = true
emptyLbl.Visible = false
emptyLbl.ZIndex = 5
emptyLbl.Parent = content
RegisterTheme(emptyLbl, "TextColor3", "textDim")

-- ===============================================================
-- SETTINGS PANEL
-- ===============================================================

local settingsPanel = Instance.new("ScrollingFrame")
settingsPanel.Size = UDim2.new(1, -16, 1, -(titleH + bottomBarH + 20))
settingsPanel.Position = UDim2.new(0, 8, 0, titleH + 8)
settingsPanel.BackgroundTransparency = 1
settingsPanel.ScrollBarThickness = isMobile and 6 or 4
settingsPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
settingsPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
settingsPanel.Visible = false
settingsPanel.ZIndex = 5
settingsPanel.Parent = content

local settingsLayout = Instance.new("UIListLayout")
settingsLayout.Padding = UDim.new(0, 10)
settingsLayout.Parent = settingsPanel

local function MakeSettingRow(imgId, txt, order, height)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, height or 50)
	row.BackgroundColor3 = currentTheme.tertiary
	row.LayoutOrder = order
	row.ZIndex = 6
	row.Parent = settingsPanel
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)
	RegisterTheme(row, "BackgroundColor3", "tertiary")
	
	local iconSize = 0
	if imgId and imgId ~= "" then
		iconSize = math.floor(44 * ICON_SCALE)
		local rowH = height or 50
		iconSize = math.min(iconSize, rowH - 6) 
		
		local icon = Instance.new("ImageLabel")
		icon.Size = UDim2.new(0, iconSize, 0, iconSize)
		icon.AnchorPoint = Vector2.new(0, 0.5)
		icon.Position = UDim2.new(0, 12, 0.5, 0)
		icon.BackgroundTransparency = 1
		icon.Image = "rbxassetid://" .. imgId
		icon.ImageColor3 = currentTheme.text
		icon.ZIndex = 7
		icon.Parent = row
		RegisterTheme(icon, "ImageColor3", "text")
	end
	
	local lblOffset = iconSize > 0 and (12 + iconSize + 10) or 12
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(0.5, -lblOffset, 1, 0)
	lbl.Position = UDim2.new(0, lblOffset, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = txt
	lbl.TextColor3 = currentTheme.text
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = isMobile and 13 or 15
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.ZIndex = 7
	lbl.Parent = row
	RegisterTheme(lbl, "TextColor3", "text")
	
	return row, lbl
end

local themeRow = MakeSettingRow("110192525313214", L.theme, 1)
local themeBtn = Instance.new("TextButton")
themeBtn.Size = UDim2.new(0.4, 0, 0, 36)
themeBtn.Position = UDim2.new(0.56, 0, 0.5, -18)
themeBtn.BackgroundColor3 = currentTheme.accent
themeBtn.Text = Settings.theme
themeBtn.TextColor3 = Color3.new(1, 1, 1)
themeBtn.Font = Enum.Font.GothamBold
themeBtn.TextSize = isMobile and 12 or 14
themeBtn.ZIndex = 8
themeBtn.Parent = themeRow
Instance.new("UICorner", themeBtn).CornerRadius = UDim.new(0, 10)
RegisterTheme(themeBtn, "BackgroundColor3", "accent")

local themeNames = {"Dark", "Purple", "Blue", "Green", "Red", "Light", "MaterialYou"}
local themeIdx = 1
for i, n in ipairs(themeNames) do if n == Settings.theme then themeIdx = i end end

themeBtn.MouseButton1Click:Connect(function()
	themeIdx = themeIdx % #themeNames + 1
	Settings.theme = themeNames[themeIdx]
	themeBtn.Text = Settings.theme
	ApplyTheme(Settings.theme)
	SaveData()
end)

-- --- SPEED SLIDER SECTION ---
local speedRow, speedTitle = MakeSettingRow("113837085020684", L.speed, 2, 70)
speedTitle.Size = UDim2.new(0.2, 0, 0, 30) -- Shrink title to allow slider space
speedTitle.TextYAlignment = Enum.TextYAlignment.Center
local speedIcon = speedRow:FindFirstChildOfClass("ImageLabel")
if speedIcon then speedIcon.Position = UDim2.new(0, 4, 0.5, 0) end

local speeds = {0.25, 0.5, 0.75, 1, 1.25, 1.5, 2, 3}
local speedIdx = 4
for i, s in ipairs(speeds) do if s == Settings.speed then speedIdx = i end end

local speedValueLbl = Instance.new("TextLabel")
speedValueLbl.Size = UDim2.new(1, 0, 0, 20)
speedValueLbl.Position = UDim2.new(0, 0, 0, 5)
speedValueLbl.BackgroundTransparency = 1
speedValueLbl.Text = Settings.speed .. "x"
speedValueLbl.TextColor3 = currentTheme.accent
speedValueLbl.Font = Enum.Font.GothamBlack
speedValueLbl.TextSize = 16
speedValueLbl.ZIndex = 7
speedValueLbl.Parent = speedRow
RegisterTheme(speedValueLbl, "TextColor3", "accent")

local speedMinus = Instance.new("TextButton")
speedMinus.Size = UDim2.new(0, 30, 0, 30)
speedMinus.Position = UDim2.new(0.1, 0, 0, 30)
speedMinus.BackgroundColor3 = currentTheme.critical
speedMinus.Text = "-"
speedMinus.TextColor3 = Color3.new(1, 1, 1)
speedMinus.Font = Enum.Font.GothamBold
speedMinus.TextSize = 20
speedMinus.ZIndex = 8
speedMinus.Parent = speedRow
Instance.new("UICorner", speedMinus).CornerRadius = UDim.new(0, 8)
RegisterTheme(speedMinus, "BackgroundColor3", "critical")

local speedPlus = speedMinus:Clone()
speedPlus.Position = UDim2.new(0.9, -30, 0, 30)
speedPlus.BackgroundColor3 = currentTheme.success
speedPlus.Text = "+"
speedPlus.Parent = speedRow
RegisterTheme(speedPlus, "BackgroundColor3", "success")

-- SLIDER UI
local sliderBg = Instance.new("Frame")
sliderBg.Size = UDim2.new(0.6, 0, 0, 6)
sliderBg.Position = UDim2.new(0.5, 0, 0, 42)
sliderBg.AnchorPoint = Vector2.new(0.5, 0)
sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
sliderBg.ZIndex = 8
sliderBg.Parent = speedRow
Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.5, 0, 1, 0) -- Starts at half
sliderFill.BackgroundColor3 = currentTheme.accent
sliderFill.ZIndex = 9
sliderFill.Parent = sliderBg
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)
RegisterTheme(sliderFill, "BackgroundColor3", "accent")

local sliderKnob = Instance.new("TextButton") -- Button for input
sliderKnob.Size = UDim2.new(0, 16, 0, 16)
sliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
sliderKnob.Position = UDim2.new(0.5, 0, 0.5, 0)
sliderKnob.BackgroundColor3 = Color3.new(1, 1, 1)
sliderKnob.Text = ""
sliderKnob.ZIndex = 10
sliderKnob.Parent = sliderBg
Instance.new("UICorner", sliderKnob).CornerRadius = UDim.new(1, 0)

local function UpdateSpeedUI()
	Settings.speed = speeds[speedIdx]
	speedValueLbl.Text = Settings.speed .. "x"
	
	local alpha = (speedIdx - 1) / (#speeds - 1)
	TweenService:Create(sliderFill, TweenInfo.new(0.2), {Size = UDim2.new(alpha, 0, 1, 0)}):Play()
	TweenService:Create(sliderKnob, TweenInfo.new(0.2), {Position = UDim2.new(alpha, 0, 0.5, 0)}):Play()
	
	SaveData()
	ApplySpeedToAllTracks()
	-- HUD hız butonlarını ve açık info panel'i güncelle
	if _onSpeedChanged then _onSpeedChanged() end
end

speedMinus.MouseButton1Click:Connect(function()
	if speedIdx > 1 then speedIdx = speedIdx - 1; UpdateSpeedUI() end
end)
speedPlus.MouseButton1Click:Connect(function()
	if speedIdx < #speeds then speedIdx = speedIdx + 1; UpdateSpeedUI() end
end)

local sliderDragging = false
sliderKnob.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sliderDragging = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sliderDragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local mousePos = input.Position.X
		local startPos = sliderBg.AbsolutePosition.X
		local width = sliderBg.AbsoluteSize.X
		local alpha = math.clamp((mousePos - startPos) / width, 0, 1)
		
		-- Snap to nearest index
		local exactIdx = alpha * (#speeds - 1) + 1
		local newIdx = math.floor(exactIdx + 0.5)
		
		if newIdx ~= speedIdx then
			speedIdx = newIdx
			UpdateSpeedUI()
		end
	end
end)

UpdateSpeedUI() -- Init slider pos

local notifRow = MakeSettingRow("99427666057293", L.notif, 3)
local notifBtn = Instance.new("TextButton")
notifBtn.Size = UDim2.new(0.4, 0, 0, 36)
notifBtn.Position = UDim2.new(0.56, 0, 0.5, -18)
notifBtn.BackgroundColor3 = Settings.notifications and currentTheme.success or currentTheme.critical
notifBtn.Text = Settings.notifications and L.on or L.off
notifBtn.TextColor3 = Color3.new(1, 1, 1)
notifBtn.Font = Enum.Font.GothamBold
notifBtn.TextSize = isMobile and 12 or 14
notifBtn.ZIndex = 8
notifBtn.Parent = notifRow
Instance.new("UICorner", notifBtn).CornerRadius = UDim.new(0, 10)

notifBtn.MouseButton1Click:Connect(function()
	Settings.notifications = not Settings.notifications
	notifBtn.Text = Settings.notifications and L.on or L.off
	TweenService:Create(notifBtn, TweenInfo.new(0.2), {
		BackgroundColor3 = Settings.notifications and currentTheme.success or currentTheme.critical
	}):Play()
	SaveData()
end)

local contRow = MakeSettingRow("76975628127992", L.loopText or "Loop", 4)
local contBtn = Instance.new("TextButton")
contBtn.Size = UDim2.new(0.4, 0, 0, 36)
contBtn.Position = UDim2.new(0.56, 0, 0.5, -18)
contBtn.BackgroundColor3 = Settings.loopEmote and currentTheme.success or currentTheme.critical
contBtn.Text = Settings.loopEmote and L.on or L.off
contBtn.TextColor3 = Color3.new(1, 1, 1)
contBtn.Font = Enum.Font.GothamBold
contBtn.TextSize = isMobile and 12 or 14
contBtn.ZIndex = 8
contBtn.Parent = contRow
Instance.new("UICorner", contBtn).CornerRadius = UDim.new(0, 10)

contBtn.MouseButton1Click:Connect(function()
	Settings.loopEmote = not Settings.loopEmote
	getgenv().autoReloadEnabled_Vexro = Settings.loopEmote
	contBtn.Text = Settings.loopEmote and L.on or L.off
	TweenService:Create(contBtn, TweenInfo.new(0.2), {
		BackgroundColor3 = Settings.loopEmote and currentTheme.success or currentTheme.critical
	}):Play()
	SaveData()
end)

-- Reset Language butonu
local langResetRow = MakeSettingRow("", "Reset Language", 5)
local langResetBtn = Instance.new("TextButton")
langResetBtn.Size = UDim2.new(0.4, 0, 0, 36)
langResetBtn.Position = UDim2.new(0.56, 0, 0.5, -18)
langResetBtn.BackgroundColor3 = currentTheme.critical
langResetBtn.Text = "Reset"
langResetBtn.TextColor3 = Color3.new(1, 1, 1)
langResetBtn.Font = Enum.Font.GothamBold
langResetBtn.TextSize = isMobile and 12 or 14
langResetBtn.ZIndex = 8
langResetBtn.Parent = langResetRow
Instance.new("UICorner", langResetBtn).CornerRadius = UDim.new(0, 10)
RegisterTheme(langResetBtn, "BackgroundColor3", "critical")

langResetBtn.MouseButton1Click:Connect(function()
	Settings.language = nil
	SaveData()
	gui:Destroy()
	-- Script'i yeniden çalıştır
	pcall(function()
		if getgenv and getgenv().lastVexroEmote then
			getgenv().lastVexroEmote = nil
		end
	end)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/zyrovell/Vexro/main/vexroemotes.lua"))()
end)

-- Copy Emote toggle + ProximityPrompt sistemi
local copyEmoteRow, copyEmoteTitleLbl = MakeSettingRow("", L.copyEmote, 6, 68)
copyEmoteTitleLbl.Size     = UDim2.new(0.52, -12, 0, 24)
copyEmoteTitleLbl.Position = UDim2.new(0, 12, 0, 6)

local copyEmoteDescLbl = Instance.new("TextLabel")
copyEmoteDescLbl.Size                   = UDim2.new(0.52, -12, 0, 34)
copyEmoteDescLbl.Position               = UDim2.new(0, 12, 0, 28)
copyEmoteDescLbl.BackgroundTransparency = 1
copyEmoteDescLbl.Text                   = L.copyEmoteDesc
copyEmoteDescLbl.TextColor3             = Color3.fromRGB(110, 110, 135)
copyEmoteDescLbl.Font                   = Enum.Font.Gotham
copyEmoteDescLbl.TextSize               = isMobile and 10 or 11
copyEmoteDescLbl.TextXAlignment         = Enum.TextXAlignment.Left
copyEmoteDescLbl.TextYAlignment         = Enum.TextYAlignment.Top
copyEmoteDescLbl.TextWrapped            = true
copyEmoteDescLbl.ZIndex                 = 7
copyEmoteDescLbl.Parent                 = copyEmoteRow
RegisterTheme(copyEmoteDescLbl, "TextColor3", "textDim")

local copyEmoteToggleBtn = Instance.new("TextButton")
copyEmoteToggleBtn.Size             = UDim2.new(0.4, 0, 0, 36)
copyEmoteToggleBtn.Position         = UDim2.new(0.56, 0, 0.5, -18)
copyEmoteToggleBtn.BackgroundColor3 = Settings.copyEmoteEnabled and currentTheme.success or currentTheme.critical
copyEmoteToggleBtn.Text             = Settings.copyEmoteEnabled and L.on or L.off
copyEmoteToggleBtn.TextColor3       = Color3.new(1, 1, 1)
copyEmoteToggleBtn.Font             = Enum.Font.GothamBold
copyEmoteToggleBtn.TextSize         = isMobile and 12 or 14
copyEmoteToggleBtn.ZIndex           = 8
copyEmoteToggleBtn.Parent           = copyEmoteRow
Instance.new("UICorner", copyEmoteToggleBtn).CornerRadius = UDim.new(0, 10)

local PROMPT_TAG = "VexroCopyEmotePrompt"

local function MakeCopyPrompt(targetChar)
	local root = targetChar:FindFirstChild("HumanoidRootPart")
	if not root then return end
	if root:FindFirstChild(PROMPT_TAG) then return end
	local prompt = Instance.new("ProximityPrompt")
	prompt.Name              = PROMPT_TAG
	prompt.ActionText        = L.copyEmote
	prompt.ObjectText        = ""
	prompt.MaxActivationDistance = 10
	prompt.HoldDuration      = 0
	prompt.RequiresLineOfSight = false
	prompt.Enabled           = true
	prompt.Parent            = root
	prompt.Triggered:Connect(function()
		local h = targetChar:FindFirstChildOfClass("Humanoid")
		if not h then return end
		local anim = h:FindFirstChildOfClass("Animator")
		if not anim then return end
		for _, track in ipairs(anim:GetPlayingAnimationTracks()) do
			local animId = tonumber(track.Animation.AnimationId:match("%d+"))
			if animId and EmotesById[animId] then
				PlayEmote(animId, EmotesById[animId].name)
				return
			end
		end
	end)
end

local function RemoveCopyPrompt(targetChar)
	local root = targetChar:FindFirstChild("HumanoidRootPart")
	if root then
		local p = root:FindFirstChild(PROMPT_TAG)
		if p then p:Destroy() end
	end
end

local _copyEmoteConns = {}

local function EnableCopyEmotePrompts()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			MakeCopyPrompt(p.Character)
		end
	end
	_copyEmoteConns[#_copyEmoteConns + 1] = Players.PlayerAdded:Connect(function(p)
		_copyEmoteConns[#_copyEmoteConns + 1] = p.CharacterAdded:Connect(function(char)
			if Settings.copyEmoteEnabled then MakeCopyPrompt(char) end
		end)
	end)
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			_copyEmoteConns[#_copyEmoteConns + 1] = p.CharacterAdded:Connect(function(char)
				if Settings.copyEmoteEnabled then MakeCopyPrompt(char) end
			end)
		end
	end
end

local function DisableCopyEmotePrompts()
	for _, conn in ipairs(_copyEmoteConns) do conn:Disconnect() end
	_copyEmoteConns = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			RemoveCopyPrompt(p.Character)
		end
	end
end

if Settings.copyEmoteEnabled then
	EnableCopyEmotePrompts()
end

copyEmoteToggleBtn.MouseButton1Click:Connect(function()
	Settings.copyEmoteEnabled = not Settings.copyEmoteEnabled
	copyEmoteToggleBtn.Text = Settings.copyEmoteEnabled and L.on or L.off
	TweenService:Create(copyEmoteToggleBtn, TweenInfo.new(0.2), {
		BackgroundColor3 = Settings.copyEmoteEnabled and currentTheme.success or currentTheme.critical
	}):Play()
	if Settings.copyEmoteEnabled then
		EnableCopyEmotePrompts()
	else
		DisableCopyEmotePrompts()
	end
	SaveData()
end)

-- ===============================================================
-- BOTTOM BAR
-- ===============================================================

local bottomBar = Instance.new("Frame")
bottomBar.Size = UDim2.new(1, 0, 0, bottomBarH)
bottomBar.Position = UDim2.new(0, 0, 1, -bottomBarH)
bottomBar.BackgroundColor3 = currentTheme.tertiary
bottomBar.ZIndex = 15
bottomBar.Parent = content
Instance.new("UICorner", bottomBar).CornerRadius = UDim.new(0, 14)
RegisterTheme(bottomBar, "BackgroundColor3", "tertiary")

local bottomOverlay = Instance.new("Frame")
bottomOverlay.Size = UDim2.new(1, 0, 0, 8)
bottomOverlay.BackgroundColor3 = currentTheme.tertiary
bottomOverlay.BorderSizePixel = 0
bottomOverlay.ZIndex = 14
bottomOverlay.Parent = bottomBar
RegisterTheme(bottomOverlay, "BackgroundColor3", "tertiary")

local grip = Instance.new("Frame")
grip.Size = UDim2.new(0, 40, 0, 4)
grip.Position = UDim2.new(0.5, -20, 0.5, -2)
grip.BackgroundColor3 = currentTheme.textDim
grip.ZIndex = 16
grip.Parent = bottomBar
Instance.new("UICorner", grip).CornerRadius = UDim.new(1, 0)
RegisterTheme(grip, "BackgroundColor3", "textDim")

local scrollY = titleH + searchH + 14
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -16, 1, -(scrollY + pageH + bottomBarH + 18))
scroll.Position = UDim2.new(0, 8, 0, scrollY)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = isMobile and 3 or 5
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarImageColor3 = currentTheme.stroke
scroll.ZIndex = 1
scroll.Parent = content
RegisterTheme(scroll, "ScrollBarImageColor3", "stroke")

-- ===============================================================
-- CARD SYSTEM (RESPONSIVE GRID)
-- ===============================================================

local function CalcLayout()
	local PAD = isMobile and 4 or 6
	local w = scroll.AbsoluteSize.X
	
	-- Determine minimal viable card size to allow more columns
	local minCardSize = isMobile and TARGET_MOBILE_CARD or TARGET_PC_CARD
	
	-- Calculate how many columns fit
	cols = math.floor(w / (minCardSize + PAD))
	if cols < 1 then cols = 1 end
	
	-- Expand card size slightly to fill gaps
	currentCardSize = (w - (PAD * (cols - 1))) / cols
	
	-- Calculate rows based on available height to fill page mostly
	local NAME_H = math.clamp(currentCardSize * 0.35, 18, 28)
	local FAV_H = math.clamp(currentCardSize * 0.3, 18, 24)
	local CARD_TOTAL_H = currentCardSize + NAME_H + FAV_H
	
	local rowsVisible = math.floor(scroll.AbsoluteSize.Y / (CARD_TOTAL_H + PAD))
	if rowsVisible < 2 then rowsVisible = 2 end
	
	-- Determine items per page dynamically
	perPage = cols * rowsVisible
	
	pages = math.max(1, math.ceil(#filtered / perPage))
	page = math.clamp(page, 1, pages)
end

local function UpdatePageUI()
	pageNum.Text = page .. "/" .. pages
	local show = pages > 1
	prevBtn.Visible = show
	nextBtn.Visible = show
	
	if prevBtn:FindFirstChild("ChevronIcon") then 
		for _, c in ipairs(prevBtn.ChevronIcon:GetChildren()) do c.BackgroundColor3 = Color3.new(0, 0, 0) end
	end
	if nextBtn:FindFirstChild("ChevronIcon") then 
		for _, c in ipairs(nextBtn.ChevronIcon:GetChildren()) do c.BackgroundColor3 = Color3.new(0, 0, 0) end
	end
	
	pageBar.Visible = currentTab ~= "settings" and pages > 1
	
	local empty = #filtered == 0 and currentTab ~= "settings"
	emptyLbl.Visible = empty
	if currentTab == "favorites" then emptyLbl.Text = L.noFav
	elseif currentTab == "recent" then emptyLbl.Text = L.noRecent end
end

local function ClearCards()
	for _, c in pairs(cards) do
		if c and c.Parent then c:Destroy() end
	end
	cards = {}
end

local function MakeCard(emote, ci, animate)
	local CARD = currentCardSize
	local PAD = isMobile and 4 or 6
	
	-- Dynamic text height based on card size, but capped
	local NAME_H = math.clamp(CARD * 0.35, 18, 28)
	local FAV_H = math.clamp(CARD * 0.3, 18, 24)
	local CARD_TOTAL_H = CARD + NAME_H + FAV_H
	
	-- Ana kart container
	local cardContainer = Instance.new("Frame")
	cardContainer.Size = UDim2.new(0, CARD, 0, CARD_TOTAL_H)
	cardContainer.BackgroundTransparency = 1
	cardContainer.ZIndex = 2
	cardContainer.Parent = scroll
	
	local col = ci % cols
	local row = math.floor(ci / cols)
	
	-- Position logic for grid
	local targetX = col * (CARD + PAD)
	local targetY = PAD + row * (CARD_TOTAL_H + PAD)
	
	if animate then
		cardContainer.Position = UDim2.new(0, targetX, 0, targetY + 30)
		cardContainer.BackgroundTransparency = 1
		
		task.delay(ci * 0.02, function()
			if cardContainer.Parent then
				TweenService:Create(cardContainer, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
					Position = UDim2.new(0, targetX, 0, targetY)
				}):Play()
			end
		end)
	else
		cardContainer.Position = UDim2.new(0, targetX, 0, targetY)
	end
	
	local card = Instance.new("ImageButton")
	card.Size = UDim2.new(1, 0, 0, CARD)
	card.Position = UDim2.new(0, 0, 0, 0)
	card.BackgroundColor3 = currentTheme.tertiary
	card.ScaleType = Enum.ScaleType.Fit
	card.ZIndex = 3
	card.Parent = cardContainer
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
	
	card.Image = "rbxthumb://type=Asset&id=" .. emote.id .. "&w=420&h=420"
	-- Cards are dynamic, register/unregister is complex. We set color directly on refresh.
	card.BackgroundColor3 = currentTheme.tertiary 
	
	if animate then
		card.ImageTransparency = 1
		task.delay(ci * 0.02, function()
			if card.Parent then
				TweenService:Create(card, TweenInfo.new(0.25), {ImageTransparency = 0}):Play()
			end
		end)
	end
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = currentTheme.accent
	stroke.Thickness = 2
	stroke.Transparency = 0.6
	stroke.Parent = card
	
	-- İsim Label (resmin altında)
	local nameLbl = Instance.new("TextLabel")
	nameLbl.Size = UDim2.new(1, -4, 0, NAME_H - 2) 
	nameLbl.Position = UDim2.new(0, 2, 0, CARD)
	nameLbl.BackgroundColor3 = currentTheme.secondary
	nameLbl.Text = emote.name
	nameLbl.TextColor3 = currentTheme.text
	nameLbl.Font = Enum.Font.GothamBold
	nameLbl.TextScaled = true
	nameLbl.TextWrapped = true 
	nameLbl.Active = true 
	nameLbl.ZIndex = 3
	nameLbl.Parent = cardContainer
	Instance.new("UICorner", nameLbl).CornerRadius = UDim.new(0, 4)
	
	nameLbl.MouseEnter:Connect(function()
		TweenService:Create(nameLbl, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
			Size = UDim2.new(1, 4, 0, NAME_H + 4),
			Rotation = math.random(-2, 2)
		}):Play()
	end)
	
	nameLbl.MouseLeave:Connect(function()
		TweenService:Create(nameLbl, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			Size = UDim2.new(1, -4, 0, NAME_H - 2),
			Rotation = 0
		}):Play()
	end)
	
	
	local isFav = IsFavorite(emote.id)
	local favBtn = Instance.new("TextButton")
	favBtn.Size = UDim2.new(1, 0, 0, FAV_H)
	favBtn.Position = UDim2.new(0, 0, 0, CARD + NAME_H)
	favBtn.BackgroundColor3 = currentTheme.accent
	favBtn.BackgroundTransparency = 1 -- Kareyi kaldır
	favBtn.Text = ""
	favBtn.ZIndex = 4
	favBtn.Parent = cardContainer
	Instance.new("UICorner", favBtn).CornerRadius = UDim.new(0, 4)

	local favIcon = Instance.new("TextLabel")
	local iconSize = isMobile and 28 or 34
	favIcon.Size = UDim2.new(0, iconSize, 0, iconSize)
	favIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	favIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	favIcon.BackgroundTransparency = 1
	favIcon.Text = isFav and utf8.char(0x2605) or utf8.char(0x2606)
	favIcon.TextColor3 = isFav and Color3.fromRGB(255, 215, 0) or currentTheme.accent
	favIcon.Font = Enum.Font.SourceSansLight
	favIcon.TextSize = isMobile and 26 or 32
	favIcon.TextScaled = false
	favIcon.ZIndex = 50
	favIcon.Parent = favBtn
	
	favBtn.MouseEnter:Connect(function()
		TweenService:Create(favBtn, TweenInfo.new(0.15, Enum.EasingStyle.Back), {
			BackgroundColor3 = isFav and currentTheme.tertiary or currentTheme.accent,
			Size = UDim2.new(1, 6, 0, FAV_H + 6),
			Rotation = math.random(-2, 2)
		}):Play()
	end)
	favBtn.MouseLeave:Connect(function()
		TweenService:Create(favBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
			BackgroundColor3 = isFav and currentTheme.tertiary or currentTheme.stroke,
			Size = UDim2.new(1, 0, 0, FAV_H),
			Rotation = 0
		}):Play()
	end)
	
	favBtn.MouseButton1Click:Connect(function()
		isFav = ToggleFavorite(emote.id)
		
		if isFav then
			favIcon.Text = utf8.char(0x2605)
			favIcon.TextColor3 = Color3.fromRGB(255, 215, 0)
		else
			favIcon.Text = utf8.char(0x2606)
			favIcon.TextColor3 = currentTheme.accent
		end
		
		TweenService:Create(favBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = isFav and currentTheme.tertiary or currentTheme.stroke
		}):Play()
		
		-- YILDIZ PATLAMA ANİMASYONU
		if isFav then
			favIcon.Size = UDim2.new(0, 0, 0, 0)
			TweenService:Create(favIcon, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, iconSize + 6, 0, iconSize + 6)
			}):Play()
			task.delay(0.2, function()
				TweenService:Create(favIcon, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
					Size = UDim2.new(0, iconSize, 0, iconSize)
				}):Play()
			end)
			
			local ripple = Instance.new("Frame")
			ripple.Size = UDim2.new(0, 0, 0, 0)
			ripple.Position = UDim2.fromScale(0.5, 0.5)
			ripple.AnchorPoint = Vector2.new(0.5, 0.5)
			ripple.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
			ripple.BackgroundTransparency = 0.3
			ripple.ZIndex = 4
			ripple.Parent = favBtn
			Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
			
			TweenService:Create(ripple, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(2, 0, 2, 0),
				BackgroundTransparency = 1
			}):Play()
			task.delay(0.4, function() if ripple then ripple:Destroy() end end)
		else
			-- Geri alırken küçük bir küçülme efekti
			TweenService:Create(favIcon, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				Size = UDim2.new(0, iconSize - 4, 0, iconSize - 4)
			}):Play()
			task.delay(0.2, function()
				TweenService:Create(favIcon, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, iconSize, 0, iconSize)
				}):Play()
			end)
		end
		
		if currentTab == "favorites" then
			task.delay(0.4, function()
				if currentTab == "favorites" then UpdateTabData() end
			end)
		end
	end)
	
	
	card.MouseEnter:Connect(function()
		-- Hafif büyütme ve tilt efekti
		TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
			Size = UDim2.new(1, 6, 0, CARD + 6),
			Rotation = math.random(-2, 2)
		}):Play()
		-- Stroke parlaması
		TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0, Thickness = 2.5, Color = currentTheme.accent}):Play()
	end)
	
	card.MouseLeave:Connect(function()
		-- Normale dönüş
		TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			Size = UDim2.new(1, 0, 0, CARD),
			Rotation = 0
		}):Play()
		TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0.6, Thickness = 2, Color = currentTheme.accent}):Play()
	end)
	
	
	card.MouseButton1Click:Connect(function()
		-- İçeri göçme (Jelly)
		TweenService:Create(card, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0.9, 0, 0, CARD * 0.9)}):Play()
		
		task.delay(0.1, function()
			-- Geri fırlama
			TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {Size = UDim2.new(1, 0, 0, CARD)}):Play()
		end)
		
		TweenService:Create(stroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(80, 220, 120)}):Play()
		task.delay(0.3, function()
			if card.Parent then
				TweenService:Create(stroke, TweenInfo.new(0.2), {Color = currentTheme.accent}):Play()
			end
		end)
		
		PlayEmote(emote.id, emote.name)
	end)
	
	return cardContainer
end

local function UpdateCards(animate)
	ClearCards()
	
	local startIdx = (page - 1) * perPage + 1
	local endIdx = math.min(page * perPage, #filtered)
	
	local ci = 0
	for i = startIdx, endIdx do
		if filtered[i] then
			cards[i] = MakeCard(filtered[i], ci, animate)
			ci = ci + 1
		end
	end
	
	local CARD = currentCardSize
	local PAD = isMobile and 4 or 6
	local NAME_H = math.clamp(CARD * 0.35, 18, 28)
	local FAV_H = math.clamp(CARD * 0.3, 18, 24)
	local CARD_TOTAL_H = CARD + NAME_H + FAV_H
	
	local rows = math.ceil(ci / math.max(cols, 1))
	scroll.CanvasSize = UDim2.new(0, 0, 0, rows * (CARD_TOTAL_H + PAD) + PAD)
	scroll.CanvasPosition = Vector2.zero
end

local function Refresh(animate)
	CalcLayout()
	UpdatePageUI()
	UpdateCards(animate ~= false)
end

prevBtn.MouseButton1Click:Connect(function()
	if pages <= 1 then return end
	if page > 1 then 
		page = page - 1
	else 
		page = pages -- Loop to end
	end
	Refresh(true)
end)
nextBtn.MouseButton1Click:Connect(function()
	if pages <= 1 then return end
	if page < pages then 
		page = page + 1
	else 
		page = 1 -- Loop to start
	end
	Refresh(true)
end)

-- ===============================================================
-- TAB SYSTEM
-- ===============================================================

UpdateTabStyles = function()
	local isM3 = Settings.theme == "MaterialYou"
	for name, data in pairs(tabBtns) do
		local active = currentTab == name
		local targetColor = active and currentTheme.accent or currentTheme.sidebar
		local targetIconColor = active and Color3.new(1, 1, 1) or currentTheme.text
		
		-- Quatrefoil göstergesi (sadece MaterialYou)
		if data.quatrefoil then
			if isM3 and active then
				data.quatrefoil.Visible = true
				data.quatrefoil.ImageColor3 = currentTheme.accent
				local qSize = tabBtnS + 10
				data.quatrefoil.Size = UDim2.new(0, 0, 0, 0)
				TweenService:Create(data.quatrefoil, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, qSize, 0, qSize),
					ImageTransparency = 0.3
				}):Play()
			else
				if data.quatrefoil.Visible then
					local qRef = data.quatrefoil
					TweenService:Create(qRef, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Size = UDim2.new(0, 0, 0, 0),
						ImageTransparency = 1
					}):Play()
					task.delay(0.2, function()
						if qRef and qRef.Parent then qRef.Visible = false end
					end)
				end
			end
		end
		
		if isM3 then
			TweenService:Create(data.btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
				BackgroundTransparency = active and 1 or 0.85,
				BackgroundColor3 = currentTheme.sidebar,
				Size = UDim2.new(0, tabBtnS, 0, tabBtnS)
			}):Play()
			TweenService:Create(data.stroke, TweenInfo.new(0.25), {
				Transparency = 1
			}):Play()
		else
			TweenService:Create(data.btn, TweenInfo.new(0.2), {
				BackgroundTransparency = active and 0.2 or 0.8,
				BackgroundColor3 = targetColor,
				Size = UDim2.new(0, active and tabBtnS + 4 or tabBtnS, 0, active and tabBtnS + 4 or tabBtnS)
			}):Play()
			TweenService:Create(data.stroke, TweenInfo.new(0.2), {
				Transparency = active and 0 or 0.7,
				Color = active and currentTheme.accent or currentTheme.stroke,
				Thickness = active and 3 or 2
			}):Play()
		end
		
		if data.img then
			TweenService:Create(data.img, TweenInfo.new(0.2), {
				ImageColor3 = targetIconColor
			}):Play()
		else
			TweenService:Create(data.btn, TweenInfo.new(0.2), {
				TextColor3 = targetIconColor
			}):Play()
		end
	end
end

UpdateTabData = function()
	search.Text = ""
	page = 1
	
	local isSettings = currentTab == "settings"
	settingsPanel.Visible = isSettings
	scroll.Visible = not isSettings
	search.Visible = not isSettings
	pageBar.Visible = not isSettings
	if isSettings then
		emptyLbl.Visible = false
	end
	
	if currentTab == "emotes" then
		currentData = Emotes
		filtered = Emotes
		title.Text = L.emotes
		titleIcon.Image = ResolveAssetImage(Icons.Emote)
		titleIcon.ImageColor3 = currentTheme.text
		titleIcon.Visible = true
	elseif currentTab == "favorites" then
		currentData = {}
		for i = 1, #Favorites do
			local emote = EmotesById[Favorites[i]]
			if emote then
				currentData[#currentData + 1] = emote
			end
		end
		filtered = currentData
		title.Text = L.favorites
		titleIcon.Image = ResolveAssetImage(Icons.FavoriteFull)
		titleIcon.ImageColor3 = currentTheme.text
		titleIcon.Visible = true

	elseif currentTab == "recent" then
		currentData = {}
		for i = 1, #RecentEmotes do
			local emote = EmotesById[RecentEmotes[i]]
			if emote then
				currentData[#currentData + 1] = emote
			end
		end
		filtered = currentData
		title.Text = L.recent
		titleIcon.Image = ResolveAssetImage(Icons.Recent)
		titleIcon.ImageColor3 = currentTheme.text
		titleIcon.Visible = true
	elseif currentTab == "settings" then
		title.Text = L.settings
		titleIcon.Image = ResolveAssetImage(Icons.Settings)
		titleIcon.ImageColor3 = currentTheme.text
		titleIcon.Visible = true
	end
	
	local tabIconSz = titleIconSz
	if currentTab ~= "emotes" then
		tabIconSz = math.floor(titleIconSz * 1.3)
	end
	titleIcon.Size = UDim2.new(0, tabIconSz, 0, tabIconSz)
	title.Position = UDim2.new(0, titleIcon.Visible and (10 + tabIconSz + 6) or 10, 0, 0)
	
	UpdateTabStyles()
	if not isSettings then Refresh(true) end
end

tabBtns["emotes"].btn.MouseButton1Click:Connect(function() currentTab = "emotes"; UpdateTabData() end)
tabBtns["favorites"].btn.MouseButton1Click:Connect(function() currentTab = "favorites"; UpdateTabData() end)

tabBtns["recent"].btn.MouseButton1Click:Connect(function() currentTab = "recent"; UpdateTabData() end)
tabBtns["settings"].btn.MouseButton1Click:Connect(function() currentTab = "settings"; UpdateTabData() end)

local searchToken = 0
search:GetPropertyChangedSignal("Text"):Connect(function()
	if currentTab == "settings" then return end
	searchToken = searchToken + 1
	local myToken = searchToken
	task.wait(0.08)
	if myToken ~= searchToken then return end -- Newer input supersedes
	local q = search.Text:lower()
	filtered = {}
	for i = 1, #currentData do
		local e = currentData[i]
		if q == "" or e.name:lower():find(q, 1, true) then
			filtered[#filtered + 1] = e
		end
	end
	page = 1
	Refresh(true)
end)

-- ===============================================================
-- MINI ICON
-- ===============================================================

local iconS = isMobile and 50 or 60
local miniIcon = Instance.new("ImageButton")
miniIcon.Size = UDim2.new(0, iconS, 0, iconS)
miniIcon.Position = UDim2.new(0, 20, 0.5, -iconS/2)
miniIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
miniIcon.Image = "rbxassetid://88874992610290"
miniIcon.Visible = false
miniIcon.ZIndex = 1000
miniIcon.Parent = gui
Instance.new("UICorner", miniIcon).CornerRadius = UDim.new(1, 0)

local miniIconStroke = Instance.new("UIStroke")
miniIconStroke.Color = Color3.new(1, 1, 1) -- Gradient için beyaz taban
miniIconStroke.Thickness = 3
miniIconStroke.Parent = miniIcon

miniIconGrad = Instance.new("UIGradient")
miniIconGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, currentTheme.stroke),
	ColorSequenceKeypoint.new(0.33, currentTheme.accent),
	ColorSequenceKeypoint.new(0.66, currentTheme.stroke),
	ColorSequenceKeypoint.new(1, currentTheme.accent)
}
miniIconGrad.Parent = miniIconStroke

task.spawn(function()
	local rot = 0
	while miniIcon.Parent do
		rot = rot + 360
		TweenService:Create(miniIconGrad, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = rot}):Play()
		task.wait(2)
	end
end)

task.spawn(function()
	while miniIcon.Parent do
		if miniIcon.Visible then
			TweenService:Create(miniIcon, TweenInfo.new(1, Enum.EasingStyle.Sine), {Size = UDim2.new(0, iconS + 4, 0, iconS + 4)}):Play()
			task.wait(1)
			TweenService:Create(miniIcon, TweenInfo.new(1, Enum.EasingStyle.Sine), {Size = UDim2.new(0, iconS, 0, iconS)}):Play()
			task.wait(1)
		else
			task.wait(0.5)
		end
	end
end)

local savedPos, savedSize = nil, nil
local iconDragging, iconDragStart, iconStartPos = false, nil, nil

miniIcon.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		iconDragging = true
		iconDragStart = input.Position
		iconStartPos = miniIcon.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if iconDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - iconDragStart
		miniIcon.Position = UDim2.new(iconStartPos.X.Scale, iconStartPos.X.Offset + delta.X, iconStartPos.Y.Scale, iconStartPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if iconDragging then
			local delta = input.Position - iconDragStart
			if math.abs(delta.X) < 5 and math.abs(delta.Y) < 5 then
				miniIcon.Visible = false
				main.Visible = true
				main.ClipsDescendants = true
				main.Size = UDim2.new(0, 0, 0, 0)
				main.BackgroundTransparency = 1
				main.Rotation = -15
				
				local targetSize = savedSize or GetDefaultSize()
				local targetPos = savedPos or UDim2.fromScale(0.5, 0.5)
				main.Position = targetPos
				
				TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Back), {Size = targetSize, BackgroundTransparency = 0, Rotation = 0}):Play()
				TweenService:Create(mainStroke, TweenInfo.new(0.35), {Transparency = 0}):Play()
				
				task.delay(0.4, function()
					main.ClipsDescendants = false
					if currentTab ~= "settings" then Refresh(true) end
				end)
			end
		end
		iconDragging = false
	end
end)

minBtn.MouseButton1Click:Connect(function()
	savedPos = main.Position
	savedSize = main.Size
	
	TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, Rotation = 15}):Play()
	TweenService:Create(mainStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
	
	task.delay(0.3, function()
		main.Visible = false
		miniIcon.Visible = true
	end)
end)

closeBtn.MouseButton1Click:Connect(function()
	TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, Rotation = -30}):Play()
	task.wait(0.25)
	gui:Destroy()
end)

-- ===============================================================
-- DRAG & RESIZE
-- ===============================================================

local dragging, dragStart, startPos = false, nil, nil

local function StartDrag(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end

titleBar.InputBegan:Connect(StartDrag)
bottomBar.InputBegan:Connect(StartDrag)
sidebar.InputBegan:Connect(StartDrag)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

local resizeS = isMobile and 28 or 22
local resizeBtn = Instance.new("TextButton")
resizeBtn.Size = UDim2.new(0, resizeS, 0, resizeS)
resizeBtn.Position = UDim2.new(1, -resizeS - 3, 1, -resizeS - 3)
resizeBtn.BackgroundColor3 = currentTheme.stroke
resizeBtn.BackgroundTransparency = 0.4
resizeBtn.Text = "/"
resizeBtn.TextColor3 = currentTheme.textDim
resizeBtn.TextSize = isMobile and 12 or 14
resizeBtn.ZIndex = 100
resizeBtn.Parent = main
Instance.new("UICorner", resizeBtn).CornerRadius = UDim.new(0, 8)

local resizing, resizeStart, sizeStart = false, nil, nil
local lastRefreshTime = 0

resizeBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = true
		resizeStart = input.Position
		sizeStart = main.AbsoluteSize
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - resizeStart
		local newW = math.clamp(sizeStart.X + delta.X, 400, 1200) -- Expanded max width
		local newH = math.clamp(sizeStart.Y + delta.Y, 300, 800)
		main.Size = UDim2.new(0, newW, 0, newH)
		
		local now = tick()
		if now - lastRefreshTime > 0.1 then
			lastRefreshTime = now
			if currentTab ~= "settings" then Refresh(false) end
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and resizing then
		resizing = false
		if currentTab ~= "settings" then Refresh(false) end
	end
end)

-- ===============================================================
-- CHARACTER RESPAWN & AUTO-RELOAD
-- ===============================================================

-- Enable auto reload before listener registration
getgenv().autoReloadEnabled_Vexro = Settings.loopEmote

player.CharacterAdded:Connect(function(newChar)
	local newHum = newChar:WaitForChild("Humanoid", 5)
	if not newHum then return end
	
	-- R6 check
	if newHum.RigType == Enum.HumanoidRigType.R6 then
		Notify(utf8.char(0x274C), L.r6Msg)
		task.wait(2)
		gui:Destroy()
		return
	end
	
	-- Auto-reload last emote after respawn
	if getgenv().lastVexroEmote and getgenv().autoReloadEnabled_Vexro then
		task.wait(1)
		PlayEmote(getgenv().lastVexroEmote.id, getgenv().lastVexroEmote.name, true)
		Notify("[R]", L.ready or "Emote reapplied")
	end
end)

-- ===============================================================
-- INITIALIZE
-- ===============================================================

main.Rotation = -10
local openSize = GetDefaultSize()
TweenService:Create(main, TweenInfo.new(0.45, Enum.EasingStyle.Back), {Size = openSize, BackgroundTransparency = 0, Rotation = 0}):Play()
TweenService:Create(mainStroke, TweenInfo.new(0.45), {Transparency = 0}):Play()

task.wait(0.5)

main.ClipsDescendants = false
ApplyTheme(Settings.theme)
UpdateTabStyles()
UpdateTabData()

task.wait(0.25)
Notify(utf8.char(0x2705) .. " " .. L.ready, #Emotes .. " emotes")

-- ================================================================
-- VEXRO EXTENDED MODULES v1.0
-- Bölüm 1: Dinamik Tema  |  Bölüm 2: Animation Blending & Combo
-- Bölüm 3: Canlı Emote HUD  |  Bölüm 4: Entegrasyon
-- NOT: do...end bloğu Lua'nın 200 local sınırını aşmamak için
-- ================================================================
local function _VexroExtend() -- Ayrı fonksiyon: kendi 200 register tablosu

-- ----------------------------------------------------------------
-- BÖLÜM 1 — DİNAMİK TEMA (Dynamic Theme)
-- BackgroundTransparency 0.6-0.7, Lighting tabanlı renk takibi,
-- TweenService ile 2 saniyelik yumuşak geçişler.
-- ----------------------------------------------------------------

-- "Dynamic" seçeneğini tema listesine ekle (script tekrar çalıştırılırsa iki kez eklenmesin)
if not table.find(themeNames, "Dynamic") then
	table.insert(themeNames, "Dynamic")
end

-- Dynamic için başlangıç tema tanımı (Dark tabanlı, Lighting ile güncellenir)
Themes["Dynamic"] = {
	primary   = Color3.fromRGB(12, 12, 16),
	secondary = Color3.fromRGB(18, 18, 24),
	tertiary  = Color3.fromRGB(26, 26, 34),
	sidebar   = Color3.fromRGB(10, 10, 14),
	accent    = Color3.fromRGB(130, 160, 220),
	text      = Color3.new(1, 1, 1),
	textDim   = Color3.fromRGB(150, 150, 160),
	stroke    = Color3.fromRGB(55, 65, 100),
	critical  = Color3.fromRGB(220, 60, 60),
	success   = Color3.fromRGB(80, 200, 100),
}

local isDynamicActive = false

-- Lighting.OutdoorAmbient → vurgu rengi
-- Max 0.72 ile sınırlıyoruz: buton arka planı asla beyaza dönmesin
local function GetLightingAccent()
	local lighting = game:GetService("Lighting")
	local c = lighting.OutdoorAmbient
	local r = math.clamp(c.R * 2.0 + 0.10, 0.15, 0.72)
	local g = math.clamp(c.G * 2.0 + 0.10, 0.15, 0.72)
	local b = math.clamp(c.B * 2.2 + 0.14, 0.18, 0.82)
	-- En az 1 kanal belirgin olsun (gri olmaya çalışmasın)
	local maxC = math.max(r, g, b)
	if maxC < 0.30 then
		local boost = 0.30 / maxC
		r = math.min(r * boost, 0.72)
		g = math.min(g * boost, 0.72)
		b = math.min(b * boost, 0.82)
	end
	return Color3.new(r, g, b)
end

-- Lighting.Ambient → arkaplan rengi
local function GetLightingPrimary()
	local lighting = game:GetService("Lighting")
	local c = lighting.Ambient
	local r = math.clamp(c.R * 0.85, 0.04, 0.14)
	local g = math.clamp(c.G * 0.85, 0.04, 0.14)
	local b = math.clamp(c.B * 0.90, 0.05, 0.18)
	return Color3.new(r, g, b)
end

-- Dynamic tema güncelleme döngüsü (2 saniyelik periyot)
local function RunDynamicThemeLoop()
	task.spawn(function()
		while isDynamicActive do
			local accent  = GetLightingAccent()
			local primary = GetLightingPrimary()

			-- Tema renklerini Lighting değerlerine göre güncelle
			Themes["Dynamic"].accent    = accent
			-- Stroke: accent'in %35'i, max 0.30 → asla beyazlaşmasın
			Themes["Dynamic"].stroke    = Color3.new(
				math.min(accent.R * 0.35, 0.30),
				math.min(accent.G * 0.35, 0.30),
				math.min(accent.B * 0.35, 0.30)
			)
			Themes["Dynamic"].primary   = primary
			Themes["Dynamic"].secondary = Color3.new(
				math.clamp(primary.R * 1.5, 0, 0.20),
				math.clamp(primary.G * 1.5, 0, 0.20),
				math.clamp(primary.B * 1.5, 0, 0.26)
			)
			Themes["Dynamic"].sidebar   = Color3.new(
				math.clamp(primary.R * 0.65, 0, 0.09),
				math.clamp(primary.G * 0.65, 0, 0.09),
				math.clamp(primary.B * 0.65, 0, 0.11)
			)

			currentTheme = Themes["Dynamic"]
			local tweenInfo = TweenInfo.new(1.8, Enum.EasingStyle.Sine)

			-- Tüm kayıtlı elementlere renk tween uygula
			local alive = {}
			for _, t in ipairs(themeElements) do
				if t.el and t.el.Parent then
					alive[#alive + 1] = t
					if currentTheme[t.key] then
						pcall(function()
							TweenService:Create(t.el, tweenInfo, {[t.prop] = currentTheme[t.key]}):Play()
						end)
					end
				end
			end
			themeElements = alive

			-- Gradient renklerini güncelle
			local newSeq = ColorSequence.new{
				ColorSequenceKeypoint.new(0,    currentTheme.stroke),
				ColorSequenceKeypoint.new(0.33, currentTheme.accent),
				ColorSequenceKeypoint.new(0.66, currentTheme.stroke),
				ColorSequenceKeypoint.new(1,    currentTheme.accent),
			}
			if mainStrokeGrad then mainStrokeGrad.Color = newSeq end
			if miniIconGrad   then miniIconGrad.Color   = newSeq end

			task.wait(2) -- 2 saniyelik periyot
		end
	end)
end

-- Forward declarations: BÖLÜM 3'te tanımlanır; SetDynamicTransparency closure'ı için gerekli
local HUD, infoPanel, infoSpeedLbl, comboSlots, comboQueue_UI
local _currentInfoId, _currentInfoName
local _comboLoopEnabled = false   -- combo döngü modu
local _comboLoopList    = {}      -- döngü için orijinal liste kopyası

-- Frosted glass overlay'leri (sadece ilgili panellerin arkasında)
local _frostOverlays = {}

local function MakeFrostOverlay(target, zindex)
	local f = Instance.new("Frame")
	f.Name                   = "FrostOverlay"
	f.Size                   = UDim2.new(1, 0, 1, 0)
	f.Position               = UDim2.new(0, 0, 0, 0)
	f.BackgroundColor3       = Color3.new(1, 1, 1)
	f.BackgroundTransparency = 1   -- başlangıçta görünmez
	f.BorderSizePixel        = 0
	f.ZIndex                 = zindex
	f.Parent                 = target
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 20)
	-- Hafif gradient: üst beyaz, alt şeffaf
	local grad = Instance.new("UIGradient")
	grad.Rotation    = 90
	grad.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.82),
		NumberSequenceKeypoint.new(1, 0.92),
	}
	grad.Parent = f
	return f
end

-- Dynamic tema aktifken panel şeffaflığı + lokal frosted glass
local function SetDynamicTransparency(enable)
	local ti = TweenInfo.new(0.6, Enum.EasingStyle.Sine)

	-- Panel şeffaflıkları
	TweenService:Create(main,      ti, {BackgroundTransparency = enable and 0.35 or 0}):Play()
	TweenService:Create(sidebar,   ti, {BackgroundTransparency = enable and 0.28 or 0}):Play()
	TweenService:Create(titleBar,  ti, {BackgroundTransparency = enable and 0.22 or 0}):Play()
	TweenService:Create(bottomBar, ti, {BackgroundTransparency = enable and 0.28 or 0}):Play()

	if enable then
		-- Her panele bir kez overlay ekle
		local targets = {
			{el = main,       z = 2},
			{el = infoPanel,  z = 699},
			{el = HUD,        z = 499},
		}
		for _, t in ipairs(targets) do
			-- Önceki varsa kullan, yoksa yeni oluştur
			local existing = t.el:FindFirstChild("FrostOverlay")
			local ov = existing or MakeFrostOverlay(t.el, t.z)
			_frostOverlays[#_frostOverlays + 1] = ov
			TweenService:Create(ov, ti, {BackgroundTransparency = 0.82}):Play()
		end
	else
		-- Tüm overlay'leri soldur ve sil
		for _, ov in ipairs(_frostOverlays) do
			if ov and ov.Parent then
				TweenService:Create(ov, ti, {BackgroundTransparency = 1}):Play()
				task.delay(0.6, function() pcall(function() ov:Destroy() end) end)
			end
		end
		_frostOverlays = {}
	end
end

-- ApplyTheme fonksiyonunu Dynamic için genişlet (upvalue sarmalama)
local _baseApplyTheme = ApplyTheme
ApplyTheme = function(name)
	if name ~= "Dynamic" then
		-- Dynamic döngüsünü durdur ve opaklığa dön
		isDynamicActive = false
		SetDynamicTransparency(false)
		_baseApplyTheme(name)
	else
		isDynamicActive = false -- Önceki döngüyü güvenle durdur
		task.wait(0.05)
		isDynamicActive = true
		currentTheme = Themes["Dynamic"]
		_baseApplyTheme("Dynamic")
		SetDynamicTransparency(true)
		RunDynamicThemeLoop()
	end
end

-- Başlangıçta Dynamic kayıtlıysa otomatik başlat
if Settings.theme == "Dynamic" then
	task.defer(function()
		isDynamicActive = true
		SetDynamicTransparency(true)
		RunDynamicThemeLoop()
	end)
end

-- ----------------------------------------------------------------
-- BÖLÜM 2 — ANİMASYON BLENDING & SEQUENCING (Combo Sistemi)
-- AnimationTrack:Play(0.3) ile 0.3s fade-in/out harmanlama,
-- Stopped sinyali ile otomatik sıralama, max 3 emote combo.
-- ----------------------------------------------------------------

-- Forward declaration: HUD fonksiyonları aşağıda tanımlanır
local ShowEmoteHUD, HideEmoteHUD

local ComboQueue    = {} -- {id, name} tablosu
local isComboActive = false

-- 0.3 saniyelik smooth fade ile tek bir combo adımını oynat
local function PlayComboStep(emoteId, emoteName)
	local animator = GetAnimator()
	if not animator then return end

	-- Mevcut animasyonu 0.3s fade-out ile durdur
	if currentAnimTrack and currentAnimTrack.IsPlaying then
		currentAnimTrack:Stop(0.3)
		task.wait(0.08)
	end

	-- Animasyonu cache'den al veya yükle
	local anim = _animCache[emoteId]
	if not anim then
		pcall(function()
			local ok, objects = pcall(function()
				return game:GetObjects("rbxassetid://" .. emoteId)
			end)
			if ok and objects and #objects > 0 then
				local item = objects[1]
				anim = item:IsA("Animation") and item
					or item:FindFirstChildWhichIsA("Animation", true)
			end
			if not anim then
				anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://" .. emoteId
			end
			_animCache[emoteId] = anim
		end)
	end
	if not anim then return end

	pcall(function()
		local track = animator:LoadAnimation(anim)
		track.Priority = Enum.AnimationPriority.Action4
		track.Looped   = false             -- Combo modunda döngü kapalı

		track:Play(0.3)                    -- 0.3s FADE-IN (harmanlama)
		task.delay(0.05, function()
			if track.IsPlaying then
				track:AdjustSpeed(Settings.speed)
			end
		end)

		currentAnimTrack = track
		getgenv().lastVexroEmote = {id = emoteId, name = emoteName}
		AddToRecent(emoteId)

		-- HUD'u göster (defer: ShowEmoteHUD aşağıda tanımlanır)
		task.defer(function()
			if ShowEmoteHUD then ShowEmoteHUD(emoteId, emoteName) end
		end)

		-- Track durduğunda → kuyrukta sonraki varsa çal, yoksa bitir
		track.Stopped:Connect(function()
			if not isComboActive then return end
			if #ComboQueue > 0 then
				local nxt = table.remove(ComboQueue, 1)
				PlayComboStep(nxt.id, nxt.name)
			else
				-- Döngü açıksa listeyi yeniden başlat, kuyruğu sıfırlama
				if _comboLoopEnabled and #_comboLoopList > 0 then
					ComboQueue = {}
					for i = 2, #_comboLoopList do
						ComboQueue[#ComboQueue + 1] = _comboLoopList[i]
					end
					PlayComboStep(_comboLoopList[1].id, _comboLoopList[1].name)
				else
					isComboActive = false
					task.defer(function()
						if HideEmoteHUD then HideEmoteHUD() end
					end)
					-- Combo bitince slot UI'ını sıfırla
					task.defer(function()
						if comboQueue_UI then comboQueue_UI = {} end
						if comboSlots then
							for j = 1, 3 do
								if comboSlots[j] then
									comboSlots[j].Text = L.slotLabel .. " " .. j
									TweenService:Create(comboSlots[j], TweenInfo.new(0.15), {
										BackgroundColor3 = Color3.fromRGB(30, 30, 46)
									}):Play()
								end
							end
						end
					end)
				end
			end
		end)
	end)
end

-- Combo sıralamasını başlat
local function StartCombo(emoteList)
	if #emoteList == 0 then return end
	isComboActive = true
	-- Döngü için orijinal listeyi sakla
	_comboLoopList = {}
	for _, e in ipairs(emoteList) do
		_comboLoopList[#_comboLoopList + 1] = {id = e.id, name = e.name}
	end
	ComboQueue = {}
	for i = 2, #emoteList do
		ComboQueue[#ComboQueue + 1] = emoteList[i]
	end
	PlayComboStep(emoteList[1].id, emoteList[1].name)
end

-- ----------------------------------------------------------------
-- BÖLÜM 3 — CANLI EMOTE HUD (Alt-Orta Şeffaf Panel)
-- RenderStepped canlı slider, hız butonları (0.1x–2x),
-- bilgi popup, sürüklenebilir knob, Disconnect ile FPS koruması.
-- ----------------------------------------------------------------

local hudTrackerConn = nil  -- RenderStepped bağlantısı (yönetilir)

-- ▸ Ana HUD çerçevesi (forward declared above — do NOT add local here)
HUD = Instance.new("Frame")
HUD.Name                   = "VexroHUD"
HUD.Size                   = isMobile and UDim2.new(0, 320, 0, 80) or UDim2.new(0, 500, 0, 84)
HUD.Position               = UDim2.new(0.5, 0, 1, -105)
HUD.AnchorPoint            = Vector2.new(0.5, 1)
HUD.BackgroundColor3       = Color3.fromRGB(8, 8, 12)
HUD.BackgroundTransparency = 0.30
HUD.BorderSizePixel        = 0
HUD.Visible                = false
HUD.ZIndex                 = 500
HUD.ClipsDescendants       = false
HUD.Parent                 = gui
Instance.new("UICorner", HUD).CornerRadius = UDim.new(0, 14)

local hudStroke = Instance.new("UIStroke")
hudStroke.Color        = currentTheme.stroke
hudStroke.Thickness    = 1.5
hudStroke.Transparency = 0.25
hudStroke.Parent       = HUD

-- ▸ Sol üst: Favori yıldızı
local hudFavBtn = Instance.new("ImageButton")
hudFavBtn.Size                   = UDim2.new(0, 22, 0, 22)
hudFavBtn.Position               = UDim2.new(0, 9, 0, 6)
hudFavBtn.BackgroundColor3       = Color3.fromRGB(30, 30, 46)
hudFavBtn.BackgroundTransparency = 0.20
hudFavBtn.Image                  = ResolveAssetImage(Icons.FavoriteEmpty)
hudFavBtn.ImageColor3            = currentTheme.accent
hudFavBtn.ZIndex                 = 502
hudFavBtn.Parent                 = HUD
Instance.new("UICorner", hudFavBtn).CornerRadius = UDim.new(1, 0)

local function RefreshHUDFavBtn()
	if not _currentInfoId then return end
	local isFav = IsFavorite(_currentInfoId)
	hudFavBtn.Image      = ResolveAssetImage(isFav and Icons.FavoriteFull or Icons.FavoriteEmpty)
	TweenService:Create(hudFavBtn, TweenInfo.new(0.15), {
		ImageColor3      = isFav and Color3.fromRGB(255, 215, 0) or currentTheme.accent,
		BackgroundColor3 = isFav and Color3.fromRGB(55, 45, 10) or Color3.fromRGB(30, 30, 46)
	}):Play()
end

hudFavBtn.MouseButton1Click:Connect(function()
	if not _currentInfoId then return end
	ToggleFavorite(_currentInfoId)
	RefreshHUDFavBtn()
end)

-- ▸ Sol alt: "i" bilgi ikonu
local hudInfoBtn = Instance.new("TextButton")
hudInfoBtn.Size                   = UDim2.new(0, 22, 0, 22)
hudInfoBtn.Position               = UDim2.new(0, 9, 0, 32)
hudInfoBtn.BackgroundColor3       = currentTheme.accent
hudInfoBtn.BackgroundTransparency = 0.40
hudInfoBtn.Text                   = "i"
hudInfoBtn.TextColor3             = Color3.new(1, 1, 1)
hudInfoBtn.Font                   = Enum.Font.GothamBold
hudInfoBtn.TextSize               = 12
hudInfoBtn.ZIndex                 = 502
hudInfoBtn.Parent                 = HUD
Instance.new("UICorner", hudInfoBtn).CornerRadius = UDim.new(1, 0)

-- ▸ Orta üst: Emote adı
local hudName = Instance.new("TextLabel")
hudName.Size                   = UDim2.new(1, -130, 0, 22)
hudName.Position               = UDim2.new(0, 44, 0, 7)
hudName.BackgroundTransparency = 1
hudName.Text                   = ""
hudName.TextColor3             = Color3.new(1, 1, 1)
hudName.Font                   = Enum.Font.GothamBold
hudName.TextSize               = isMobile and 13 or 15
hudName.TextXAlignment         = Enum.TextXAlignment.Left
hudName.TextTruncate           = Enum.TextTruncate.AtEnd
hudName.ZIndex                 = 501
hudName.Parent                 = HUD

-- ▸ Orta alt: Creator (daha küçük, sönük)
local hudCreator = Instance.new("TextLabel")
hudCreator.Size                   = UDim2.new(1, -130, 0, 15)
hudCreator.Position               = UDim2.new(0, 44, 0, 30)
hudCreator.BackgroundTransparency = 1
hudCreator.Text                   = "Vexro Emotes"
hudCreator.TextColor3             = Color3.fromRGB(120, 120, 145)
hudCreator.Font                   = Enum.Font.Gotham
hudCreator.TextSize               = isMobile and 10 or 11
hudCreator.TextXAlignment         = Enum.TextXAlignment.Left
hudCreator.ZIndex                 = 501
hudCreator.Parent                 = HUD

-- ▸ Progress slider arka planı
local hudSliderBg = Instance.new("Frame")
hudSliderBg.Size             = UDim2.new(1, -148, 0, 4)
hudSliderBg.Position         = UDim2.new(0, 44, 0, 54)
hudSliderBg.BackgroundColor3 = Color3.fromRGB(42, 42, 58)
hudSliderBg.ZIndex           = 501
hudSliderBg.Parent           = HUD
Instance.new("UICorner", hudSliderBg).CornerRadius = UDim.new(1, 0)

-- İlerleme (fill) kısmı
local hudFill = Instance.new("Frame")
hudFill.Size             = UDim2.new(0, 0, 1, 0)
hudFill.BackgroundColor3 = currentTheme.accent
hudFill.ZIndex           = 502
hudFill.Parent           = hudSliderBg
Instance.new("UICorner", hudFill).CornerRadius = UDim.new(1, 0)

-- Sürüklenebilir tutaç (knob)
local hudKnob = Instance.new("TextButton")
hudKnob.Size             = UDim2.new(0, 12, 0, 12)
hudKnob.AnchorPoint      = Vector2.new(0.5, 0.5)
hudKnob.Position         = UDim2.new(0, 0, 0.5, 0)
hudKnob.BackgroundColor3 = Color3.new(1, 1, 1)
hudKnob.Text             = ""
hudKnob.ZIndex           = 503
hudKnob.Parent           = hudSliderBg
Instance.new("UICorner", hudKnob).CornerRadius = UDim.new(1, 0)

-- ▸ Sağ: Hız kontrol butonları (0.1x  0.5x  1x  1.5x  2x)
local HUD_SPEEDS = {0.1, 0.5, 1, 1.5, 2}
local HUD_LABELS = {"0.1", "0.5", "1x", "1.5", "2x"}
local hudSpeedBtns = {}
local spBtnW   = isMobile and 26 or 30
local spBtnGap = 3
local spTotalW = #HUD_SPEEDS * spBtnW + (#HUD_SPEEDS - 1) * spBtnGap

-- Aktif hız butonunu vurgula
local function RefreshHUDSpeedBtns()
	for i, btn in ipairs(hudSpeedBtns) do
		local active = math.abs(HUD_SPEEDS[i] - Settings.speed) < 0.01
		TweenService:Create(btn, TweenInfo.new(0.15), {
			BackgroundColor3 = active and currentTheme.accent or Color3.fromRGB(30, 30, 46)
		}):Play()
	end
end

for si, spd in ipairs(HUD_SPEEDS) do
	local xOff = -(spTotalW + 8) + (si - 1) * (spBtnW + spBtnGap)
	local sBtn = Instance.new("TextButton")
	sBtn.Size                   = UDim2.new(0, spBtnW, 0, 20)
	sBtn.Position               = UDim2.new(1, xOff, 0, 7)
	sBtn.BackgroundColor3       = (math.abs(spd - Settings.speed) < 0.01)
		and currentTheme.accent or Color3.fromRGB(30, 30, 46)
	sBtn.BackgroundTransparency = 0.15
	sBtn.Text                   = HUD_LABELS[si]
	sBtn.TextColor3             = Color3.new(1, 1, 1)
	sBtn.Font                   = Enum.Font.GothamBold
	sBtn.TextSize               = 10
	sBtn.ZIndex                 = 502
	sBtn.Parent                 = HUD
	Instance.new("UICorner", sBtn).CornerRadius = UDim.new(0, 5)
	hudSpeedBtns[si] = sBtn

	sBtn.MouseButton1Click:Connect(function()
		Settings.speed = spd
		-- Anlık hız uygula (AdjustSpeed)
		if currentAnimTrack and currentAnimTrack.IsPlaying then
			pcall(function() currentAnimTrack:AdjustSpeed(spd) end)
		end
		RefreshHUDSpeedBtns()
		SaveData()
	end)
end

-- ▸ Bilgi Paneli — gui'ye bağlı ayrı sekme (HUD'a değil)
-- HUD'dan bağımsız; ClipsDescendants sorunu olmaz (forward declared above — do NOT add local here)
infoPanel = Instance.new("Frame")
infoPanel.Name                   = "VexroInfoPanel"
infoPanel.Size                   = UDim2.new(0, 270, 0, 260)
infoPanel.Position               = UDim2.new(0, -270, 1, -195) -- Başlangıç: sol dışarıda
infoPanel.BackgroundColor3       = Color3.fromRGB(10, 10, 18)
infoPanel.BackgroundTransparency = 0.08
infoPanel.BorderSizePixel        = 0
infoPanel.Visible                = false
infoPanel.ZIndex                 = 700
infoPanel.Parent                 = gui
Instance.new("UICorner", infoPanel).CornerRadius = UDim.new(0, 14)

local infoPanelStroke = Instance.new("UIStroke")
infoPanelStroke.Color       = currentTheme.accent
infoPanelStroke.Thickness   = 1.5
infoPanelStroke.Transparency = 0.30
infoPanelStroke.Parent      = infoPanel

-- Başlık çubuğu (sürükleme tutacağı)
local infoPanelTitle = Instance.new("Frame")
infoPanelTitle.Size             = UDim2.new(1, 0, 0, 36)
infoPanelTitle.BackgroundColor3 = currentTheme.accent
infoPanelTitle.BackgroundTransparency = 0.55
infoPanelTitle.ZIndex           = 701
infoPanelTitle.Active           = true   -- input alabilsin
infoPanelTitle.Parent           = infoPanel
Instance.new("UICorner", infoPanelTitle).CornerRadius = UDim.new(0, 14)
-- Alt köşeleri düzeltmek için overlay
local infoPanelTitleOverlay = Instance.new("Frame")
infoPanelTitleOverlay.Size             = UDim2.new(1, 0, 0, 14)
infoPanelTitleOverlay.Position         = UDim2.new(0, 0, 1, -14)
infoPanelTitleOverlay.BackgroundColor3 = currentTheme.accent
infoPanelTitleOverlay.BackgroundTransparency = 0.55
infoPanelTitleOverlay.BorderSizePixel  = 0
infoPanelTitleOverlay.ZIndex           = 701
infoPanelTitleOverlay.Parent           = infoPanelTitle

-- Başlık ikonu (Icons.Info)
local infoPanelTitleIcon = Instance.new("ImageLabel")
infoPanelTitleIcon.Size             = UDim2.new(0, 20, 0, 20)
infoPanelTitleIcon.Position         = UDim2.new(0, 10, 0.5, -10)
infoPanelTitleIcon.BackgroundTransparency = 1
infoPanelTitleIcon.Image            = ResolveAssetImage(Icons.Info)
infoPanelTitleIcon.ImageColor3      = Color3.new(1, 1, 1)
infoPanelTitleIcon.ZIndex           = 702
infoPanelTitleIcon.Parent           = infoPanelTitle

local infoPanelTitleLbl = Instance.new("TextLabel")
infoPanelTitleLbl.Size                   = UDim2.new(1, -62, 1, 0)
infoPanelTitleLbl.Position               = UDim2.new(0, 36, 0, 0)
infoPanelTitleLbl.BackgroundTransparency = 1
infoPanelTitleLbl.Text                   = L.infoTitle
infoPanelTitleLbl.TextColor3             = Color3.new(1, 1, 1)
infoPanelTitleLbl.Font                   = Enum.Font.GothamBold
infoPanelTitleLbl.TextSize               = 14
infoPanelTitleLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoPanelTitleLbl.ZIndex                 = 702
infoPanelTitleLbl.Parent                 = infoPanelTitle

-- Kapat butonu — orijinal CLOSE_SHAPE (iki çapraz çizgi, emoji yok)
local infoPanelClose = Instance.new("TextButton")
infoPanelClose.Size             = UDim2.new(0, 24, 0, 24)
infoPanelClose.Position         = UDim2.new(1, -30, 0.5, -12)
infoPanelClose.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
infoPanelClose.BackgroundTransparency = 0.30
infoPanelClose.Text             = ""
infoPanelClose.ZIndex           = 703
infoPanelClose.Parent           = infoPanelTitle
Instance.new("UICorner", infoPanelClose).CornerRadius = UDim.new(1, 0)

-- Çarpı çizgileri (MakeBtn'deki CLOSE_SHAPE ile aynı mantık)
do
	local thick = 2
	local lineLen = 10
	local cl1 = Instance.new("Frame")
	cl1.BorderSizePixel = 0
	cl1.Size       = UDim2.new(0, lineLen, 0, thick)
	cl1.AnchorPoint = Vector2.new(0.5, 0.5)
	cl1.Position   = UDim2.fromScale(0.5, 0.5)
	cl1.Rotation   = 45
	cl1.BackgroundColor3 = Color3.new(1, 1, 1)
	cl1.ZIndex     = 704
	cl1.Parent     = infoPanelClose
	Instance.new("UICorner", cl1).CornerRadius = UDim.new(0, 2)
	local cl2 = cl1:Clone()
	cl2.Rotation  = -45
	cl2.Parent    = infoPanelClose
end

-- İçerik alanı
local infoPanelBody = Instance.new("Frame")
infoPanelBody.Size                   = UDim2.new(1, -24, 1, -46)
infoPanelBody.Position               = UDim2.new(0, 12, 0, 42)
infoPanelBody.BackgroundTransparency = 1
infoPanelBody.ZIndex                 = 701
infoPanelBody.Parent                 = infoPanel

-- 1) Emote adı
local infoEmoteName = Instance.new("TextLabel")
infoEmoteName.Size                   = UDim2.new(1, 0, 0, 22)
infoEmoteName.Position               = UDim2.new(0, 0, 0, 0)
infoEmoteName.BackgroundTransparency = 1
infoEmoteName.Text                   = "—"
infoEmoteName.TextColor3             = Color3.new(1, 1, 1)
infoEmoteName.Font                   = Enum.Font.GothamBold
infoEmoteName.TextSize               = 16
infoEmoteName.TextXAlignment         = Enum.TextXAlignment.Left
infoEmoteName.TextTruncate           = Enum.TextTruncate.AtEnd
infoEmoteName.ZIndex                 = 702
infoEmoteName.Parent                 = infoPanelBody

-- 2) Açıklama (ismin hemen altı)
local infoDescLbl = Instance.new("TextLabel")
infoDescLbl.Size                   = UDim2.new(1, 0, 0, 28)
infoDescLbl.Position               = UDim2.new(0, 0, 0, 24)
infoDescLbl.BackgroundTransparency = 1
infoDescLbl.Text                   = "—"
infoDescLbl.TextColor3             = Color3.fromRGB(140, 140, 165)
infoDescLbl.Font                   = Enum.Font.Gotham
infoDescLbl.TextSize               = 11
infoDescLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoDescLbl.TextYAlignment         = Enum.TextYAlignment.Top
infoDescLbl.TextWrapped            = true
infoDescLbl.ZIndex                 = 702
infoDescLbl.Parent                 = infoPanelBody

-- Ayırıcı çizgi
local infoDivider = Instance.new("Frame")
infoDivider.Size             = UDim2.new(1, 0, 0, 1)
infoDivider.Position         = UDim2.new(0, 0, 0, 56)
infoDivider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
infoDivider.BorderSizePixel  = 0
infoDivider.ZIndex           = 702
infoDivider.Parent           = infoPanelBody

-- 3) Creator
do
	local ic = Instance.new("ImageLabel")
	ic.Size = UDim2.new(0, 13, 0, 13); ic.Position = UDim2.new(0, 0, 0, 63)
	ic.BackgroundTransparency = 1; ic.Image = Icons.Crown; ic.ZIndex = 702
	ic.Parent = infoPanelBody
end
local infoCreatorLbl = Instance.new("TextLabel")
infoCreatorLbl.Size                   = UDim2.new(1, -18, 0, 16)
infoCreatorLbl.Position               = UDim2.new(0, 18, 0, 61)
infoCreatorLbl.BackgroundTransparency = 1
infoCreatorLbl.Text                   = "—"
infoCreatorLbl.TextColor3             = Color3.fromRGB(140, 200, 255)
infoCreatorLbl.Font                   = Enum.Font.Gotham
infoCreatorLbl.TextSize               = 12
infoCreatorLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoCreatorLbl.ZIndex                 = 702
infoCreatorLbl.Parent                 = infoPanelBody

-- 4) Hız
do
	local ic = Instance.new("ImageLabel")
	ic.Size = UDim2.new(0, 13, 0, 13); ic.Position = UDim2.new(0, 0, 0, 83)
	ic.BackgroundTransparency = 1; ic.Image = Icons.Emote; ic.ZIndex = 702
	ic.Parent = infoPanelBody
end
-- infoSpeedLbl: forward declared above
infoSpeedLbl = Instance.new("TextLabel")
infoSpeedLbl.Size                   = UDim2.new(1, -18, 0, 16)
infoSpeedLbl.Position               = UDim2.new(0, 18, 0, 81)
infoSpeedLbl.BackgroundTransparency = 1
infoSpeedLbl.Text                   = L.speed .. ": 1x"
infoSpeedLbl.TextColor3             = Color3.fromRGB(160, 160, 185)
infoSpeedLbl.Font                   = Enum.Font.Gotham
infoSpeedLbl.TextSize               = 12
infoSpeedLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoSpeedLbl.ZIndex                 = 702
infoSpeedLbl.Parent                 = infoPanelBody

-- RefreshHUDSpeedBtns ve infoSpeedLbl artık tanımlı — bridge'i bağla
_onSpeedChanged = function()
	RefreshHUDSpeedBtns()
	if infoSpeedLbl then
		infoSpeedLbl.Text = L.speed .. ": " .. tostring(Settings.speed) .. "x"
	end
end

-- 5) Fiyat (tam genişlik)
local infoPriceLbl = Instance.new("TextLabel")
infoPriceLbl.Size                   = UDim2.new(1, 0, 0, 16)
infoPriceLbl.Position               = UDim2.new(0, 0, 0, 101)
infoPriceLbl.BackgroundTransparency = 1
infoPriceLbl.Text                   = "—"
infoPriceLbl.TextColor3             = Color3.fromRGB(160, 160, 185)
infoPriceLbl.Font                   = Enum.Font.GothamBold
infoPriceLbl.TextSize               = 12
infoPriceLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoPriceLbl.ZIndex                 = 702
infoPriceLbl.Parent                 = infoPanelBody

-- 6) Favori sayısı (tam genişlik)
local infoFavLbl = Instance.new("TextLabel")
infoFavLbl.Size                   = UDim2.new(1, 0, 0, 16)
infoFavLbl.Position               = UDim2.new(0, 0, 0, 120)
infoFavLbl.BackgroundTransparency = 1
infoFavLbl.Text                   = "—"
infoFavLbl.TextColor3             = Color3.fromRGB(160, 160, 185)
infoFavLbl.Font                   = Enum.Font.Gotham
infoFavLbl.TextSize               = 12
infoFavLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoFavLbl.ZIndex                 = 702
infoFavLbl.Parent                 = infoPanelBody

-- 7) Yaratılma tarihi
do
	local ic = Instance.new("ImageLabel")
	ic.Size = UDim2.new(0, 13, 0, 13); ic.Position = UDim2.new(0, 0, 0, 141)
	ic.BackgroundTransparency = 1; ic.Image = Icons.Recent; ic.ZIndex = 702
	ic.Parent = infoPanelBody
end
local infoDateLbl = Instance.new("TextLabel")
infoDateLbl.Size                   = UDim2.new(1, -18, 0, 16)
infoDateLbl.Position               = UDim2.new(0, 18, 0, 139)
infoDateLbl.BackgroundTransparency = 1
infoDateLbl.Text                   = "—"
infoDateLbl.TextColor3             = Color3.fromRGB(130, 130, 155)
infoDateLbl.Font                   = Enum.Font.Gotham
infoDateLbl.TextSize               = 11
infoDateLbl.TextXAlignment         = Enum.TextXAlignment.Left
infoDateLbl.ZIndex                 = 702
infoDateLbl.Parent                 = infoPanelBody

-- 8) Copy ID butonu
local copyIdBtn = Instance.new("TextButton")
copyIdBtn.Size             = UDim2.new(1, 0, 0, 26)
copyIdBtn.Position         = UDim2.new(0, 0, 0, 161)
copyIdBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
copyIdBtn.Text             = L.copyId
copyIdBtn.TextColor3       = Color3.fromRGB(180, 180, 210)
copyIdBtn.Font             = Enum.Font.GothamBold
copyIdBtn.TextSize         = 12
copyIdBtn.ZIndex           = 703
copyIdBtn.Parent           = infoPanelBody
Instance.new("UICorner", copyIdBtn).CornerRadius = UDim.new(0, 8)
local copyIdStroke = Instance.new("UIStroke")
copyIdStroke.Color       = Color3.fromRGB(70, 70, 100)
copyIdStroke.Thickness   = 1
copyIdStroke.Parent      = copyIdBtn

local infoIdLbl = nil -- eski referans (kaldırıldı)

-- Panel aç/kapa fonksiyonu
local infoPanelOpen = false
local INFO_OPEN_POS  = UDim2.new(0, 10, 1, -270)
local INFO_CLOSE_POS = UDim2.new(0, -290, 1, -270)

local _copyIdTarget = 0  -- Copy ID için mevcut emote id'si

local function _applyMetaToInfoPanel(meta)
	-- Yaratıcı
	infoCreatorLbl.Text = (meta.creatorName and meta.creatorName ~= "") and meta.creatorName or "—"
	-- Açıklama
	infoDescLbl.Text    = (meta.description and meta.description ~= "") and meta.description or L.noDesc
	-- Fiyat
	if meta.priceStatus == "Free" or meta.price == 0 then
		infoPriceLbl.Text       = L.freePrice
		infoPriceLbl.TextColor3 = Color3.fromRGB(100, 220, 130)
	elseif meta.price and meta.price > 0 then
		infoPriceLbl.Text       = tostring(meta.price) .. " R$"
		infoPriceLbl.TextColor3 = Color3.fromRGB(255, 200, 80)
	else
		infoPriceLbl.Text       = (meta.priceStatus and meta.priceStatus ~= "") and meta.priceStatus or "—"
		infoPriceLbl.TextColor3 = Color3.fromRGB(160, 160, 185)
	end
	-- Favori sayısı
	infoFavLbl.Text = meta.favoriteCount
		and ("♥ " .. tostring(meta.favoriteCount))
		or "—"
	-- Tarih
	if meta.createdUtc and meta.createdUtc ~= "" then
		infoDateLbl.Text = meta.createdUtc:sub(1, 10)
	else
		infoDateLbl.Text = "—"
	end
	-- HUD creator
	hudCreator.Text = (meta.creatorName and meta.creatorName ~= "") and meta.creatorName or "Vexro Emotes"
end

local function _fetchAndCacheMeta(numId, targetId)
	-- MarketplaceService ile metadata çek (native Roblox, HTTP'ye gerek yok)
	local ok, info = pcall(function()
		return game:GetService("MarketplaceService"):GetProductInfo(numId)
	end)
	if not ok or not info then return end

	local price      = info.PriceInRobux
	local isFree     = info.IsPublicDomain or (price and price == 0)
	local isNotSale  = info.IsForSale == false and not isFree

	local meta = {
		creatorName   = tostring((info.Creator and info.Creator.Name) or ""),
		description   = tostring(info.Description or ""),
		price         = isFree and 0 or price,
		priceStatus   = isFree and "Free" or (isNotSale and "Not for sale" or ""),
		favoriteCount = nil,
		createdUtc    = "",
	}

	_emoteMetaCache[numId] = meta

	-- emotes tablosunu da güncelle (gelecekteki arama için)
	local eData = EmotesById[numId]
	if eData then
		eData.creatorName   = meta.creatorName
		eData.description   = meta.description
		eData.price         = meta.price
		eData.priceStatus   = meta.priceStatus
		eData.favoriteCount = meta.favoriteCount
		eData.createdUtc    = meta.createdUtc
	end

	-- Panel hâlâ aynı emote için açıksa UI'yi güncelle
	if infoPanelOpen and _copyIdTarget == numId then
		_applyMetaToInfoPanel(meta)
	end
end

local function OpenInfoPanel(emoteId, emoteName)
	infoEmoteName.Text  = emoteName or "—"
	infoSpeedLbl.Text   = L.speed .. ": " .. tostring(Settings.speed) .. "x"
	infoPanelStroke.Color           = currentTheme.accent
	infoPanelTitle.BackgroundColor3 = currentTheme.accent
	_copyIdTarget = tonumber(emoteId) or 0

	local numId = tonumber(emoteId)

	-- Önce önbellekten veya Emotes tablosundan bak
	local meta = _emoteMetaCache[numId]
	if not meta then
		local eData = EmotesById[numId]
		if eData and eData.creatorName ~= "" then
			-- Emotes tablosunda zaten tam veri var
			meta = eData
		end
	end

	if meta then
		_applyMetaToInfoPanel(meta)
	else
		-- Placeholder göster, arka planda çek
		infoCreatorLbl.Text = "…"
		infoDescLbl.Text    = "…"
		infoPriceLbl.Text   = "…"
		infoPriceLbl.TextColor3 = Color3.fromRGB(160, 160, 185)
		infoFavLbl.Text     = "…"
		infoDateLbl.Text    = "…"
		hudCreator.Text     = "Vexro Emotes"
		if numId and numId > 0 then
			task.spawn(_fetchAndCacheMeta, numId, numId)
		end
	end

	-- Copy ID buton tıklama
	copyIdBtn.Text = L.copyId .. ": " .. tostring(numId)

	infoPanel.Position = INFO_CLOSE_POS
	infoPanel.Visible  = true
	infoPanelOpen      = true
	TweenService:Create(infoPanel,
		TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{Position = INFO_OPEN_POS}
	):Play()
	TweenService:Create(hudInfoBtn, TweenInfo.new(0.15),
		{BackgroundTransparency = 0.05}):Play()
end

copyIdBtn.MouseButton1Click:Connect(function()
	pcall(function()
		if setclipboard then
			setclipboard(tostring(_copyIdTarget))
		end
	end)
	local orig = copyIdBtn.Text
	copyIdBtn.Text            = L.copied
	copyIdBtn.TextColor3      = Color3.fromRGB(100, 220, 130)
	task.delay(1.5, function()
		copyIdBtn.Text       = orig
		copyIdBtn.TextColor3 = Color3.fromRGB(180, 180, 210)
	end)
end)

local function CloseInfoPanel()
	infoPanelOpen = false
	-- Panelin şu anki konumundan sola kayarak kapan (sürüklendiyse oradan çıkar)
	local curX = infoPanel.AbsolutePosition.X
	local curY = infoPanel.AbsolutePosition.Y
	local exitPos = UDim2.new(0, curX - 300, 0, curY)
	TweenService:Create(infoPanel,
		TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{Position = exitPos}
	):Play()
	TweenService:Create(hudInfoBtn, TweenInfo.new(0.15),
		{BackgroundTransparency = 0.40}):Play()
	task.delay(0.22, function()
		if not infoPanelOpen then infoPanel.Visible = false end
	end)
end

-- "i" butonuna tıklayınca panel aç/kapat
hudInfoBtn.MouseButton1Click:Connect(function()
	if infoPanelOpen then
		CloseInfoPanel()
	else
		OpenInfoPanel(_currentInfoId or 0, _currentInfoName or "Emote")
	end
end)
infoPanelClose.MouseButton1Click:Connect(CloseInfoPanel)

-- ▸ InfoPanel sürükle-bırak — başlık çubuğundan tutarak taşı
local _ipDragActive     = false
local _ipDragMouseStart = Vector2.zero
local _ipDragPanelStart = Vector2.zero

infoPanelTitle.InputBegan:Connect(function(inp)
	if inp.UserInputType ~= Enum.UserInputType.MouseButton1
	and inp.UserInputType ~= Enum.UserInputType.Touch then return end
	_ipDragActive     = true
	_ipDragMouseStart = Vector2.new(inp.Position.X, inp.Position.Y)
	_ipDragPanelStart = Vector2.new(
		infoPanel.AbsolutePosition.X,
		infoPanel.AbsolutePosition.Y
	)
end)

UserInputService.InputChanged:Connect(function(inp)
	if not _ipDragActive then return end
	if inp.UserInputType ~= Enum.UserInputType.MouseMovement
	and inp.UserInputType ~= Enum.UserInputType.Touch then return end
	local delta = Vector2.new(inp.Position.X, inp.Position.Y) - _ipDragMouseStart
	infoPanel.Position = UDim2.new(0, _ipDragPanelStart.X + delta.X,
	                               0, _ipDragPanelStart.Y + delta.Y)
end)

UserInputService.InputEnded:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1
	or inp.UserInputType == Enum.UserInputType.Touch then
		_ipDragActive = false
	end
end)

-- ▸ Slider knob sürükleme
local hudKnobDragging = false

hudKnob.InputBegan:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1
	or inp.UserInputType == Enum.UserInputType.Touch then
		hudKnobDragging = true
	end
end)

-- Slider arka planına tıkla → o noktaya atla
hudSliderBg.InputBegan:Connect(function(inp)
	if inp.UserInputType ~= Enum.UserInputType.MouseButton1
	and inp.UserInputType ~= Enum.UserInputType.Touch then return end
	if currentAnimTrack and currentAnimTrack.Length and currentAnimTrack.Length > 0 then
		local alpha = math.clamp(
			(inp.Position.X - hudSliderBg.AbsolutePosition.X) / hudSliderBg.AbsoluteSize.X,
			0, 1)
		pcall(function() currentAnimTrack.TimePosition = alpha * currentAnimTrack.Length end)
	end
end)

UserInputService.InputEnded:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1
	or inp.UserInputType == Enum.UserInputType.Touch then
		hudKnobDragging = false
	end
end)

-- Sürükleme → TimePosition güncelle
UserInputService.InputChanged:Connect(function(inp)
	if not hudKnobDragging then return end
	if inp.UserInputType ~= Enum.UserInputType.MouseMovement
	and inp.UserInputType ~= Enum.UserInputType.Touch then return end
	if currentAnimTrack and currentAnimTrack.Length and currentAnimTrack.Length > 0 then
		local alpha = math.clamp(
			(inp.Position.X - hudSliderBg.AbsolutePosition.X) / hudSliderBg.AbsoluteSize.X,
			0, 1)
		pcall(function() currentAnimTrack.TimePosition = alpha * currentAnimTrack.Length end)
	end
end)

-- ▸ RenderStepped: slider'ı her kare canlı güncelle
local function StartHUDTracking()
	-- Önceki bağlantıyı kes → FPS kaybını önle
	if hudTrackerConn then
		hudTrackerConn:Disconnect()
		hudTrackerConn = nil
	end

	hudTrackerConn = RunService.RenderStepped:Connect(function()
		if not currentAnimTrack or not currentAnimTrack.IsPlaying then return end
		local len = currentAnimTrack.Length
		if not len or len <= 0 then return end

		-- TimePosition / Length = ilerleme oranı (0..1)
		local alpha = math.clamp(currentAnimTrack.TimePosition / len, 0, 1)

		-- Slider fill ve knob'u güncelle (tween gerekmez, her frame smooth)
		hudFill.Size     = UDim2.new(alpha, 0, 1, 0)
		hudKnob.Position = UDim2.new(alpha, 0, 0.5, 0)

		-- Tema renkleriyle senkron tut
		hudFill.BackgroundColor3    = currentTheme.accent
		hudStroke.Color             = currentTheme.stroke
		hudInfoBtn.BackgroundColor3 = currentTheme.accent
		infoPanelStroke.Color       = currentTheme.accent
	end)
end

local function StopHUDTracking()
	-- Disconnect -> RenderStepped baglantisini kes (FPS korunur)
	if hudTrackerConn then
		hudTrackerConn:Disconnect()
		hudTrackerConn = nil
	end
end

-- ShowEmoteHUD: HUD'u asagidan kaydirarak goster
ShowEmoteHUD = function(emoteId, emoteName)
	_currentInfoId   = emoteId
	_currentInfoName = emoteName

	RefreshHUDFavBtn()
	hudName.Text    = emoteName or "Emote"
	hudCreator.Text = "Vexro Emotes"

	if infoPanelOpen then
		OpenInfoPanel(emoteId, emoteName)
	end

	HUD.Position               = UDim2.new(0.5, 0, 1, -72)
	HUD.BackgroundTransparency = 1
	HUD.Visible                = true

	TweenService:Create(HUD,
		TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{Position = UDim2.new(0.5, 0, 1, -105), BackgroundTransparency = 0.30}
	):Play()

	RefreshHUDSpeedBtns()
	StartHUDTracking()
end

-- HideEmoteHUD: HUD'u asagiya kaydirarak gizle
HideEmoteHUD = function()
	_isPaused = false
	StopHUDTracking()
	TweenService:Create(HUD,
		TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{Position = UDim2.new(0.5, 0, 1, -72), BackgroundTransparency = 1}
	):Play()
	task.delay(0.22, function()
		if HUD then HUD.Visible = false end
	end)
	if infoPanelOpen then CloseInfoPanel() end
end

-- ----------------------------------------------------------------
-- BOLUM 4 - HUD & BLENDING ENTEGRASYONU
-- ----------------------------------------------------------------

local _origPlayEmote = PlayEmote
PlayEmote = function(id, name, silent)
	_origPlayEmote(id, name, silent)
	task.defer(function()
		if currentAnimTrack then
			ShowEmoteHUD(id, name)
			local tracked = currentAnimTrack
			tracked.Stopped:Connect(function()
				if (currentAnimTrack == tracked or not currentAnimTrack)
				and not isComboActive then
					HideEmoteHUD()
				end
			end)
		end
	end)
end

local _origStopEmote = StopEmote
StopEmote = function(showNotif)
	_origStopEmote(showNotif)
	isComboActive = false
	ComboQueue    = {}
	HideEmoteHUD()
end

-- ----------------------------------------------------------------
-- BOLUM 5 - COMBO SIRASI
-- ----------------------------------------------------------------

-- comboQueue_UI forward declared above; reset here
comboQueue_UI = {}

local comboRow = MakeSettingRow("", L.comboTitle, 7, 196)
comboRow.Size             = UDim2.new(1, 0, 0, 196)
comboRow.ClipsDescendants = true

local comboTitleLbl = comboRow:FindFirstChildWhichIsA("TextLabel")
if comboTitleLbl then
	comboTitleLbl.Size     = UDim2.new(1, -12, 0, 20)
	comboTitleLbl.Position = UDim2.new(0, 10, 0, 5)
	comboTitleLbl.TextSize = 13
end

local slotHolder = Instance.new("Frame")
slotHolder.Size             = UDim2.new(1, -12, 0, 36)
slotHolder.Position         = UDim2.new(0, 6, 0, 28)
slotHolder.BackgroundTransparency = 1
slotHolder.ZIndex           = 9
slotHolder.Parent           = comboRow
local slotLayout = Instance.new("UIListLayout")
slotLayout.FillDirection    = Enum.FillDirection.Horizontal
slotLayout.Padding          = UDim.new(0, 5)
slotLayout.Parent           = slotHolder

-- comboSlots forward declared above; populate here
comboSlots = {}
for si = 1, 3 do
	local s = Instance.new("TextButton")
	s.Size             = UDim2.new(0.316, 0, 1, 0)
	s.BackgroundColor3 = Color3.fromRGB(30, 30, 46)
	s.Text             = L.slotLabel .. " " .. si
	s.TextColor3       = Color3.fromRGB(120, 120, 148)
	s.Font             = Enum.Font.Gotham
	s.TextSize         = 11
	s.ZIndex           = 9
	s.Parent           = slotHolder
	Instance.new("UICorner", s).CornerRadius = UDim.new(0, 8)
	comboSlots[si] = s
	s.MouseButton1Click:Connect(function()
		if comboQueue_UI[si] then
			table.remove(comboQueue_UI, si)
			for j = 1, 3 do
				local e = comboQueue_UI[j]
				comboSlots[j].Text = e and e.name:sub(1,9) or ("Slot " .. j)
				TweenService:Create(comboSlots[j], TweenInfo.new(0.15), {
					BackgroundColor3 = e and currentTheme.accent or Color3.fromRGB(30,30,46)
				}):Play()
			end
		end
	end)
end

local comboBtnHolder = Instance.new("Frame")
comboBtnHolder.Size             = UDim2.new(1, -12, 0, 30)
comboBtnHolder.Position         = UDim2.new(0, 6, 0, 70)
comboBtnHolder.BackgroundTransparency = 1
comboBtnHolder.ZIndex           = 9
comboBtnHolder.Parent           = comboRow
local comboBtnLayout = Instance.new("UIListLayout")
comboBtnLayout.FillDirection    = Enum.FillDirection.Horizontal
comboBtnLayout.Padding          = UDim.new(0, 5)
comboBtnLayout.Parent           = comboBtnHolder

local addComboBtn = Instance.new("TextButton")
addComboBtn.Size             = UDim2.new(0.5, -2, 1, 0)
addComboBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 170)
addComboBtn.Text             = L.addEmote
addComboBtn.TextColor3       = Color3.new(1, 1, 1)
addComboBtn.Font             = Enum.Font.GothamBold
addComboBtn.TextSize         = 12
addComboBtn.ZIndex           = 9
addComboBtn.Parent           = comboBtnHolder
Instance.new("UICorner", addComboBtn).CornerRadius = UDim.new(0, 8)

local playComboBtn = Instance.new("TextButton")
playComboBtn.Size             = UDim2.new(0.5, -2, 1, 0)
playComboBtn.BackgroundColor3 = Color3.fromRGB(60, 140, 80)
playComboBtn.Text             = L.playCombo
playComboBtn.TextColor3       = Color3.new(1, 1, 1)
playComboBtn.Font             = Enum.Font.GothamBold
playComboBtn.TextSize         = 12
playComboBtn.ZIndex           = 9
playComboBtn.Parent           = comboBtnHolder
Instance.new("UICorner", playComboBtn).CornerRadius = UDim.new(0, 8)

-- ▸ Loop toggle butonu
local loopComboBtn = Instance.new("TextButton")
loopComboBtn.Size             = UDim2.new(1, -12, 0, 26)
loopComboBtn.Position         = UDim2.new(0, 6, 0, 106)
loopComboBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 46)
loopComboBtn.Text             = L.loopText .. ": " .. L.off
loopComboBtn.TextColor3       = Color3.fromRGB(120, 120, 148)
loopComboBtn.Font             = Enum.Font.GothamBold
loopComboBtn.TextSize         = 12
loopComboBtn.ZIndex           = 9
loopComboBtn.Parent           = comboRow
Instance.new("UICorner", loopComboBtn).CornerRadius = UDim.new(0, 8)
local loopStroke = Instance.new("UIStroke")
loopStroke.Color        = Color3.fromRGB(60, 60, 90)
loopStroke.Thickness    = 1
loopStroke.Transparency = 0.5
loopStroke.Parent       = loopComboBtn
-- Sol taraftaki loop ikonu (Icons.Refresh asset'i)
local loopIcon = Instance.new("ImageLabel")
loopIcon.Size                   = UDim2.new(0, 14, 0, 14)
loopIcon.Position               = UDim2.new(0, 8, 0.5, -7)
loopIcon.BackgroundTransparency = 1
loopIcon.Image                  = ResolveAssetImage(Icons.Refresh)
loopIcon.ImageColor3            = Color3.fromRGB(120, 120, 148)
loopIcon.ZIndex                 = 10
loopIcon.Parent                 = loopComboBtn
-- İkona yer açmak için text'i sağa kaydır
loopComboBtn.TextXAlignment = Enum.TextXAlignment.Center

loopComboBtn.MouseButton1Click:Connect(function()
	_comboLoopEnabled = not _comboLoopEnabled
	if _comboLoopEnabled then
		loopComboBtn.Text             = L.loopText .. ": " .. L.on
		loopComboBtn.TextColor3       = Color3.new(1, 1, 1)
		loopIcon.ImageColor3          = Color3.new(1, 1, 1)
		TweenService:Create(loopComboBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = currentTheme.accent
		}):Play()
		loopStroke.Color = currentTheme.accent
	else
		loopComboBtn.Text             = L.loopText .. ": " .. L.off
		loopComboBtn.TextColor3       = Color3.fromRGB(120, 120, 148)
		loopIcon.ImageColor3          = Color3.fromRGB(120, 120, 148)
		TweenService:Create(loopComboBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(30, 30, 46)
		}):Play()
		loopStroke.Color = Color3.fromRGB(60, 60, 90)
	end
end)

local clearComboBtn = Instance.new("TextButton")
clearComboBtn.Size             = UDim2.new(1, -12, 0, 26)
clearComboBtn.Position         = UDim2.new(0, 6, 0, 138)
clearComboBtn.BackgroundColor3 = Color3.fromRGB(140, 40, 40)
clearComboBtn.Text             = L.clearCombo
clearComboBtn.TextColor3       = Color3.new(1, 1, 1)
clearComboBtn.Font             = Enum.Font.GothamBold
clearComboBtn.TextSize         = 12
clearComboBtn.ZIndex           = 9
clearComboBtn.Parent           = comboRow
Instance.new("UICorner", clearComboBtn).CornerRadius = UDim.new(0, 8)

addComboBtn.MouseButton1Click:Connect(function()
	if #comboQueue_UI >= 3 then return end
	if not _currentInfoId then
		-- Emote seçilmedi — butonu kısa süre kırmızı yak
		local origCol = addComboBtn.BackgroundColor3
		addComboBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
		addComboBtn.Text = L.selectFirst
		task.delay(0.7, function()
			addComboBtn.BackgroundColor3 = origCol
			addComboBtn.Text = L.addEmote
		end)
		return
	end
	table.insert(comboQueue_UI, {id = _currentInfoId, name = _currentInfoName or "Emote"})
	local idx = #comboQueue_UI
	comboSlots[idx].Text = (comboQueue_UI[idx].name):sub(1, 9)
	TweenService:Create(comboSlots[idx], TweenInfo.new(0.15), {
		BackgroundColor3 = currentTheme.accent
	}):Play()
end)

playComboBtn.MouseButton1Click:Connect(function()
	if #comboQueue_UI == 0 then return end
	local list = {}
	for _, e in ipairs(comboQueue_UI) do
		table.insert(list, {id = e.id, name = e.name})
	end
	StartCombo(list)
end)

clearComboBtn.MouseButton1Click:Connect(function()
	comboQueue_UI    = {}
	isComboActive    = false
	ComboQueue       = {}
	_comboLoopList   = {}
	-- Loop kapatılsın
	if _comboLoopEnabled then
		_comboLoopEnabled             = false
		loopComboBtn.Text             = L.loopText .. ": " .. L.off
		loopComboBtn.TextColor3       = Color3.fromRGB(120, 120, 148)
		loopComboBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 46)
		loopStroke.Color              = Color3.fromRGB(60, 60, 90)
		loopIcon.ImageColor3          = Color3.fromRGB(120, 120, 148)
	end
	for j = 1, 3 do
		comboSlots[j].Text = L.slotLabel .. " " .. j
		TweenService:Create(comboSlots[j], TweenInfo.new(0.15), {
			BackgroundColor3 = Color3.fromRGB(30, 30, 46)
		}):Play()
	end
end)

-- Tema değişince loop butonu aktifse yeni accent rengine güncelle
do
	local _prevApply = ApplyTheme
	ApplyTheme = function(name)
		_prevApply(name)
		if _comboLoopEnabled and loopComboBtn and loopComboBtn.Parent then
			pcall(function()
				loopComboBtn.BackgroundColor3 = currentTheme.accent
				loopStroke.Color             = currentTheme.accent
				loopIcon.ImageColor3         = Color3.new(1, 1, 1)
			end)
		end
	end
end

end -- _VexroExtend kapatiliyor
_VexroExtend()
