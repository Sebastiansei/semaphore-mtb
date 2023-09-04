import ProvenZk.Gates
import ProvenZk.Ext.Vector

namespace InsertionProof

def Order : ℕ := 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001
variable [Fact (Nat.Prime Order)]
abbrev F := ZMod Order

def sbox (Inp: F) (k: F -> Prop): Prop :=
    ∃gate_0, gate_0 = Gates.mul Inp Inp ∧
    ∃gate_1, gate_1 = Gates.mul gate_0 gate_0 ∧
    ∃gate_2, gate_2 = Gates.mul Inp gate_1 ∧
    k gate_2

def mds_3 (Inp: Vector F 3) (k: Vector F 3 -> Prop): Prop :=
    ∃gate_0, gate_0 = Gates.mul Inp[0] 7511745149465107256748700652201246547602992235352608707588321460060273774987 ∧
    ∃gate_1, gate_1 = Gates.add 0 gate_0 ∧
    ∃gate_2, gate_2 = Gates.mul Inp[1] 10370080108974718697676803824769673834027675643658433702224577712625900127200 ∧
    ∃gate_3, gate_3 = Gates.add gate_1 gate_2 ∧
    ∃gate_4, gate_4 = Gates.mul Inp[2] 19705173408229649878903981084052839426532978878058043055305024233888854471533 ∧
    ∃gate_5, gate_5 = Gates.add gate_3 gate_4 ∧
    ∃gate_6, gate_6 = Gates.mul Inp[0] 18732019378264290557468133440468564866454307626475683536618613112504878618481 ∧
    ∃gate_7, gate_7 = Gates.add 0 gate_6 ∧
    ∃gate_8, gate_8 = Gates.mul Inp[1] 20870176810702568768751421378473869562658540583882454726129544628203806653987 ∧
    ∃gate_9, gate_9 = Gates.add gate_7 gate_8 ∧
    ∃gate_10, gate_10 = Gates.mul Inp[2] 7266061498423634438633389053804536045105766754026813321943009179476902321146 ∧
    ∃gate_11, gate_11 = Gates.add gate_9 gate_10 ∧
    ∃gate_12, gate_12 = Gates.mul Inp[0] 9131299761947733513298312097611845208338517739621853568979632113419485819303 ∧
    ∃gate_13, gate_13 = Gates.add 0 gate_12 ∧
    ∃gate_14, gate_14 = Gates.mul Inp[1] 10595341252162738537912664445405114076324478519622938027420701542910180337937 ∧
    ∃gate_15, gate_15 = Gates.add gate_13 gate_14 ∧
    ∃gate_16, gate_16 = Gates.mul Inp[2] 11597556804922396090267472882856054602429588299176362916247939723151043581408 ∧
    ∃gate_17, gate_17 = Gates.add gate_15 gate_16 ∧
    k vec![gate_5, gate_11, gate_17]

def fullRound_3_3 (Inp: Vector F 3) (Consts: Vector F 3) (k: Vector F 3 -> Prop): Prop :=
    ∃gate_0, gate_0 = Gates.add Inp[0] Consts[0] ∧
    ∃gate_1, gate_1 = Gates.add Inp[1] Consts[1] ∧
    ∃gate_2, gate_2 = Gates.add Inp[2] Consts[2] ∧
    sbox gate_0 fun gate_3 =>
    sbox gate_1 fun gate_4 =>
    sbox gate_2 fun gate_5 =>
    mds_3 vec![gate_3, gate_4, gate_5] fun gate_6 =>
    k vec![gate_6[0], gate_6[1], gate_6[2]]

def halfRound_3_3 (Inp: Vector F 3) (Consts: Vector F 3) (k: Vector F 3 -> Prop): Prop :=
    ∃gate_0, gate_0 = Gates.add Inp[0] Consts[0] ∧
    ∃gate_1, gate_1 = Gates.add Inp[1] Consts[1] ∧
    ∃gate_2, gate_2 = Gates.add Inp[2] Consts[2] ∧
    sbox gate_0 fun gate_3 =>
    mds_3 vec![gate_3, gate_1, gate_2] fun gate_4 =>
    k vec![gate_4[0], gate_4[1], gate_4[2]]

def poseidon_3 (Inputs: Vector F 3) (k: Vector F 3 -> Prop): Prop :=
    fullRound_3_3 vec![Inputs[0], Inputs[1], Inputs[2]] vec![6745197990210204598374042828761989596302876299545964402857411729872131034734, 426281677759936592021316809065178817848084678679510574715894138690250139748, 4014188762916583598888942667424965430287497824629657219807941460227372577781] fun gate_0 =>
    fullRound_3_3 vec![gate_0[0], gate_0[1], gate_0[2]] vec![21328925083209914769191926116470334003273872494252651254811226518870906634704, 19525217621804205041825319248827370085205895195618474548469181956339322154226, 1402547928439424661186498190603111095981986484908825517071607587179649375482] fun gate_1 =>
    fullRound_3_3 vec![gate_1[0], gate_1[1], gate_1[2]] vec![18320863691943690091503704046057443633081959680694199244583676572077409194605, 17709820605501892134371743295301255810542620360751268064484461849423726103416, 15970119011175710804034336110979394557344217932580634635707518729185096681010] fun gate_2 =>
    fullRound_3_3 vec![gate_2[0], gate_2[1], gate_2[2]] vec![9818625905832534778628436765635714771300533913823445439412501514317783880744, 6235167673500273618358172865171408902079591030551453531218774338170981503478, 12575685815457815780909564540589853169226710664203625668068862277336357031324] fun gate_3 =>
    halfRound_3_3 vec![gate_3[0], gate_3[1], gate_3[2]] vec![7381963244739421891665696965695211188125933529845348367882277882370864309593, 14214782117460029685087903971105962785460806586237411939435376993762368956406, 13382692957873425730537487257409819532582973556007555550953772737680185788165] fun gate_4 =>
    halfRound_3_3 vec![gate_4[0], gate_4[1], gate_4[2]] vec![2203881792421502412097043743980777162333765109810562102330023625047867378813, 2916799379096386059941979057020673941967403377243798575982519638429287573544, 4341714036313630002881786446132415875360643644216758539961571543427269293497] fun gate_5 =>
    halfRound_3_3 vec![gate_5[0], gate_5[1], gate_5[2]] vec![2340590164268886572738332390117165591168622939528604352383836760095320678310, 5222233506067684445011741833180208249846813936652202885155168684515636170204, 7963328565263035669460582454204125526132426321764384712313576357234706922961] fun gate_6 =>
    halfRound_3_3 vec![gate_6[0], gate_6[1], gate_6[2]] vec![1394121618978136816716817287892553782094854454366447781505650417569234586889, 20251767894547536128245030306810919879363877532719496013176573522769484883301, 141695147295366035069589946372747683366709960920818122842195372849143476473] fun gate_7 =>
    halfRound_3_3 vec![gate_7[0], gate_7[1], gate_7[2]] vec![15919677773886738212551540894030218900525794162097204800782557234189587084981, 2616624285043480955310772600732442182691089413248613225596630696960447611520, 4740655602437503003625476760295930165628853341577914460831224100471301981787] fun gate_8 =>
    halfRound_3_3 vec![gate_8[0], gate_8[1], gate_8[2]] vec![19201590924623513311141753466125212569043677014481753075022686585593991810752, 12116486795864712158501385780203500958268173542001460756053597574143933465696, 8481222075475748672358154589993007112877289817336436741649507712124418867136] fun gate_9 =>
    halfRound_3_3 vec![gate_9[0], gate_9[1], gate_9[2]] vec![5181207870440376967537721398591028675236553829547043817076573656878024336014, 1576305643467537308202593927724028147293702201461402534316403041563704263752, 2555752030748925341265856133642532487884589978209403118872788051695546807407] fun gate_10 =>
    halfRound_3_3 vec![gate_10[0], gate_10[1], gate_10[2]] vec![18840924862590752659304250828416640310422888056457367520753407434927494649454, 14593453114436356872569019099482380600010961031449147888385564231161572479535, 20826991704411880672028799007667199259549645488279985687894219600551387252871] fun gate_11 =>
    halfRound_3_3 vec![gate_11[0], gate_11[1], gate_11[2]] vec![9159011389589751902277217485643457078922343616356921337993871236707687166408, 5605846325255071220412087261490782205304876403716989785167758520729893194481, 1148784255964739709393622058074925404369763692117037208398835319441214134867] fun gate_12 =>
    halfRound_3_3 vec![gate_12[0], gate_12[1], gate_12[2]] vec![20945896491956417459309978192328611958993484165135279604807006821513499894540, 229312996389666104692157009189660162223783309871515463857687414818018508814, 21184391300727296923488439338697060571987191396173649012875080956309403646776] fun gate_13 =>
    halfRound_3_3 vec![gate_13[0], gate_13[1], gate_13[2]] vec![21853424399738097885762888601689700621597911601971608617330124755808946442758, 12776298811140222029408960445729157525018582422120161448937390282915768616621, 7556638921712565671493830639474905252516049452878366640087648712509680826732] fun gate_14 =>
    halfRound_3_3 vec![gate_14[0], gate_14[1], gate_14[2]] vec![19042212131548710076857572964084011858520620377048961573689299061399932349935, 12871359356889933725034558434803294882039795794349132643274844130484166679697, 3313271555224009399457959221795880655466141771467177849716499564904543504032] fun gate_15 =>
    halfRound_3_3 vec![gate_15[0], gate_15[1], gate_15[2]] vec![15080780006046305940429266707255063673138269243146576829483541808378091931472, 21300668809180077730195066774916591829321297484129506780637389508430384679582, 20480395468049323836126447690964858840772494303543046543729776750771407319822] fun gate_16 =>
    halfRound_3_3 vec![gate_16[0], gate_16[1], gate_16[2]] vec![10034492246236387932307199011778078115444704411143703430822959320969550003883, 19584962776865783763416938001503258436032522042569001300175637333222729790225, 20155726818439649091211122042505326538030503429443841583127932647435472711802] fun gate_17 =>
    halfRound_3_3 vec![gate_17[0], gate_17[1], gate_17[2]] vec![13313554736139368941495919643765094930693458639277286513236143495391474916777, 14606609055603079181113315307204024259649959674048912770003912154260692161833, 5563317320536360357019805881367133322562055054443943486481491020841431450882] fun gate_18 =>
    halfRound_3_3 vec![gate_18[0], gate_18[1], gate_18[2]] vec![10535419877021741166931390532371024954143141727751832596925779759801808223060, 12025323200952647772051708095132262602424463606315130667435888188024371598063, 2906495834492762782415522961458044920178260121151056598901462871824771097354] fun gate_19 =>
    halfRound_3_3 vec![gate_19[0], gate_19[1], gate_19[2]] vec![19131970618309428864375891649512521128588657129006772405220584460225143887876, 8896386073442729425831367074375892129571226824899294414632856215758860965449, 7748212315898910829925509969895667732958278025359537472413515465768989125274] fun gate_20 =>
    halfRound_3_3 vec![gate_20[0], gate_20[1], gate_20[2]] vec![422974903473869924285294686399247660575841594104291551918957116218939002865, 6398251826151191010634405259351528880538837895394722626439957170031528482771, 18978082967849498068717608127246258727629855559346799025101476822814831852169] fun gate_21 =>
    halfRound_3_3 vec![gate_21[0], gate_21[1], gate_21[2]] vec![19150742296744826773994641927898928595714611370355487304294875666791554590142, 12896891575271590393203506752066427004153880610948642373943666975402674068209, 9546270356416926575977159110423162512143435321217584886616658624852959369669] fun gate_22 =>
    halfRound_3_3 vec![gate_22[0], gate_22[1], gate_22[2]] vec![2159256158967802519099187112783460402410585039950369442740637803310736339200, 8911064487437952102278704807713767893452045491852457406400757953039127292263, 745203718271072817124702263707270113474103371777640557877379939715613501668] fun gate_23 =>
    halfRound_3_3 vec![gate_23[0], gate_23[1], gate_23[2]] vec![19313999467876585876087962875809436559985619524211587308123441305315685710594, 13254105126478921521101199309550428567648131468564858698707378705299481802310, 1842081783060652110083740461228060164332599013503094142244413855982571335453] fun gate_24 =>
    halfRound_3_3 vec![gate_24[0], gate_24[1], gate_24[2]] vec![9630707582521938235113899367442877106957117302212260601089037887382200262598, 5066637850921463603001689152130702510691309665971848984551789224031532240292, 4222575506342961001052323857466868245596202202118237252286417317084494678062] fun gate_25 =>
    halfRound_3_3 vec![gate_25[0], gate_25[1], gate_25[2]] vec![2919565560395273474653456663643621058897649501626354982855207508310069954086, 6828792324689892364977311977277548750189770865063718432946006481461319858171, 2245543836264212411244499299744964607957732316191654500700776604707526766099] fun gate_26 =>
    halfRound_3_3 vec![gate_26[0], gate_26[1], gate_26[2]] vec![19602444885919216544870739287153239096493385668743835386720501338355679311704, 8239538512351936341605373169291864076963368674911219628966947078336484944367, 15053013456316196458870481299866861595818749671771356646798978105863499965417] fun gate_27 =>
    halfRound_3_3 vec![gate_27[0], gate_27[1], gate_27[2]] vec![7173615418515925804810790963571435428017065786053377450925733428353831789901, 8239211677777829016346247446855147819062679124993100113886842075069166957042, 15330855478780269194281285878526984092296288422420009233557393252489043181621] fun gate_28 =>
    halfRound_3_3 vec![gate_28[0], gate_28[1], gate_28[2]] vec![10014883178425964324400942419088813432808659204697623248101862794157084619079, 14014440630268834826103915635277409547403899966106389064645466381170788813506, 3580284508947993352601712737893796312152276667249521401778537893620670305946] fun gate_29 =>
    halfRound_3_3 vec![gate_29[0], gate_29[1], gate_29[2]] vec![2559754020964039399020874042785294258009596917335212876725104742182177996988, 14898657953331064524657146359621913343900897440154577299309964768812788279359, 2094037260225570753385567402013028115218264157081728958845544426054943497065] fun gate_30 =>
    halfRound_3_3 vec![gate_30[0], gate_30[1], gate_30[2]] vec![18051086536715129874440142649831636862614413764019212222493256578581754875930, 21680659279808524976004872421382255670910633119979692059689680820959727969489, 13950668739013333802529221454188102772764935019081479852094403697438884885176] fun gate_31 =>
    halfRound_3_3 vec![gate_31[0], gate_31[1], gate_31[2]] vec![9703845704528288130475698300068368924202959408694460208903346143576482802458, 12064310080154762977097567536495874701200266107682637369509532768346427148165, 16970760937630487134309762150133050221647250855182482010338640862111040175223] fun gate_32 =>
    halfRound_3_3 vec![gate_32[0], gate_32[1], gate_32[2]] vec![9790997389841527686594908620011261506072956332346095631818178387333642218087, 16314772317774781682315680698375079500119933343877658265473913556101283387175, 82044870826814863425230825851780076663078706675282523830353041968943811739] fun gate_33 =>
    halfRound_3_3 vec![gate_33[0], gate_33[1], gate_33[2]] vec![21696416499108261787701615667919260888528264686979598953977501999747075085778, 327771579314982889069767086599893095509690747425186236545716715062234528958, 4606746338794869835346679399457321301521448510419912225455957310754258695442] fun gate_34 =>
    halfRound_3_3 vec![gate_34[0], gate_34[1], gate_34[2]] vec![64499140292086295251085369317820027058256893294990556166497635237544139149, 10455028514626281809317431738697215395754892241565963900707779591201786416553, 10421411526406559029881814534127830959833724368842872558146891658647152404488] fun gate_35 =>
    halfRound_3_3 vec![gate_35[0], gate_35[1], gate_35[2]] vec![18848084335930758908929996602136129516563864917028006334090900573158639401697, 13844582069112758573505569452838731733665881813247931940917033313637916625267, 13488838454403536473492810836925746129625931018303120152441617863324950564617] fun gate_36 =>
    halfRound_3_3 vec![gate_36[0], gate_36[1], gate_36[2]] vec![15742141787658576773362201234656079648895020623294182888893044264221895077688, 6756884846734501741323584200608866954194124526254904154220230538416015199997, 7860026400080412708388991924996537435137213401947704476935669541906823414404] fun gate_37 =>
    halfRound_3_3 vec![gate_37[0], gate_37[1], gate_37[2]] vec![7871040688194276447149361970364037034145427598711982334898258974993423182255, 20758972836260983284101736686981180669442461217558708348216227791678564394086, 21723241881201839361054939276225528403036494340235482225557493179929400043949] fun gate_38 =>
    halfRound_3_3 vec![gate_38[0], gate_38[1], gate_38[2]] vec![19428469330241922173653014973246050805326196062205770999171646238586440011910, 7969200143746252148180468265998213908636952110398450526104077406933642389443, 10950417916542216146808986264475443189195561844878185034086477052349738113024] fun gate_39 =>
    halfRound_3_3 vec![gate_39[0], gate_39[1], gate_39[2]] vec![18149233917533571579549129116652755182249709970669448788972210488823719849654, 3729796741814967444466779622727009306670204996071028061336690366291718751463, 5172504399789702452458550583224415301790558941194337190035441508103183388987] fun gate_40 =>
    halfRound_3_3 vec![gate_40[0], gate_40[1], gate_40[2]] vec![6686473297578275808822003704722284278892335730899287687997898239052863590235, 19426913098142877404613120616123695099909113097119499573837343516470853338513, 5120337081764243150760446206763109494847464512045895114970710519826059751800] fun gate_41 =>
    halfRound_3_3 vec![gate_41[0], gate_41[1], gate_41[2]] vec![5055737465570446530938379301905385631528718027725177854815404507095601126720, 14235578612970484492268974539959119923625505766550088220840324058885914976980, 653592517890187950103239281291172267359747551606210609563961204572842639923] fun gate_42 =>
    halfRound_3_3 vec![gate_42[0], gate_42[1], gate_42[2]] vec![5507360526092411682502736946959369987101940689834541471605074817375175870579, 7864202866011437199771472205361912625244234597659755013419363091895334445453, 21294659996736305811805196472076519801392453844037698272479731199885739891648] fun gate_43 =>
    halfRound_3_3 vec![gate_43[0], gate_43[1], gate_43[2]] vec![13767183507040326119772335839274719411331242166231012705169069242737428254651, 810181532076738148308457416289197585577119693706380535394811298325092337781, 14232321930654703053193240133923161848171310212544136614525040874814292190478] fun gate_44 =>
    halfRound_3_3 vec![gate_44[0], gate_44[1], gate_44[2]] vec![16796904728299128263054838299534612533844352058851230375569421467352578781209, 16256310366973209550759123431979563367001604350120872788217761535379268327259, 19791658638819031543640174069980007021961272701723090073894685478509001321817] fun gate_45 =>
    halfRound_3_3 vec![gate_45[0], gate_45[1], gate_45[2]] vec![7046232469803978873754056165670086532908888046886780200907660308846356865119, 16001732848952745747636754668380555263330934909183814105655567108556497219752, 9737276123084413897604802930591512772593843242069849260396983774140735981896] fun gate_46 =>
    halfRound_3_3 vec![gate_46[0], gate_46[1], gate_46[2]] vec![11410895086919039954381533622971292904413121053792570364694836768885182251535, 19098362474249267294548762387533474746422711206129028436248281690105483603471, 11013788190750472643548844759298623898218957233582881400726340624764440203586] fun gate_47 =>
    halfRound_3_3 vec![gate_47[0], gate_47[1], gate_47[2]] vec![2206958256327295151076063922661677909471794458896944583339625762978736821035, 7171889270225471948987523104033632910444398328090760036609063776968837717795, 2510237900514902891152324520472140114359583819338640775472608119384714834368] fun gate_48 =>
    halfRound_3_3 vec![gate_48[0], gate_48[1], gate_48[2]] vec![8825275525296082671615660088137472022727508654813239986303576303490504107418, 1481125575303576470988538039195271612778457110700618040436600537924912146613, 16268684562967416784133317570130804847322980788316762518215429249893668424280] fun gate_49 =>
    halfRound_3_3 vec![gate_49[0], gate_49[1], gate_49[2]] vec![4681491452239189664806745521067158092729838954919425311759965958272644506354, 3131438137839074317765338377823608627360421824842227925080193892542578675835, 7930402370812046914611776451748034256998580373012248216998696754202474945793] fun gate_50 =>
    halfRound_3_3 vec![gate_50[0], gate_50[1], gate_50[2]] vec![8973151117361309058790078507956716669068786070949641445408234962176963060145, 10223139291409280771165469989652431067575076252562753663259473331031932716923, 2232089286698717316374057160056566551249777684520809735680538268209217819725] fun gate_51 =>
    halfRound_3_3 vec![gate_51[0], gate_51[1], gate_51[2]] vec![16930089744400890347392540468934821520000065594669279286854302439710657571308, 21739597952486540111798430281275997558482064077591840966152905690279247146674, 7508315029150148468008716674010060103310093296969466203204862163743615534994] fun gate_52 =>
    halfRound_3_3 vec![gate_52[0], gate_52[1], gate_52[2]] vec![11418894863682894988747041469969889669847284797234703818032750410328384432224, 10895338268862022698088163806301557188640023613155321294365781481663489837917, 18644184384117747990653304688839904082421784959872380449968500304556054962449] fun gate_53 =>
    halfRound_3_3 vec![gate_53[0], gate_53[1], gate_53[2]] vec![7414443845282852488299349772251184564170443662081877445177167932875038836497, 5391299369598751507276083947272874512197023231529277107201098701900193273851, 10329906873896253554985208009869159014028187242848161393978194008068001342262] fun gate_54 =>
    halfRound_3_3 vec![gate_54[0], gate_54[1], gate_54[2]] vec![4711719500416619550464783480084256452493890461073147512131129596065578741786, 11943219201565014805519989716407790139241726526989183705078747065985453201504, 4298705349772984837150885571712355513879480272326239023123910904259614053334] fun gate_55 =>
    halfRound_3_3 vec![gate_55[0], gate_55[1], gate_55[2]] vec![9999044003322463509208400801275356671266978396985433172455084837770460579627, 4908416131442887573991189028182614782884545304889259793974797565686968097291, 11963412684806827200577486696316210731159599844307091475104710684559519773777] fun gate_56 =>
    halfRound_3_3 vec![gate_56[0], gate_56[1], gate_56[2]] vec![20129916000261129180023520480843084814481184380399868943565043864970719708502, 12884788430473747619080473633364244616344003003135883061507342348586143092592, 20286808211545908191036106582330883564479538831989852602050135926112143921015] fun gate_57 =>
    halfRound_3_3 vec![gate_57[0], gate_57[1], gate_57[2]] vec![16282045180030846845043407450751207026423331632332114205316676731302016331498, 4332932669439410887701725251009073017227450696965904037736403407953448682093, 11105712698773407689561953778861118250080830258196150686012791790342360778288] fun gate_58 =>
    halfRound_3_3 vec![gate_58[0], gate_58[1], gate_58[2]] vec![21853934471586954540926699232107176721894655187276984175226220218852955976831, 9807888223112768841912392164376763820266226276821186661925633831143729724792, 13411808896854134882869416756427789378942943805153730705795307450368858622668] fun gate_59 =>
    halfRound_3_3 vec![gate_59[0], gate_59[1], gate_59[2]] vec![17906847067500673080192335286161014930416613104209700445088168479205894040011, 14554387648466176616800733804942239711702169161888492380425023505790070369632, 4264116751358967409634966292436919795665643055548061693088119780787376143967] fun gate_60 =>
    fullRound_3_3 vec![gate_60[0], gate_60[1], gate_60[2]] vec![2401104597023440271473786738539405349187326308074330930748109868990675625380, 12251645483867233248963286274239998200789646392205783056343767189806123148785, 15331181254680049984374210433775713530849624954688899814297733641575188164316] fun gate_61 =>
    fullRound_3_3 vec![gate_61[0], gate_61[1], gate_61[2]] vec![13108834590369183125338853868477110922788848506677889928217413952560148766472, 6843160824078397950058285123048455551935389277899379615286104657075620692224, 10151103286206275742153883485231683504642432930275602063393479013696349676320] fun gate_62 =>
    fullRound_3_3 vec![gate_62[0], gate_62[1], gate_62[2]] vec![7074320081443088514060123546121507442501369977071685257650287261047855962224, 11413928794424774638606755585641504971720734248726394295158115188173278890938, 7312756097842145322667451519888915975561412209738441762091369106604423801080] fun gate_63 =>
    fullRound_3_3 vec![gate_63[0], gate_63[1], gate_63[2]] vec![7181677521425162567568557182629489303281861794357882492140051324529826589361, 15123155547166304758320442783720138372005699143801247333941013553002921430306, 13409242754315411433193860530743374419854094495153957441316635981078068351329] fun gate_64 =>
    k vec![gate_64[0], gate_64[1], gate_64[2]]

def Poseidon2 (In1: F) (In2: F) (k: F -> Prop): Prop :=
    poseidon_3 vec![0, In1, In2] fun gate_0 =>
    k gate_0[0]

def ProofRound (Direction: F) (Hash: F) (Sibling: F) (k: F -> Prop): Prop :=
    Gates.is_bool Direction ∧
    ∃gate_1, Gates.select Direction Hash Sibling gate_1 ∧
    ∃gate_2, Gates.select Direction Sibling Hash gate_2 ∧
    Poseidon2 gate_1 gate_2 fun gate_3 =>
    k gate_3

def VerifyProof_31_30 (Proof: Vector F 31) (Path: Vector F 30) (k: F -> Prop): Prop :=
    ProofRound Path[0] Proof[1] Proof[0] fun gate_0 =>
    ProofRound Path[1] Proof[2] gate_0 fun gate_1 =>
    ProofRound Path[2] Proof[3] gate_1 fun gate_2 =>
    ProofRound Path[3] Proof[4] gate_2 fun gate_3 =>
    ProofRound Path[4] Proof[5] gate_3 fun gate_4 =>
    ProofRound Path[5] Proof[6] gate_4 fun gate_5 =>
    ProofRound Path[6] Proof[7] gate_5 fun gate_6 =>
    ProofRound Path[7] Proof[8] gate_6 fun gate_7 =>
    ProofRound Path[8] Proof[9] gate_7 fun gate_8 =>
    ProofRound Path[9] Proof[10] gate_8 fun gate_9 =>
    ProofRound Path[10] Proof[11] gate_9 fun gate_10 =>
    ProofRound Path[11] Proof[12] gate_10 fun gate_11 =>
    ProofRound Path[12] Proof[13] gate_11 fun gate_12 =>
    ProofRound Path[13] Proof[14] gate_12 fun gate_13 =>
    ProofRound Path[14] Proof[15] gate_13 fun gate_14 =>
    ProofRound Path[15] Proof[16] gate_14 fun gate_15 =>
    ProofRound Path[16] Proof[17] gate_15 fun gate_16 =>
    ProofRound Path[17] Proof[18] gate_16 fun gate_17 =>
    ProofRound Path[18] Proof[19] gate_17 fun gate_18 =>
    ProofRound Path[19] Proof[20] gate_18 fun gate_19 =>
    ProofRound Path[20] Proof[21] gate_19 fun gate_20 =>
    ProofRound Path[21] Proof[22] gate_20 fun gate_21 =>
    ProofRound Path[22] Proof[23] gate_21 fun gate_22 =>
    ProofRound Path[23] Proof[24] gate_22 fun gate_23 =>
    ProofRound Path[24] Proof[25] gate_23 fun gate_24 =>
    ProofRound Path[25] Proof[26] gate_24 fun gate_25 =>
    ProofRound Path[26] Proof[27] gate_25 fun gate_26 =>
    ProofRound Path[27] Proof[28] gate_26 fun gate_27 =>
    ProofRound Path[28] Proof[29] gate_27 fun gate_28 =>
    ProofRound Path[29] Proof[30] gate_28 fun gate_29 =>
    k gate_29

def InsertionProof_3_30_3 (StartIndex: F) (PreRoot: F) (IdComms: Vector F 3) (MerkleProofs: Vector (Vector F 30) 3) (k: F -> Prop): Prop :=
    ∃gate_0, gate_0 = Gates.add StartIndex 0 ∧
    ∃gate_1, Gates.to_binary gate_0 30 gate_1 ∧
    VerifyProof_31_30 vec![0, MerkleProofs[0][0], MerkleProofs[0][1], MerkleProofs[0][2], MerkleProofs[0][3], MerkleProofs[0][4], MerkleProofs[0][5], MerkleProofs[0][6], MerkleProofs[0][7], MerkleProofs[0][8], MerkleProofs[0][9], MerkleProofs[0][10], MerkleProofs[0][11], MerkleProofs[0][12], MerkleProofs[0][13], MerkleProofs[0][14], MerkleProofs[0][15], MerkleProofs[0][16], MerkleProofs[0][17], MerkleProofs[0][18], MerkleProofs[0][19], MerkleProofs[0][20], MerkleProofs[0][21], MerkleProofs[0][22], MerkleProofs[0][23], MerkleProofs[0][24], MerkleProofs[0][25], MerkleProofs[0][26], MerkleProofs[0][27], MerkleProofs[0][28], MerkleProofs[0][29]] vec![gate_1[0], gate_1[1], gate_1[2], gate_1[3], gate_1[4], gate_1[5], gate_1[6], gate_1[7], gate_1[8], gate_1[9], gate_1[10], gate_1[11], gate_1[12], gate_1[13], gate_1[14], gate_1[15], gate_1[16], gate_1[17], gate_1[18], gate_1[19], gate_1[20], gate_1[21], gate_1[22], gate_1[23], gate_1[24], gate_1[25], gate_1[26], gate_1[27], gate_1[28], gate_1[29]] fun gate_2 =>
    Gates.eq gate_2 PreRoot ∧
    VerifyProof_31_30 vec![IdComms[0], MerkleProofs[0][0], MerkleProofs[0][1], MerkleProofs[0][2], MerkleProofs[0][3], MerkleProofs[0][4], MerkleProofs[0][5], MerkleProofs[0][6], MerkleProofs[0][7], MerkleProofs[0][8], MerkleProofs[0][9], MerkleProofs[0][10], MerkleProofs[0][11], MerkleProofs[0][12], MerkleProofs[0][13], MerkleProofs[0][14], MerkleProofs[0][15], MerkleProofs[0][16], MerkleProofs[0][17], MerkleProofs[0][18], MerkleProofs[0][19], MerkleProofs[0][20], MerkleProofs[0][21], MerkleProofs[0][22], MerkleProofs[0][23], MerkleProofs[0][24], MerkleProofs[0][25], MerkleProofs[0][26], MerkleProofs[0][27], MerkleProofs[0][28], MerkleProofs[0][29]] vec![gate_1[0], gate_1[1], gate_1[2], gate_1[3], gate_1[4], gate_1[5], gate_1[6], gate_1[7], gate_1[8], gate_1[9], gate_1[10], gate_1[11], gate_1[12], gate_1[13], gate_1[14], gate_1[15], gate_1[16], gate_1[17], gate_1[18], gate_1[19], gate_1[20], gate_1[21], gate_1[22], gate_1[23], gate_1[24], gate_1[25], gate_1[26], gate_1[27], gate_1[28], gate_1[29]] fun gate_4 =>
    ∃gate_5, gate_5 = Gates.add StartIndex 1 ∧
    ∃gate_6, Gates.to_binary gate_5 30 gate_6 ∧
    VerifyProof_31_30 vec![0, MerkleProofs[1][0], MerkleProofs[1][1], MerkleProofs[1][2], MerkleProofs[1][3], MerkleProofs[1][4], MerkleProofs[1][5], MerkleProofs[1][6], MerkleProofs[1][7], MerkleProofs[1][8], MerkleProofs[1][9], MerkleProofs[1][10], MerkleProofs[1][11], MerkleProofs[1][12], MerkleProofs[1][13], MerkleProofs[1][14], MerkleProofs[1][15], MerkleProofs[1][16], MerkleProofs[1][17], MerkleProofs[1][18], MerkleProofs[1][19], MerkleProofs[1][20], MerkleProofs[1][21], MerkleProofs[1][22], MerkleProofs[1][23], MerkleProofs[1][24], MerkleProofs[1][25], MerkleProofs[1][26], MerkleProofs[1][27], MerkleProofs[1][28], MerkleProofs[1][29]] vec![gate_6[0], gate_6[1], gate_6[2], gate_6[3], gate_6[4], gate_6[5], gate_6[6], gate_6[7], gate_6[8], gate_6[9], gate_6[10], gate_6[11], gate_6[12], gate_6[13], gate_6[14], gate_6[15], gate_6[16], gate_6[17], gate_6[18], gate_6[19], gate_6[20], gate_6[21], gate_6[22], gate_6[23], gate_6[24], gate_6[25], gate_6[26], gate_6[27], gate_6[28], gate_6[29]] fun gate_7 =>
    Gates.eq gate_7 gate_4 ∧
    VerifyProof_31_30 vec![IdComms[1], MerkleProofs[1][0], MerkleProofs[1][1], MerkleProofs[1][2], MerkleProofs[1][3], MerkleProofs[1][4], MerkleProofs[1][5], MerkleProofs[1][6], MerkleProofs[1][7], MerkleProofs[1][8], MerkleProofs[1][9], MerkleProofs[1][10], MerkleProofs[1][11], MerkleProofs[1][12], MerkleProofs[1][13], MerkleProofs[1][14], MerkleProofs[1][15], MerkleProofs[1][16], MerkleProofs[1][17], MerkleProofs[1][18], MerkleProofs[1][19], MerkleProofs[1][20], MerkleProofs[1][21], MerkleProofs[1][22], MerkleProofs[1][23], MerkleProofs[1][24], MerkleProofs[1][25], MerkleProofs[1][26], MerkleProofs[1][27], MerkleProofs[1][28], MerkleProofs[1][29]] vec![gate_6[0], gate_6[1], gate_6[2], gate_6[3], gate_6[4], gate_6[5], gate_6[6], gate_6[7], gate_6[8], gate_6[9], gate_6[10], gate_6[11], gate_6[12], gate_6[13], gate_6[14], gate_6[15], gate_6[16], gate_6[17], gate_6[18], gate_6[19], gate_6[20], gate_6[21], gate_6[22], gate_6[23], gate_6[24], gate_6[25], gate_6[26], gate_6[27], gate_6[28], gate_6[29]] fun gate_9 =>
    ∃gate_10, gate_10 = Gates.add StartIndex 2 ∧
    ∃gate_11, Gates.to_binary gate_10 30 gate_11 ∧
    VerifyProof_31_30 vec![0, MerkleProofs[2][0], MerkleProofs[2][1], MerkleProofs[2][2], MerkleProofs[2][3], MerkleProofs[2][4], MerkleProofs[2][5], MerkleProofs[2][6], MerkleProofs[2][7], MerkleProofs[2][8], MerkleProofs[2][9], MerkleProofs[2][10], MerkleProofs[2][11], MerkleProofs[2][12], MerkleProofs[2][13], MerkleProofs[2][14], MerkleProofs[2][15], MerkleProofs[2][16], MerkleProofs[2][17], MerkleProofs[2][18], MerkleProofs[2][19], MerkleProofs[2][20], MerkleProofs[2][21], MerkleProofs[2][22], MerkleProofs[2][23], MerkleProofs[2][24], MerkleProofs[2][25], MerkleProofs[2][26], MerkleProofs[2][27], MerkleProofs[2][28], MerkleProofs[2][29]] vec![gate_11[0], gate_11[1], gate_11[2], gate_11[3], gate_11[4], gate_11[5], gate_11[6], gate_11[7], gate_11[8], gate_11[9], gate_11[10], gate_11[11], gate_11[12], gate_11[13], gate_11[14], gate_11[15], gate_11[16], gate_11[17], gate_11[18], gate_11[19], gate_11[20], gate_11[21], gate_11[22], gate_11[23], gate_11[24], gate_11[25], gate_11[26], gate_11[27], gate_11[28], gate_11[29]] fun gate_12 =>
    Gates.eq gate_12 gate_9 ∧
    VerifyProof_31_30 vec![IdComms[2], MerkleProofs[2][0], MerkleProofs[2][1], MerkleProofs[2][2], MerkleProofs[2][3], MerkleProofs[2][4], MerkleProofs[2][5], MerkleProofs[2][6], MerkleProofs[2][7], MerkleProofs[2][8], MerkleProofs[2][9], MerkleProofs[2][10], MerkleProofs[2][11], MerkleProofs[2][12], MerkleProofs[2][13], MerkleProofs[2][14], MerkleProofs[2][15], MerkleProofs[2][16], MerkleProofs[2][17], MerkleProofs[2][18], MerkleProofs[2][19], MerkleProofs[2][20], MerkleProofs[2][21], MerkleProofs[2][22], MerkleProofs[2][23], MerkleProofs[2][24], MerkleProofs[2][25], MerkleProofs[2][26], MerkleProofs[2][27], MerkleProofs[2][28], MerkleProofs[2][29]] vec![gate_11[0], gate_11[1], gate_11[2], gate_11[3], gate_11[4], gate_11[5], gate_11[6], gate_11[7], gate_11[8], gate_11[9], gate_11[10], gate_11[11], gate_11[12], gate_11[13], gate_11[14], gate_11[15], gate_11[16], gate_11[17], gate_11[18], gate_11[19], gate_11[20], gate_11[21], gate_11[22], gate_11[23], gate_11[24], gate_11[25], gate_11[26], gate_11[27], gate_11[28], gate_11[29]] fun gate_14 =>
    k gate_14

end InsertionProof