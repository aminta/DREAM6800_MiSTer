module cpu68
  (input  clk,
   input  rst,
   output rw,
   output vma,
   output [15:0] address,
   input  [7:0] data_in,
   output [7:0] data_out,
   input  hold,
   input  halt,
   input  irq,
   input  nmi,
   output [15:0] test_alu,
   output [7:0] test_cc);
  wire [7:0] op_code;
  wire [7:0] acca;
  wire [7:0] accb;
  wire [7:0] cc;
  wire [7:0] cc_out;
  wire [15:0] xreg;
  wire [15:0] sp;
  wire [15:0] ea;
  wire [15:0] pc;
  wire [15:0] md;
  wire [15:0] left;
  wire [15:0] right;
  wire [15:0] out_alu;
  wire [1:0] iv;
  wire nmi_req;
  wire nmi_ack;
  wire [6:0] state;
  wire [6:0] next_state;
  wire [2:0] pc_ctrl;
  wire [2:0] ea_ctrl;
  wire [1:0] op_ctrl;
  wire [2:0] md_ctrl;
  wire [2:0] acca_ctrl;
  wire [1:0] accb_ctrl;
  wire [2:0] ix_ctrl;
  wire [1:0] cc_ctrl;
  wire [1:0] sp_ctrl;
  wire [2:0] iv_ctrl;
  wire [2:0] left_ctrl;
  wire [1:0] right_ctrl;
  wire [5:0] alu_ctrl;
  wire [2:0] addr_ctrl;
  wire [3:0] dout_ctrl;
  wire [1:0] nmi_ctrl;
  wire n8;
  wire n10;
  wire n12;
  wire n14;
  wire n16;
  wire n18;
  wire [14:0] n20;
  wire [15:0] n22;
  wire n24;
  wire [14:0] n26;
  wire [15:0] n28;
  wire n30;
  wire [7:0] n31;
  reg n41;
  reg n51;
  reg [15:0] n54;
  wire [7:0] n57;
  wire n59;
  wire [7:0] n60;
  wire n62;
  wire n64;
  wire n66;
  wire [7:0] n67;
  wire n69;
  wire [7:0] n70;
  wire n72;
  wire n74;
  wire [7:0] n75;
  wire n77;
  wire [7:0] n78;
  wire n80;
  wire [8:0] n81;
  reg [7:0] n83;
  wire n88;
  wire n89;
  wire [7:0] n90;
  wire [15:0] n92;
  wire [7:0] n93;
  wire [15:0] n95;
  wire [15:0] n96;
  wire n98;
  wire n100;
  wire [1:0] n101;
  reg [15:0] n104;
  wire n106;
  wire n108;
  wire [7:0] n109;
  wire n111;
  wire [7:0] n112;
  wire n114;
  wire [7:0] n115;
  wire n117;
  wire [4:0] n118;
  wire [7:0] n120;
  wire [7:0] n121;
  reg [7:0] n122;
  wire [7:0] n124;
  wire [7:0] n125;
  reg [7:0] n126;
  wire [15:0] n128;
  wire [15:0] n129;
  wire [15:0] n130;
  wire [7:0] n137;
  wire [15:0] n139;
  wire n141;
  wire n143;
  wire [1:0] n144;
  reg [15:0] n147;
  wire n149;
  wire [15:0] n151;
  wire n153;
  wire n155;
  wire n158;
  wire [7:0] n159;
  wire n161;
  wire [4:0] n162;
  wire [7:0] n164;
  wire [7:0] n165;
  wire [7:0] n166;
  reg [7:0] n167;
  wire [7:0] n169;
  wire [7:0] n170;
  wire [7:0] n171;
  reg [7:0] n172;
  wire [15:0] n174;
  wire [15:0] n175;
  wire [15:0] n176;
  wire n183;
  wire [7:0] n184;
  wire n186;
  wire [7:0] n187;
  wire n189;
  wire n191;
  wire [3:0] n192;
  reg [7:0] n194;
  wire [7:0] n195;
  wire n201;
  wire [7:0] n202;
  wire n204;
  wire n206;
  wire [2:0] n207;
  reg [7:0] n209;
  wire [7:0] n210;
  wire n216;
  wire n218;
  wire n220;
  wire n222;
  wire [3:0] n223;
  wire [7:0] n225;
  wire [7:0] n226;
  wire [7:0] n227;
  reg [7:0] n228;
  wire [7:0] n230;
  wire [7:0] n231;
  wire [7:0] n232;
  reg [7:0] n233;
  wire [15:0] n234;
  wire [15:0] n235;
  wire n241;
  wire n243;
  wire [1:0] n244;
  reg [15:0] n246;
  wire [15:0] n247;
  wire n253;
  wire n255;
  wire n258;
  wire [7:0] n259;
  wire n261;
  wire [14:0] n262;
  wire n265;
  wire [4:0] n266;
  wire n268;
  wire n269;
  wire n270;
  wire n271;
  reg n272;
  wire [6:0] n274;
  wire [6:0] n275;
  wire [6:0] n276;
  wire [6:0] n277;
  wire [6:0] n278;
  reg [6:0] n279;
  wire [7:0] n281;
  wire [7:0] n282;
  wire [7:0] n283;
  reg [7:0] n284;
  wire [15:0] n285;
  wire [15:0] n286;
  wire n292;
  wire n294;
  wire n296;
  wire [2:0] n297;
  reg [7:0] n299;
  wire [7:0] n300;
  wire n306;
  wire n308;
  wire n310;
  wire n312;
  wire [3:0] n313;
  reg [1:0] n318;
  wire [1:0] n319;
  wire n325;
  wire n327;
  wire [1:0] n328;
  reg [7:0] n330;
  wire [7:0] n331;
  wire n337;
  wire n340;
  wire n342;
  wire n344;
  wire n346;
  wire [4:0] n347;
  wire [7:0] n348;
  wire [7:0] n349;
  wire [7:0] n350;
  reg [7:0] n351;
  wire [7:0] n352;
  wire [7:0] n353;
  wire [7:0] n354;
  reg [7:0] n355;
  wire n359;
  wire n361;
  wire [15:0] n363;
  wire n365;
  wire [2:0] n366;
  reg [15:0] n369;
  wire n376;
  wire n378;
  wire n380;
  wire n381;
  wire n383;
  wire n384;
  wire n386;
  wire n387;
  reg n389;
  wire [3:0] n390;
  wire [31:0] n391;
  wire n393;
  wire [3:0] n394;
  wire [31:0] n395;
  wire n397;
  wire n398;
  wire n399;
  wire n400;
  wire [7:0] n403;
  wire [7:0] n406;
  wire [3:0] n407;
  wire [31:0] n408;
  wire n410;
  wire [7:0] n413;
  wire [7:0] n414;
  wire [7:0] n415;
  wire n416;
  wire [7:0] n419;
  wire [7:0] n421;
  wire [7:0] n422;
  wire [15:0] n423;
  wire [15:0] n425;
  wire [15:0] n426;
  wire n428;
  wire n430;
  wire n431;
  wire n433;
  wire n434;
  wire n436;
  wire n437;
  wire n439;
  wire n440;
  wire [15:0] n441;
  wire [15:0] n443;
  wire [15:0] n444;
  wire n446;
  wire n448;
  wire n449;
  wire n451;
  wire n452;
  wire n454;
  wire n455;
  wire n457;
  wire n458;
  wire n460;
  wire n461;
  wire [15:0] n462;
  wire n464;
  wire [15:0] n465;
  wire n467;
  wire [15:0] n468;
  wire n470;
  wire [14:0] n471;
  wire [15:0] n472;
  wire n474;
  wire n476;
  wire n477;
  wire n479;
  wire n480;
  wire [14:0] n481;
  wire [15:0] n482;
  wire n484;
  wire n486;
  wire n487;
  wire [8:0] n489;
  wire [6:0] n490;
  wire [15:0] n491;
  wire n493;
  wire n494;
  wire [8:0] n496;
  wire [6:0] n497;
  wire [15:0] n498;
  wire n500;
  wire [15:0] n501;
  wire n503;
  wire [15:0] n504;
  wire n506;
  wire n508;
  wire n510;
  wire n511;
  wire n513;
  wire n514;
  wire n516;
  wire n518;
  wire n519;
  wire [15:0] n521;
  wire [15:0] n522;
  wire n524;
  wire [15:0] n526;
  wire n528;
  wire [14:0] n529;
  reg [15:0] n530;
  wire n531;
  wire n532;
  wire n533;
  wire n534;
  wire n535;
  wire n536;
  wire n537;
  wire n538;
  wire n539;
  wire n540;
  wire n541;
  wire n542;
  wire n543;
  wire n545;
  wire n547;
  wire n548;
  wire n549;
  wire n550;
  wire n551;
  wire n552;
  wire n553;
  wire n554;
  wire n555;
  wire n556;
  wire n557;
  wire n558;
  wire n559;
  wire n560;
  wire n561;
  wire n563;
  wire n565;
  wire n566;
  wire n567;
  wire n568;
  wire n569;
  wire n570;
  wire n571;
  wire n572;
  wire n573;
  wire n574;
  wire n575;
  wire n576;
  wire n577;
  wire n578;
  wire n579;
  wire n581;
  wire n582;
  wire n583;
  wire n584;
  wire n585;
  wire n586;
  wire n587;
  wire n588;
  wire n589;
  wire n590;
  wire n591;
  wire n592;
  wire n593;
  wire n594;
  wire n596;
  wire n597;
  wire n599;
  wire n601;
  wire n602;
  wire n604;
  wire n605;
  wire n607;
  wire n608;
  wire n609;
  wire n611;
  wire n613;
  wire n614;
  wire n615;
  wire n617;
  wire n620;
  wire n621;
  wire n622;
  wire n623;
  wire n624;
  wire n625;
  wire n626;
  wire n627;
  wire n628;
  wire n629;
  wire n630;
  wire n631;
  wire n632;
  wire n633;
  wire n634;
  wire n635;
  wire n637;
  wire n639;
  wire n640;
  wire [3:0] n641;
  wire n643;
  wire n646;
  wire n648;
  wire n651;
  wire n654;
  wire n655;
  wire n657;
  wire n658;
  wire [12:0] n659;
  reg n660;
  wire n661;
  wire n662;
  wire n663;
  wire n664;
  wire n665;
  wire n666;
  wire n667;
  wire n668;
  wire n669;
  wire n670;
  wire n671;
  wire n672;
  wire n673;
  wire n674;
  wire n675;
  wire n676;
  wire n678;
  wire n680;
  wire n681;
  wire n683;
  wire n684;
  wire n686;
  wire n687;
  wire n689;
  wire n690;
  wire n692;
  wire n693;
  wire n695;
  wire n696;
  wire n698;
  wire n699;
  wire n701;
  wire n702;
  wire n704;
  wire n705;
  wire n707;
  wire n708;
  wire n710;
  wire n711;
  wire n713;
  wire n714;
  wire n716;
  wire n717;
  wire n719;
  wire n720;
  wire n722;
  wire n723;
  wire n725;
  wire n726;
  wire n728;
  wire n729;
  wire n731;
  wire n732;
  wire n733;
  wire n734;
  wire n735;
  wire n736;
  wire n737;
  wire n738;
  wire n739;
  wire n740;
  wire n741;
  wire n742;
  wire n743;
  wire n744;
  wire n745;
  wire n746;
  wire n747;
  wire n748;
  wire n749;
  wire n750;
  wire n751;
  wire n752;
  wire n753;
  wire n754;
  wire n755;
  wire n756;
  wire n757;
  wire n758;
  wire n759;
  wire n760;
  wire n761;
  wire n762;
  wire n763;
  wire n764;
  wire n766;
  wire n768;
  wire n769;
  wire n771;
  wire n772;
  wire n774;
  wire n775;
  wire n777;
  wire n778;
  wire n780;
  wire n781;
  wire n783;
  wire n784;
  wire n786;
  wire n787;
  wire n789;
  wire n790;
  wire n791;
  wire n793;
  wire n794;
  wire [2:0] n795;
  reg n796;
  wire n797;
  wire n799;
  wire n801;
  wire n802;
  wire n804;
  wire n805;
  wire n807;
  wire n808;
  wire n810;
  wire n811;
  wire n813;
  wire n814;
  wire n816;
  wire n817;
  wire n819;
  wire n820;
  wire n822;
  wire n823;
  wire n825;
  wire n826;
  wire n828;
  wire n829;
  wire n831;
  wire n832;
  wire n834;
  wire n835;
  wire n837;
  wire n838;
  wire n840;
  wire n841;
  wire n843;
  wire n844;
  wire n846;
  wire n847;
  wire n849;
  wire n850;
  wire n852;
  wire n853;
  wire n854;
  wire n856;
  wire n858;
  wire n859;
  wire n861;
  wire n862;
  wire n864;
  wire n865;
  wire n867;
  wire n868;
  wire n870;
  wire n871;
  wire n873;
  wire n874;
  wire n875;
  wire n877;
  wire n878;
  wire [2:0] n879;
  reg n880;
  wire n883;
  wire n886;
  wire n887;
  wire n889;
  wire n890;
  wire [2:0] n891;
  reg n892;
  wire n893;
  wire n894;
  wire n895;
  wire n896;
  wire n897;
  wire n898;
  wire n899;
  wire n900;
  wire n901;
  wire n902;
  wire n903;
  wire n904;
  wire n905;
  wire n907;
  wire n909;
  wire n910;
  wire n911;
  wire n913;
  wire n914;
  wire [1:0] n915;
  reg n916;
  wire n917;
  wire n918;
  wire n919;
  wire n920;
  wire n921;
  wire n922;
  wire n923;
  wire n924;
  wire n925;
  wire n926;
  wire n927;
  wire n928;
  wire n929;
  wire n930;
  wire n932;
  wire n934;
  wire n935;
  wire n936;
  wire n937;
  wire n938;
  wire n939;
  wire n940;
  wire n941;
  wire n942;
  wire n943;
  wire n944;
  wire n945;
  wire n946;
  wire n947;
  wire n948;
  wire n949;
  wire n951;
  wire n953;
  wire n954;
  wire n955;
  wire n956;
  wire n957;
  wire n958;
  wire n959;
  wire n960;
  wire n961;
  wire n962;
  wire n963;
  wire n964;
  wire n965;
  wire n966;
  wire n967;
  wire n968;
  wire n970;
  wire n971;
  wire n972;
  wire n973;
  wire n974;
  wire n975;
  wire n976;
  wire n977;
  wire n978;
  wire n979;
  wire n980;
  wire n981;
  wire n982;
  wire n983;
  wire n984;
  wire n986;
  wire n988;
  wire n989;
  wire n990;
  wire n991;
  wire n992;
  wire n993;
  wire n994;
  wire n995;
  wire n996;
  wire n997;
  wire n998;
  wire n999;
  wire n1000;
  wire n1001;
  wire n1002;
  wire n1003;
  wire n1004;
  wire n1005;
  wire n1007;
  wire n1008;
  wire n1009;
  wire n1010;
  wire n1011;
  wire n1012;
  wire n1013;
  wire n1014;
  wire n1015;
  wire n1016;
  wire n1017;
  wire n1018;
  wire n1019;
  wire n1020;
  wire n1021;
  wire n1022;
  wire n1023;
  wire n1024;
  wire n1025;
  wire n1026;
  wire n1027;
  wire n1028;
  wire n1029;
  wire n1031;
  wire n1033;
  wire n1034;
  wire n1035;
  wire n1036;
  wire n1037;
  wire n1039;
  wire n1040;
  wire n1042;
  wire n1044;
  wire n1045;
  wire n1046;
  wire n1047;
  wire n1048;
  wire n1050;
  wire n1051;
  wire n1052;
  wire n1053;
  wire n1055;
  wire n1056;
  wire n1057;
  wire n1058;
  wire n1060;
  wire n1062;
  wire n1063;
  wire n1064;
  wire n1066;
  wire n1069;
  wire n1071;
  wire n1072;
  wire n1074;
  wire n1075;
  wire n1077;
  wire n1078;
  wire n1080;
  wire n1081;
  wire n1083;
  wire n1084;
  wire n1086;
  wire n1087;
  wire n1089;
  wire n1090;
  wire n1092;
  wire n1093;
  wire n1096;
  wire n1097;
  wire [13:0] n1098;
  reg n1099;
  wire n1100;
  wire n1101;
  wire n1102;
  wire n1103;
  wire n1105;
  wire n1106;
  wire n1107;
  wire n1108;
  wire n1109;
  reg n1110;
  reg n1111;
  wire n1115;
  wire n1116;
  wire n1117;
  wire n1118;
  wire n1120;
  wire n1122;
  wire n1124;
  wire n1125;
  wire n1131;
  wire n1133;
  wire [1:0] n1134;
  reg n1137;
  wire n1138;
  wire n1144;
  wire n1146;
  wire n1148;
  wire [3:0] n1149;
  wire n1151;
  wire n1153;
  wire n1154;
  wire n1156;
  wire n1157;
  wire n1159;
  wire n1160;
  wire n1162;
  wire n1163;
  wire n1165;
  wire n1166;
  wire n1168;
  wire n1169;
  wire n1171;
  wire n1172;
  wire [3:0] n1173;
  wire n1175;
  wire n1177;
  wire n1179;
  wire n1181;
  wire n1183;
  wire n1185;
  wire n1187;
  wire n1189;
  wire n1191;
  wire n1193;
  wire n1195;
  wire n1197;
  wire n1199;
  wire n1201;
  wire n1203;
  wire n1205;
  wire [15:0] n1206;
  reg [2:0] n1224;
  reg [1:0] n1242;
  reg [1:0] n1260;
  reg [1:0] n1278;
  reg [2:0] n1296;
  reg [5:0] n1314;
  wire n1316;
  wire n1318;
  wire n1319;
  wire n1321;
  wire n1322;
  wire n1324;
  wire n1325;
  wire [3:0] n1326;
  wire n1328;
  wire n1330;
  wire n1332;
  wire n1334;
  wire n1336;
  wire n1338;
  wire n1340;
  wire n1342;
  wire n1344;
  wire n1346;
  wire n1348;
  wire n1350;
  wire n1352;
  wire n1354;
  wire n1356;
  wire n1358;
  wire [15:0] n1359;
  reg [2:0] n1377;
  reg [1:0] n1395;
  reg [2:0] n1413;
  reg [1:0] n1431;
  reg [2:0] n1449;
  reg [5:0] n1467;
  wire n1469;
  wire n1471;
  wire n1472;
  wire n1474;
  wire n1475;
  wire n1477;
  wire n1478;
  wire [2:0] n1479;
  reg [2:0] n1482;
  reg [1:0] n1485;
  reg [2:0] n1489;
  reg [1:0] n1492;
  reg [1:0] n1496;
  reg [2:0] n1499;
  reg [1:0] n1504;
  reg [5:0] n1507;
  wire n1508;
  wire n1509;
  wire n1510;
  wire n1511;
  wire [1:0] n1514;
  wire n1515;
  wire n1516;
  wire n1517;
  wire [6:0] n1520;
  wire [2:0] n1523;
  wire [1:0] n1526;
  wire [6:0] n1528;
  wire [2:0] n1530;
  wire [1:0] n1532;
  wire [1:0] n1534;
  wire [6:0] n1536;
  wire [2:0] n1538;
  wire [1:0] n1540;
  wire [1:0] n1543;
  wire n1545;
  wire [3:0] n1546;
  wire [3:0] n1547;
  wire n1549;
  wire n1551;
  wire n1553;
  wire n1555;
  wire n1557;
  wire n1559;
  wire n1561;
  wire n1563;
  wire n1565;
  wire n1567;
  wire n1569;
  wire n1571;
  wire n1573;
  wire [12:0] n1574;
  reg [6:0] n1589;
  reg [2:0] n1604;
  reg [1:0] n1619;
  reg [2:0] n1634;
  reg [1:0] n1649;
  reg [2:0] n1664;
  reg [1:0] n1679;
  reg [5:0] n1694;
  wire n1696;
  wire [3:0] n1697;
  wire n1699;
  wire n1701;
  wire n1703;
  wire n1705;
  wire n1707;
  wire n1709;
  wire [5:0] n1710;
  reg [2:0] n1718;
  reg [1:0] n1726;
  reg [1:0] n1734;
  reg [5:0] n1742;
  wire n1744;
  wire [3:0] n1745;
  wire n1747;
  wire n1749;
  wire n1750;
  wire n1751;
  wire n1752;
  wire n1753;
  wire [6:0] n1756;
  wire n1758;
  wire n1759;
  wire n1760;
  wire n1761;
  wire [6:0] n1764;
  wire n1766;
  wire n1767;
  wire n1768;
  wire [6:0] n1771;
  wire n1773;
  wire n1774;
  wire [6:0] n1777;
  wire n1779;
  wire n1780;
  wire n1781;
  wire [6:0] n1784;
  wire n1786;
  wire n1787;
  wire [6:0] n1790;
  wire n1792;
  wire n1793;
  wire n1794;
  wire [6:0] n1797;
  wire n1799;
  wire n1800;
  wire [6:0] n1803;
  wire n1805;
  wire n1806;
  wire n1807;
  wire [6:0] n1810;
  wire n1812;
  wire n1813;
  wire [6:0] n1816;
  wire n1818;
  wire n1819;
  wire n1820;
  wire n1821;
  wire n1822;
  wire [6:0] n1825;
  wire n1827;
  wire n1828;
  wire n1829;
  wire n1830;
  wire [6:0] n1833;
  wire n1835;
  wire n1836;
  wire n1837;
  wire n1838;
  wire n1839;
  wire n1840;
  wire n1841;
  wire [6:0] n1844;
  wire n1846;
  wire n1847;
  wire n1848;
  wire n1849;
  wire n1850;
  wire n1851;
  wire [6:0] n1854;
  wire n1856;
  wire [15:0] n1857;
  reg [6:0] n1861;
  wire n1863;
  wire [3:0] n1864;
  wire n1866;
  wire n1868;
  wire n1870;
  wire n1872;
  wire n1874;
  wire n1876;
  wire n1878;
  wire n1880;
  wire n1882;
  wire n1884;
  wire n1886;
  wire n1888;
  wire n1890;
  wire n1892;
  wire n1894;
  wire n1896;
  wire [15:0] n1897;
  reg [6:0] n1915;
  reg [2:0] n1933;
  reg [1:0] n1951;
  reg [2:0] n1969;
  reg [1:0] n1987;
  reg [5:0] n2005;
  wire n2007;
  wire [3:0] n2008;
  wire n2010;
  wire n2012;
  wire n2014;
  wire n2016;
  wire n2018;
  wire n2020;
  wire n2022;
  wire n2024;
  wire n2026;
  wire n2028;
  wire n2030;
  wire n2032;
  wire n2034;
  wire [12:0] n2035;
  reg [2:0] n2050;
  reg [1:0] n2065;
  reg [1:0] n2080;
  reg [5:0] n2095;
  wire n2097;
  wire [3:0] n2098;
  wire n2100;
  wire n2102;
  wire n2104;
  wire n2106;
  wire n2108;
  wire n2110;
  wire n2112;
  wire n2114;
  wire n2116;
  wire n2118;
  wire n2120;
  wire n2122;
  wire n2124;
  wire [12:0] n2125;
  reg [1:0] n2140;
  reg [1:0] n2155;
  reg [1:0] n2170;
  reg [5:0] n2185;
  wire n2187;
  wire n2189;
  wire n2191;
  wire [3:0] n2192;
  wire n2194;
  wire n2196;
  wire n2197;
  wire n2199;
  wire n2200;
  wire n2202;
  wire [1:0] n2203;
  reg [6:0] n2207;
  reg [2:0] n2210;
  reg [1:0] n2214;
  reg [2:0] n2218;
  reg [1:0] n2222;
  reg [5:0] n2226;
  wire n2229;
  wire [3:0] n2230;
  wire n2232;
  wire n2234;
  wire n2236;
  wire [2:0] n2237;
  reg [6:0] n2242;
  reg [2:0] n2247;
  reg [2:0] n2252;
  reg [5:0] n2257;
  wire n2259;
  wire n2261;
  wire n2263;
  wire [3:0] n2264;
  wire n2266;
  wire n2268;
  wire n2269;
  wire n2271;
  wire n2272;
  reg [6:0] n2275;
  wire n2277;
  wire [3:0] n2278;
  wire n2280;
  wire n2282;
  wire n2284;
  wire [2:0] n2285;
  reg [6:0] n2290;
  reg [2:0] n2295;
  reg [2:0] n2300;
  reg [5:0] n2305;
  wire n2307;
  wire n2309;
  wire n2311;
  wire [15:0] n2312;
  reg [6:0] n2323;
  reg [2:0] n2341;
  reg [2:0] n2356;
  reg [2:0] n2371;
  reg [1:0] n2386;
  reg [2:0] n2402;
  reg [1:0] n2415;
  reg [1:0] n2432;
  reg [2:0] n2445;
  reg [1:0] n2458;
  reg [5:0] n2468;
  wire n2470;
  wire n2472;
  wire [3:0] n2473;
  wire [3:0] n2474;
  wire n2476;
  wire n2478;
  wire [1:0] n2479;
  reg [6:0] n2483;
  wire n2485;
  wire [3:0] n2486;
  wire n2488;
  wire n2490;
  wire n2492;
  wire [2:0] n2493;
  reg [6:0] n2498;
  reg [2:0] n2503;
  reg [2:0] n2508;
  reg [5:0] n2513;
  wire n2515;
  wire [3:0] n2516;
  wire n2518;
  wire n2520;
  wire n2522;
  wire [2:0] n2523;
  reg [6:0] n2528;
  reg [2:0] n2533;
  reg [2:0] n2538;
  reg [5:0] n2543;
  wire n2545;
  wire [2:0] n2546;
  reg [6:0] n2548;
  reg [2:0] n2551;
  reg [2:0] n2554;
  reg [5:0] n2557;
  wire n2559;
  wire [3:0] n2560;
  wire [3:0] n2561;
  wire n2563;
  wire n2565;
  wire [1:0] n2566;
  reg [6:0] n2570;
  reg [2:0] n2573;
  wire n2575;
  wire [3:0] n2576;
  wire n2578;
  wire n2580;
  wire n2582;
  wire [2:0] n2583;
  reg [6:0] n2588;
  reg [2:0] n2593;
  reg [2:0] n2598;
  reg [5:0] n2603;
  wire n2605;
  wire [3:0] n2606;
  wire n2608;
  wire n2610;
  wire n2612;
  wire [2:0] n2613;
  reg [6:0] n2618;
  reg [2:0] n2623;
  reg [2:0] n2628;
  reg [5:0] n2633;
  wire n2635;
  wire [2:0] n2636;
  reg [6:0] n2638;
  reg [2:0] n2640;
  reg [2:0] n2644;
  reg [2:0] n2647;
  reg [5:0] n2650;
  wire n2652;
  wire [3:0] n2653;
  wire n2655;
  wire n2657;
  wire n2658;
  wire [3:0] n2659;
  wire n2661;
  wire n2663;
  wire n2664;
  wire n2666;
  wire n2667;
  reg [6:0] n2670;
  reg [2:0] n2673;
  wire n2675;
  wire n2677;
  wire n2678;
  wire n2680;
  wire n2681;
  wire [3:0] n2682;
  wire n2684;
  wire n2686;
  wire n2687;
  wire n2689;
  wire n2690;
  reg [6:0] n2693;
  reg [2:0] n2696;
  wire n2698;
  wire n2700;
  wire n2701;
  wire n2703;
  wire n2704;
  wire [2:0] n2705;
  reg [6:0] n2708;
  reg [2:0] n2711;
  wire n2713;
  wire n2715;
  wire n2717;
  wire n2719;
  wire n2721;
  wire n2723;
  wire n2725;
  wire n2727;
  wire n2729;
  wire n2731;
  wire n2733;
  wire n2735;
  wire n2737;
  wire n2739;
  wire n2741;
  wire n2742;
  wire [2:0] n2745;
  wire [1:0] n2748;
  wire [1:0] n2751;
  wire n2753;
  wire n2754;
  wire [2:0] n2757;
  wire [1:0] n2760;
  wire [1:0] n2763;
  wire n2765;
  wire n2766;
  wire [2:0] n2769;
  wire [1:0] n2772;
  wire [1:0] n2775;
  wire n2777;
  wire n2778;
  wire [2:0] n2781;
  wire [1:0] n2784;
  wire [1:0] n2787;
  wire n2789;
  wire n2790;
  wire [2:0] n2793;
  wire [1:0] n2796;
  wire [1:0] n2799;
  wire n2801;
  wire n2802;
  wire [2:0] n2805;
  wire [1:0] n2808;
  wire [1:0] n2811;
  wire n2813;
  wire n2814;
  wire [2:0] n2817;
  wire [1:0] n2820;
  wire [1:0] n2823;
  wire n2825;
  wire n2826;
  wire [2:0] n2829;
  wire [1:0] n2832;
  wire [1:0] n2835;
  wire n2837;
  wire [3:0] n2838;
  wire [3:0] n2839;
  wire n2840;
  wire n2841;
  wire [6:0] n2844;
  wire n2846;
  wire n2847;
  wire n2848;
  wire [6:0] n2851;
  wire n2853;
  wire n2854;
  wire n2855;
  wire [6:0] n2858;
  wire n2860;
  wire n2861;
  wire n2862;
  wire [6:0] n2865;
  wire n2867;
  wire n2868;
  wire n2869;
  wire [6:0] n2872;
  wire n2874;
  wire n2875;
  wire n2876;
  wire [6:0] n2879;
  wire n2881;
  wire n2882;
  wire n2883;
  wire [6:0] n2886;
  wire n2888;
  wire n2889;
  wire n2890;
  wire [6:0] n2893;
  wire n2895;
  wire n2897;
  wire n2898;
  wire n2899;
  wire [6:0] n2902;
  wire n2904;
  wire n2905;
  wire n2906;
  wire [6:0] n2909;
  wire n2911;
  wire n2913;
  wire n2914;
  wire n2915;
  wire [6:0] n2918;
  wire n2920;
  wire [12:0] n2921;
  reg [6:0] n2925;
  reg [2:0] n2940;
  reg [1:0] n2955;
  reg [1:0] n2970;
  reg [5:0] n2985;
  wire n2987;
  wire n2989;
  wire n2990;
  reg [6:0] n2992;
  reg [2:0] n2994;
  reg [1:0] n2996;
  reg [2:0] n2999;
  reg [1:0] n3001;
  reg [5:0] n3003;
  wire n3005;
  wire n3007;
  wire n3009;
  wire n3011;
  wire n3013;
  wire n3015;
  wire n3017;
  wire n3019;
  wire n3021;
  wire n3023;
  wire n3025;
  wire n3027;
  wire n3029;
  wire n3031;
  wire n3033;
  wire n3035;
  wire n3037;
  wire n3039;
  wire n3041;
  wire n3043;
  wire n3045;
  wire n3047;
  wire n3049;
  wire n3050;
  wire n3051;
  wire n3052;
  wire n3054;
  wire n3056;
  wire [1:0] n3057;
  reg [6:0] n3061;
  reg [2:0] n3065;
  wire [6:0] n3067;
  wire [2:0] n3069;
  wire [6:0] n3071;
  wire [2:0] n3073;
  wire n3075;
  wire n3076;
  wire n3077;
  wire n3078;
  wire n3079;
  wire [1:0] n3082;
  wire n3083;
  wire n3084;
  wire n3085;
  wire [6:0] n3088;
  wire [2:0] n3091;
  wire [6:0] n3093;
  wire [2:0] n3095;
  wire [1:0] n3097;
  wire n3099;
  wire n3101;
  wire [6:0] n3104;
  wire n3106;
  wire n3108;
  wire n3110;
  wire n3112;
  wire n3114;
  wire n3116;
  wire n3118;
  wire n3120;
  wire n3122;
  wire n3124;
  wire n3126;
  wire n3128;
  wire n3130;
  wire [69:0] n3131;
  reg [6:0] n3194;
  reg [2:0] n3263;
  reg [2:0] n3334;
  reg [1:0] n3405;
  reg [2:0] n3473;
  reg [2:0] n3535;
  reg [1:0] n3597;
  reg [2:0] n3667;
  reg [1:0] n3728;
  reg [1:0] n3798;
  reg [2:0] n3868;
  reg [2:0] n3935;
  reg [1:0] n4004;
  reg [5:0] n4071;
  reg [2:0] n4143;
  reg [3:0] n4215;
  reg [1:0] n4285;
  wire [6:0] n4289;
  wire [6:0] n4291;
  wire [7:0] n4294;
  wire [15:0] n4295;
  reg [7:0] n4296;
  reg [7:0] n4297;
  reg [7:0] n4298;
  reg [7:0] n4299;
  reg [15:0] n4300;
  reg [15:0] n4301;
  reg [15:0] n4302;
  reg [15:0] n4303;
  reg [15:0] n4304;
  reg [1:0] n4305;
  reg n4306;
  reg n4307;
  reg [6:0] n4308;
  assign rw = n41; //(module output)
  assign vma = n51; //(module output)
  assign address = n54; //(module output)
  assign data_out = n83; //(module output)
  assign test_alu = out_alu; //(module output)
  assign test_cc = cc_out; //(module output)
  /*# rtl/cpu68.vhd:162:16 */
  assign op_code = n4296; // (signal)
  /*# rtl/cpu68.vhd:163:16 */
  assign acca = n4297; // (signal)
  /*# rtl/cpu68.vhd:164:16 */
  assign accb = n4298; // (signal)
  /*# rtl/cpu68.vhd:165:16 */
  assign cc = n4299; // (signal)
  /*# rtl/cpu68.vhd:166:16 */
  assign cc_out = n4294; // (signal)
  /*# rtl/cpu68.vhd:167:16 */
  assign xreg = n4300; // (signal)
  /*# rtl/cpu68.vhd:168:16 */
  assign sp = n4301; // (signal)
  /*# rtl/cpu68.vhd:169:16 */
  assign ea = n4302; // (signal)
  /*# rtl/cpu68.vhd:170:16 */
  assign pc = n4303; // (signal)
  /*# rtl/cpu68.vhd:171:16 */
  assign md = n4304; // (signal)
  /*# rtl/cpu68.vhd:172:16 */
  assign left = n4295; // (signal)
  /*# rtl/cpu68.vhd:173:16 */
  assign right = n369; // (signal)
  /*# rtl/cpu68.vhd:174:16 */
  assign out_alu = n530; // (signal)
  /*# rtl/cpu68.vhd:175:16 */
  assign iv = n4305; // (signal)
  /*# rtl/cpu68.vhd:176:16 */
  assign nmi_req = n4306; // (signal)
  /*# rtl/cpu68.vhd:177:16 */
  assign nmi_ack = n4307; // (signal)
  /*# rtl/cpu68.vhd:179:16 */
  assign state = n4308; // (signal)
  /*# rtl/cpu68.vhd:180:16 */
  assign next_state = n3194; // (signal)
  /*# rtl/cpu68.vhd:181:16 */
  assign pc_ctrl = n3263; // (signal)
  /*# rtl/cpu68.vhd:182:16 */
  assign ea_ctrl = n3334; // (signal)
  /*# rtl/cpu68.vhd:183:16 */
  assign op_ctrl = n3405; // (signal)
  /*# rtl/cpu68.vhd:184:16 */
  assign md_ctrl = n3473; // (signal)
  /*# rtl/cpu68.vhd:185:16 */
  assign acca_ctrl = n3535; // (signal)
  /*# rtl/cpu68.vhd:186:16 */
  assign accb_ctrl = n3597; // (signal)
  /*# rtl/cpu68.vhd:187:16 */
  assign ix_ctrl = n3667; // (signal)
  /*# rtl/cpu68.vhd:188:16 */
  assign cc_ctrl = n3728; // (signal)
  /*# rtl/cpu68.vhd:189:16 */
  assign sp_ctrl = n3798; // (signal)
  /*# rtl/cpu68.vhd:190:16 */
  assign iv_ctrl = n3868; // (signal)
  /*# rtl/cpu68.vhd:191:16 */
  assign left_ctrl = n3935; // (signal)
  /*# rtl/cpu68.vhd:192:16 */
  assign right_ctrl = n4004; // (signal)
  /*# rtl/cpu68.vhd:193:16 */
  assign alu_ctrl = n4071; // (signal)
  /*# rtl/cpu68.vhd:194:16 */
  assign addr_ctrl = n4143; // (signal)
  /*# rtl/cpu68.vhd:195:16 */
  assign dout_ctrl = n4215; // (signal)
  /*# rtl/cpu68.vhd:196:16 */
  assign nmi_ctrl = n4285; // (signal)
  /*# rtl/cpu68.vhd:207:25 */
  assign n8 = addr_ctrl == 3'b000;
  /*# rtl/cpu68.vhd:211:25 */
  assign n10 = addr_ctrl == 3'b001;
  /*# rtl/cpu68.vhd:215:25 */
  assign n12 = addr_ctrl == 3'b010;
  /*# rtl/cpu68.vhd:219:25 */
  assign n14 = addr_ctrl == 3'b011;
  /*# rtl/cpu68.vhd:223:25 */
  assign n16 = addr_ctrl == 3'b100;
  /*# rtl/cpu68.vhd:227:25 */
  assign n18 = addr_ctrl == 3'b101;
  /*# rtl/cpu68.vhd:232:60 */
  assign n20 = {13'b1111111111111, iv};
  /*# rtl/cpu68.vhd:232:65 */
  assign n22 = {n20, 1'b0};
  /*# rtl/cpu68.vhd:231:25 */
  assign n24 = addr_ctrl == 3'b110;
  /*# rtl/cpu68.vhd:236:60 */
  assign n26 = {13'b1111111111111, iv};
  /*# rtl/cpu68.vhd:236:65 */
  assign n28 = {n26, 1'b1};
  /*# rtl/cpu68.vhd:235:25 */
  assign n30 = addr_ctrl == 3'b111;
  /*# rtl/cpu68.vhd:206:17 */
  assign n31 = {n30, n24, n18, n16, n14, n12, n10, n8};
  /*# rtl/cpu68.vhd:206:17 */
  always @*
    case (n31)
      8'b10000000: n41 = 1'b1;
      8'b01000000: n41 = 1'b1;
      8'b00100000: n41 = 1'b1;
      8'b00010000: n41 = 1'b0;
      8'b00001000: n41 = 1'b0;
      8'b00000100: n41 = 1'b1;
      8'b00000010: n41 = 1'b1;
      8'b00000001: n41 = 1'b1;
      default: n41 = 1'b1;
    endcase
  /*# rtl/cpu68.vhd:206:17 */
  always @*
    case (n31)
      8'b10000000: n51 = 1'b1;
      8'b01000000: n51 = 1'b1;
      8'b00100000: n51 = 1'b1;
      8'b00010000: n51 = 1'b1;
      8'b00001000: n51 = 1'b1;
      8'b00000100: n51 = 1'b1;
      8'b00000010: n51 = 1'b1;
      8'b00000001: n51 = 1'b0;
      default: n51 = 1'b0;
    endcase
  /*# rtl/cpu68.vhd:206:17 */
  always @*
    case (n31)
      8'b10000000: n54 = n28;
      8'b01000000: n54 = n22;
      8'b00100000: n54 = sp;
      8'b00010000: n54 = sp;
      8'b00001000: n54 = ea;
      8'b00000100: n54 = ea;
      8'b00000010: n54 = pc;
      8'b00000001: n54 = 16'b1111111111111111;
      default: n54 = 16'b1111111111111111;
    endcase
  /*# rtl/cpu68.vhd:255:47 */
  assign n57 = md[15:8]; // extract
  /*# rtl/cpu68.vhd:254:25 */
  assign n59 = dout_ctrl == 4'b0001;
  /*# rtl/cpu68.vhd:257:47 */
  assign n60 = md[7:0]; // extract
  /*# rtl/cpu68.vhd:256:25 */
  assign n62 = dout_ctrl == 4'b0000;
  /*# rtl/cpu68.vhd:258:25 */
  assign n64 = dout_ctrl == 4'b0010;
  /*# rtl/cpu68.vhd:260:25 */
  assign n66 = dout_ctrl == 4'b0011;
  /*# rtl/cpu68.vhd:263:49 */
  assign n67 = xreg[7:0]; // extract
  /*# rtl/cpu68.vhd:262:25 */
  assign n69 = dout_ctrl == 4'b0100;
  /*# rtl/cpu68.vhd:265:49 */
  assign n70 = xreg[15:8]; // extract
  /*# rtl/cpu68.vhd:264:25 */
  assign n72 = dout_ctrl == 4'b0101;
  /*# rtl/cpu68.vhd:266:25 */
  assign n74 = dout_ctrl == 4'b0110;
  /*# rtl/cpu68.vhd:269:47 */
  assign n75 = pc[7:0]; // extract
  /*# rtl/cpu68.vhd:268:25 */
  assign n77 = dout_ctrl == 4'b0111;
  /*# rtl/cpu68.vhd:271:47 */
  assign n78 = pc[15:8]; // extract
  /*# rtl/cpu68.vhd:270:25 */
  assign n80 = dout_ctrl == 4'b1000;
  /*# rtl/cpu68.vhd:253:17 */
  assign n81 = {n80, n77, n74, n72, n69, n66, n64, n62, n59};
  /*# rtl/cpu68.vhd:253:17 */
  always @*
    case (n81)
      9'b100000000: n83 = n78;
      9'b010000000: n83 = n75;
      9'b001000000: n83 = cc;
      9'b000100000: n83 = n70;
      9'b000010000: n83 = n67;
      9'b000001000: n83 = accb;
      9'b000000100: n83 = acca;
      9'b000000010: n83 = n60;
      9'b000000001: n83 = n57;
      default: n83 = 8'b00000000;
    endcase
  /*# rtl/cpu68.vhd:288:38 */
  assign n88 = ea[7]; // extract
  /*# rtl/cpu68.vhd:288:42 */
  assign n89 = ~n88;
  /*# rtl/cpu68.vhd:289:66 */
  assign n90 = ea[7:0]; // extract
  /*# rtl/cpu68.vhd:289:62 */
  assign n92 = {8'b00000000, n90};
  /*# rtl/cpu68.vhd:291:66 */
  assign n93 = ea[7:0]; // extract
  /*# rtl/cpu68.vhd:291:62 */
  assign n95 = {8'b11111111, n93};
  /*# rtl/cpu68.vhd:288:33 */
  assign n96 = n89 ? n92 : n95;
  /*# rtl/cpu68.vhd:287:25 */
  assign n98 = pc_ctrl == 3'b011;
  /*# rtl/cpu68.vhd:293:25 */
  assign n100 = pc_ctrl == 3'b110;
  /*# rtl/cpu68.vhd:286:17 */
  assign n101 = {n100, n98};
  /*# rtl/cpu68.vhd:286:17 */
  always @*
    case (n101)
      2'b10: n104 = 16'b0000000000000001;
      2'b01: n104 = n96;
      default: n104 = 16'b0000000000000000;
    endcase
  /*# rtl/cpu68.vhd:300:25 */
  assign n106 = pc_ctrl == 3'b000;
  /*# rtl/cpu68.vhd:302:25 */
  assign n108 = pc_ctrl == 3'b010;
  /*# rtl/cpu68.vhd:305:58 */
  assign n109 = ea[7:0]; // extract
  /*# rtl/cpu68.vhd:304:25 */
  assign n111 = pc_ctrl == 3'b111;
  /*# rtl/cpu68.vhd:309:58 */
  assign n112 = pc[15:8]; // extract
  /*# rtl/cpu68.vhd:307:25 */
  assign n114 = pc_ctrl == 3'b100;
  /*# rtl/cpu68.vhd:311:57 */
  assign n115 = pc[7:0]; // extract
  /*# rtl/cpu68.vhd:310:25 */
  assign n117 = pc_ctrl == 3'b101;
  /*# rtl/cpu68.vhd:299:17 */
  assign n118 = {n117, n114, n111, n108, n106};
  /*# rtl/cpu68.vhd:169:16 */
  assign n120 = ea[7:0]; // extract
  /*# rtl/cpu68.vhd:170:16 */
  assign n121 = pc[7:0]; // extract
  /*# rtl/cpu68.vhd:299:17 */
  always @*
    case (n118)
      5'b10000: n122 = n115;
      5'b01000: n122 = data_in;
      5'b00100: n122 = data_in;
      5'b00010: n122 = n120;
      5'b00001: n122 = 8'b11111110;
      default: n122 = n121;
    endcase
  /*# rtl/cpu68.vhd:169:16 */
  assign n124 = ea[15:8]; // extract
  /*# rtl/cpu68.vhd:170:16 */
  assign n125 = pc[15:8]; // extract
  /*# rtl/cpu68.vhd:299:17 */
  always @*
    case (n118)
      5'b10000: n126 = data_in;
      5'b01000: n126 = n112;
      5'b00100: n126 = n109;
      5'b00010: n126 = n124;
      5'b00001: n126 = 8'b11111111;
      default: n126 = n125;
    endcase
  /*# rtl/cpu68.vhd:284:26 */
  assign n128 = {n126, n122};
  /*# rtl/cpu68.vhd:321:46 */
  assign n129 = n128 + n104;
  /*# rtl/cpu68.vhd:318:25 */
  assign n130 = hold ? pc : n129;
  /*# rtl/cpu68.vhd:338:59 */
  assign n137 = ea[7:0]; // extract
  /*# rtl/cpu68.vhd:338:55 */
  assign n139 = {8'b00000000, n137};
  /*# rtl/cpu68.vhd:337:25 */
  assign n141 = ea_ctrl == 3'b010;
  /*# rtl/cpu68.vhd:339:25 */
  assign n143 = ea_ctrl == 3'b100;
  /*# rtl/cpu68.vhd:336:17 */
  assign n144 = {n143, n141};
  /*# rtl/cpu68.vhd:336:17 */
  always @*
    case (n144)
      2'b10: n147 = 16'b0000000000000001;
      2'b01: n147 = n139;
      default: n147 = 16'b0000000000000000;
    endcase
  /*# rtl/cpu68.vhd:346:25 */
  assign n149 = ea_ctrl == 3'b000;
  /*# rtl/cpu68.vhd:349:54 */
  assign n151 = {8'b00000000, accb};
  /*# rtl/cpu68.vhd:348:25 */
  assign n153 = ea_ctrl == 3'b011;
  /*# rtl/cpu68.vhd:350:25 */
  assign n155 = ea_ctrl == 3'b010;
  /*# rtl/cpu68.vhd:352:25 */
  assign n158 = ea_ctrl == 3'b101;
  /*# rtl/cpu68.vhd:357:58 */
  assign n159 = ea[7:0]; // extract
  /*# rtl/cpu68.vhd:355:25 */
  assign n161 = ea_ctrl == 3'b110;
  /*# rtl/cpu68.vhd:345:17 */
  assign n162 = {n161, n158, n155, n153, n149};
  /*# rtl/cpu68.vhd:349:54 */
  assign n164 = n151[7:0]; // extract
  /*# rtl/cpu68.vhd:167:16 */
  assign n165 = xreg[7:0]; // extract
  /*# rtl/cpu68.vhd:169:16 */
  assign n166 = ea[7:0]; // extract
  /*# rtl/cpu68.vhd:345:17 */
  always @*
    case (n162)
      5'b10000: n167 = data_in;
      5'b01000: n167 = data_in;
      5'b00100: n167 = n165;
      5'b00010: n167 = n164;
      5'b00001: n167 = 8'b00000000;
      default: n167 = n166;
    endcase
  /*# rtl/cpu68.vhd:349:54 */
  assign n169 = n151[15:8]; // extract
  /*# rtl/cpu68.vhd:167:16 */
  assign n170 = xreg[15:8]; // extract
  /*# rtl/cpu68.vhd:169:16 */
  assign n171 = ea[15:8]; // extract
  /*# rtl/cpu68.vhd:345:17 */
  always @*
    case (n162)
      5'b10000: n172 = n159;
      5'b01000: n172 = 8'b00000000;
      5'b00100: n172 = n170;
      5'b00010: n172 = n169;
      5'b00001: n172 = 8'b00000000;
      default: n172 = n171;
    endcase
  /*# rtl/cpu68.vhd:334:26 */
  assign n174 = {n172, n167};
  /*# rtl/cpu68.vhd:366:46 */
  assign n175 = n174 + n147;
  /*# rtl/cpu68.vhd:363:25 */
  assign n176 = hold ? ea : n175;
  /*# rtl/cpu68.vhd:383:41 */
  assign n183 = acca_ctrl == 3'b000;
  /*# rtl/cpu68.vhd:386:64 */
  assign n184 = out_alu[7:0]; // extract
  /*# rtl/cpu68.vhd:385:41 */
  assign n186 = acca_ctrl == 3'b001;
  /*# rtl/cpu68.vhd:388:64 */
  assign n187 = out_alu[15:8]; // extract
  /*# rtl/cpu68.vhd:387:41 */
  assign n189 = acca_ctrl == 3'b010;
  /*# rtl/cpu68.vhd:389:41 */
  assign n191 = acca_ctrl == 3'b011;
  /*# rtl/cpu68.vhd:382:33 */
  assign n192 = {n191, n189, n186, n183};
  /*# rtl/cpu68.vhd:382:33 */
  always @*
    case (n192)
      4'b1000: n194 = data_in;
      4'b0100: n194 = n187;
      4'b0010: n194 = n184;
      4'b0001: n194 = 8'b00000000;
      default: n194 = acca;
    endcase
  /*# rtl/cpu68.vhd:379:25 */
  assign n195 = hold ? acca : n194;
  /*# rtl/cpu68.vhd:411:41 */
  assign n201 = accb_ctrl == 2'b00;
  /*# rtl/cpu68.vhd:414:64 */
  assign n202 = out_alu[7:0]; // extract
  /*# rtl/cpu68.vhd:413:41 */
  assign n204 = accb_ctrl == 2'b01;
  /*# rtl/cpu68.vhd:415:41 */
  assign n206 = accb_ctrl == 2'b10;
  /*# rtl/cpu68.vhd:410:33 */
  assign n207 = {n206, n204, n201};
  /*# rtl/cpu68.vhd:410:33 */
  always @*
    case (n207)
      3'b100: n209 = data_in;
      3'b010: n209 = n202;
      3'b001: n209 = 8'b00000000;
      default: n209 = accb;
    endcase
  /*# rtl/cpu68.vhd:407:25 */
  assign n210 = hold ? accb : n209;
  /*# rtl/cpu68.vhd:437:41 */
  assign n216 = ix_ctrl == 3'b000;
  /*# rtl/cpu68.vhd:439:41 */
  assign n218 = ix_ctrl == 3'b001;
  /*# rtl/cpu68.vhd:441:41 */
  assign n220 = ix_ctrl == 3'b011;
  /*# rtl/cpu68.vhd:443:41 */
  assign n222 = ix_ctrl == 3'b010;
  /*# rtl/cpu68.vhd:436:33 */
  assign n223 = {n222, n220, n218, n216};
  /*# rtl/cpu68.vhd:174:16 */
  assign n225 = out_alu[7:0]; // extract
  /*# rtl/cpu68.vhd:167:16 */
  assign n226 = xreg[7:0]; // extract
  /*# rtl/cpu68.vhd:167:16 */
  assign n227 = xreg[7:0]; // extract
  /*# rtl/cpu68.vhd:436:33 */
  always @*
    case (n223)
      4'b1000: n228 = data_in;
      4'b0100: n228 = n227;
      4'b0010: n228 = n225;
      4'b0001: n228 = 8'b00000000;
      default: n228 = n226;
    endcase
  /*# rtl/cpu68.vhd:174:16 */
  assign n230 = out_alu[15:8]; // extract
  /*# rtl/cpu68.vhd:167:16 */
  assign n231 = xreg[15:8]; // extract
  /*# rtl/cpu68.vhd:167:16 */
  assign n232 = xreg[15:8]; // extract
  /*# rtl/cpu68.vhd:436:33 */
  always @*
    case (n223)
      4'b1000: n233 = n232;
      4'b0100: n233 = data_in;
      4'b0010: n233 = n230;
      4'b0001: n233 = 8'b00000000;
      default: n233 = n231;
    endcase
  /*# rtl/cpu68.vhd:433:25 */
  assign n234 = {n233, n228};
  /*# rtl/cpu68.vhd:433:25 */
  assign n235 = hold ? xreg : n234;
  /*# rtl/cpu68.vhd:465:41 */
  assign n241 = sp_ctrl == 2'b00;
  /*# rtl/cpu68.vhd:467:41 */
  assign n243 = sp_ctrl == 2'b10;
  /*# rtl/cpu68.vhd:464:33 */
  assign n244 = {n243, n241};
  /*# rtl/cpu68.vhd:464:33 */
  always @*
    case (n244)
      2'b10: n246 = out_alu;
      2'b01: n246 = 16'b0000000000000000;
      default: n246 = sp;
    endcase
  /*# rtl/cpu68.vhd:461:25 */
  assign n247 = hold ? sp : n246;
  /*# rtl/cpu68.vhd:489:41 */
  assign n253 = md_ctrl == 3'b000;
  /*# rtl/cpu68.vhd:491:41 */
  assign n255 = md_ctrl == 3'b010;
  /*# rtl/cpu68.vhd:493:41 */
  assign n258 = md_ctrl == 3'b011;
  /*# rtl/cpu68.vhd:497:70 */
  assign n259 = md[7:0]; // extract
  /*# rtl/cpu68.vhd:496:41 */
  assign n261 = md_ctrl == 3'b100;
  /*# rtl/cpu68.vhd:500:70 */
  assign n262 = md[14:0]; // extract
  /*# rtl/cpu68.vhd:499:41 */
  assign n265 = md_ctrl == 3'b101;
  /*# rtl/cpu68.vhd:488:33 */
  assign n266 = {n265, n261, n258, n255, n253};
  /*# rtl/cpu68.vhd:174:16 */
  assign n268 = out_alu[0]; // extract
  /*# rtl/cpu68.vhd:82:8 */
  assign n269 = data_in[0]; // extract
  /*# rtl/cpu68.vhd:82:8 */
  assign n270 = data_in[0]; // extract
  /*# rtl/cpu68.vhd:171:16 */
  assign n271 = md[0]; // extract
  /*# rtl/cpu68.vhd:488:33 */
  always @*
    case (n266)
      5'b10000: n272 = 1'b0;
      5'b01000: n272 = n270;
      5'b00100: n272 = n269;
      5'b00010: n272 = n268;
      5'b00001: n272 = 1'b0;
      default: n272 = n271;
    endcase
  /*# rtl/cpu68.vhd:174:16 */
  assign n274 = out_alu[7:1]; // extract
  /*# rtl/cpu68.vhd:82:8 */
  assign n275 = data_in[7:1]; // extract
  /*# rtl/cpu68.vhd:82:8 */
  assign n276 = data_in[7:1]; // extract
  /*# rtl/cpu68.vhd:500:70 */
  assign n277 = n262[6:0]; // extract
  /*# rtl/cpu68.vhd:171:16 */
  assign n278 = md[7:1]; // extract
  /*# rtl/cpu68.vhd:488:33 */
  always @*
    case (n266)
      5'b10000: n279 = n277;
      5'b01000: n279 = n276;
      5'b00100: n279 = n275;
      5'b00010: n279 = n274;
      5'b00001: n279 = 7'b0000000;
      default: n279 = n278;
    endcase
  /*# rtl/cpu68.vhd:174:16 */
  assign n281 = out_alu[15:8]; // extract
  /*# rtl/cpu68.vhd:500:70 */
  assign n282 = n262[14:7]; // extract
  /*# rtl/cpu68.vhd:171:16 */
  assign n283 = md[15:8]; // extract
  /*# rtl/cpu68.vhd:488:33 */
  always @*
    case (n266)
      5'b10000: n284 = n282;
      5'b01000: n284 = n259;
      5'b00100: n284 = 8'b00000000;
      5'b00010: n284 = n281;
      5'b00001: n284 = 8'b00000000;
      default: n284 = n283;
    endcase
  /*# rtl/cpu68.vhd:485:25 */
  assign n285 = {n284, n279, n272};
  /*# rtl/cpu68.vhd:485:25 */
  assign n286 = hold ? md : n285;
  /*# rtl/cpu68.vhd:522:41 */
  assign n292 = cc_ctrl == 2'b00;
  /*# rtl/cpu68.vhd:524:41 */
  assign n294 = cc_ctrl == 2'b01;
  /*# rtl/cpu68.vhd:526:41 */
  assign n296 = cc_ctrl == 2'b10;
  /*# rtl/cpu68.vhd:521:33 */
  assign n297 = {n296, n294, n292};
  /*# rtl/cpu68.vhd:521:33 */
  always @*
    case (n297)
      3'b100: n299 = data_in;
      3'b010: n299 = cc_out;
      3'b001: n299 = 8'b11010000;
      default: n299 = cc;
    endcase
  /*# rtl/cpu68.vhd:518:25 */
  assign n300 = hold ? cc : n299;
  /*# rtl/cpu68.vhd:549:41 */
  assign n306 = iv_ctrl == 3'b000;
  /*# rtl/cpu68.vhd:551:41 */
  assign n308 = iv_ctrl == 3'b011;
  /*# rtl/cpu68.vhd:553:41 */
  assign n310 = iv_ctrl == 3'b010;
  /*# rtl/cpu68.vhd:555:41 */
  assign n312 = iv_ctrl == 3'b100;
  /*# rtl/cpu68.vhd:548:33 */
  assign n313 = {n312, n310, n308, n306};
  /*# rtl/cpu68.vhd:548:33 */
  always @*
    case (n313)
      4'b1000: n318 = 2'b00;
      4'b0100: n318 = 2'b01;
      4'b0010: n318 = 2'b10;
      4'b0001: n318 = 2'b11;
      default: n318 = iv;
    endcase
  /*# rtl/cpu68.vhd:545:25 */
  assign n319 = hold ? iv : n318;
  /*# rtl/cpu68.vhd:577:41 */
  assign n325 = op_ctrl == 2'b00;
  /*# rtl/cpu68.vhd:579:41 */
  assign n327 = op_ctrl == 2'b01;
  /*# rtl/cpu68.vhd:576:33 */
  assign n328 = {n327, n325};
  /*# rtl/cpu68.vhd:576:33 */
  always @*
    case (n328)
      2'b10: n330 = data_in;
      2'b01: n330 = 8'b00000001;
      default: n330 = op_code;
    endcase
  /*# rtl/cpu68.vhd:573:25 */
  assign n331 = hold ? op_code : n330;
  /*# rtl/cpu68.vhd:598:25 */
  assign n337 = left_ctrl == 3'b000;
  /*# rtl/cpu68.vhd:601:25 */
  assign n340 = left_ctrl == 3'b001;
  /*# rtl/cpu68.vhd:604:25 */
  assign n342 = left_ctrl == 3'b010;
  /*# rtl/cpu68.vhd:607:25 */
  assign n344 = left_ctrl == 3'b100;
  /*# rtl/cpu68.vhd:609:25 */
  assign n346 = left_ctrl == 3'b101;
  /*# rtl/cpu68.vhd:597:17 */
  assign n347 = {n346, n344, n342, n340, n337};
  /*# rtl/cpu68.vhd:167:16 */
  assign n348 = xreg[7:0]; // extract
  /*# rtl/cpu68.vhd:168:16 */
  assign n349 = sp[7:0]; // extract
  /*# rtl/cpu68.vhd:171:16 */
  assign n350 = md[7:0]; // extract
  /*# rtl/cpu68.vhd:597:17 */
  always @*
    case (n347)
      5'b10000: n351 = n349;
      5'b01000: n351 = n348;
      5'b00100: n351 = accb;
      5'b00010: n351 = accb;
      5'b00001: n351 = acca;
      default: n351 = n350;
    endcase
  /*# rtl/cpu68.vhd:167:16 */
  assign n352 = xreg[15:8]; // extract
  /*# rtl/cpu68.vhd:168:16 */
  assign n353 = sp[15:8]; // extract
  /*# rtl/cpu68.vhd:171:16 */
  assign n354 = md[15:8]; // extract
  /*# rtl/cpu68.vhd:597:17 */
  always @*
    case (n347)
      5'b10000: n355 = n353;
      5'b01000: n355 = n352;
      5'b00100: n355 = acca;
      5'b00010: n355 = 8'b00000000;
      5'b00001: n355 = 8'b00000000;
      default: n355 = n354;
    endcase
  /*# rtl/cpu68.vhd:625:25 */
  assign n359 = right_ctrl == 2'b01;
  /*# rtl/cpu68.vhd:627:25 */
  assign n361 = right_ctrl == 2'b10;
  /*# rtl/cpu68.vhd:630:53 */
  assign n363 = {8'b00000000, accb};
  /*# rtl/cpu68.vhd:629:25 */
  assign n365 = right_ctrl == 2'b11;
  /*# rtl/cpu68.vhd:624:17 */
  assign n366 = {n365, n361, n359};
  /*# rtl/cpu68.vhd:624:17 */
  always @*
    case (n366)
      3'b100: n369 = n363;
      3'b010: n369 = 16'b0000000000000001;
      3'b001: n369 = 16'b0000000000000000;
      default: n369 = md;
    endcase
  /*# rtl/cpu68.vhd:651:47 */
  assign n376 = cc[0]; // extract
  /*# rtl/cpu68.vhd:649:25 */
  assign n378 = alu_ctrl == 6'b000100;
  /*# rtl/cpu68.vhd:649:38 */
  assign n380 = alu_ctrl == 6'b000101;
  /*# rtl/cpu68.vhd:649:38 */
  assign n381 = n378 | n380;
  /*# rtl/cpu68.vhd:649:48 */
  assign n383 = alu_ctrl == 6'b010101;
  /*# rtl/cpu68.vhd:649:48 */
  assign n384 = n381 | n383;
  /*# rtl/cpu68.vhd:650:42 */
  assign n386 = alu_ctrl == 6'b010100;
  /*# rtl/cpu68.vhd:650:42 */
  assign n387 = n384 | n386;
  /*# rtl/cpu68.vhd:648:17 */
  always @*
    case (n387)
      1'b1: n389 = n376;
      default: n389 = 1'b0;
    endcase
  /*# rtl/cpu68.vhd:656:33 */
  assign n390 = left[3:0]; // extract
  /*# rtl/cpu68.vhd:656:46 */
  assign n391 = {28'b0, n390};  // uext
  /*# rtl/cpu68.vhd:656:46 */
  assign n393 = $unsigned(n391) <= $unsigned(32'b00000000000000000000000000001001);
  /*# rtl/cpu68.vhd:657:33 */
  assign n394 = left[7:4]; // extract
  /*# rtl/cpu68.vhd:657:46 */
  assign n395 = {28'b0, n394};  // uext
  /*# rtl/cpu68.vhd:657:46 */
  assign n397 = $unsigned(n395) <= $unsigned(32'b00000000000000000000000000001001);
  /*# rtl/cpu68.vhd:659:23 */
  assign n398 = cc[0]; // extract
  /*# rtl/cpu68.vhd:659:30 */
  assign n399 = ~n398;
  /*# rtl/cpu68.vhd:660:31 */
  assign n400 = cc[5]; // extract
  /*# rtl/cpu68.vhd:661:33 */
  assign n403 = n397 ? 8'b00000110 : 8'b01100110;
  /*# rtl/cpu68.vhd:668:41 */
  assign n406 = n397 ? 8'b00000000 : 8'b01100000;
  /*# rtl/cpu68.vhd:674:49 */
  assign n407 = left[7:4]; // extract
  /*# rtl/cpu68.vhd:674:62 */
  assign n408 = {28'b0, n407};  // uext
  /*# rtl/cpu68.vhd:674:62 */
  assign n410 = $unsigned(n408) <= $unsigned(32'b00000000000000000000000000001000);
  /*# rtl/cpu68.vhd:674:41 */
  assign n413 = n410 ? 8'b00000110 : 8'b01100110;
  /*# rtl/cpu68.vhd:667:33 */
  assign n414 = n393 ? n406 : n413;
  /*# rtl/cpu68.vhd:660:25 */
  assign n415 = n400 ? n403 : n414;
  /*# rtl/cpu68.vhd:682:31 */
  assign n416 = cc[5]; // extract
  /*# rtl/cpu68.vhd:685:33 */
  assign n419 = n393 ? 8'b01100000 : 8'b01100110;
  /*# rtl/cpu68.vhd:682:25 */
  assign n421 = n416 ? 8'b01100110 : n419;
  /*# rtl/cpu68.vhd:659:17 */
  assign n422 = n399 ? n415 : n421;
  /*# rtl/cpu68.vhd:697:49 */
  assign n423 = left + right;
  /*# rtl/cpu68.vhd:697:78 */
  assign n425 = {15'b000000000000000, n389};
  /*# rtl/cpu68.vhd:697:57 */
  assign n426 = n423 + n425;
  /*# rtl/cpu68.vhd:694:25 */
  assign n428 = alu_ctrl == 6'b000000;
  /*# rtl/cpu68.vhd:694:39 */
  assign n430 = alu_ctrl == 6'b001010;
  /*# rtl/cpu68.vhd:694:39 */
  assign n431 = n428 | n430;
  /*# rtl/cpu68.vhd:694:49 */
  assign n433 = alu_ctrl == 6'b000010;
  /*# rtl/cpu68.vhd:694:49 */
  assign n434 = n431 | n433;
  /*# rtl/cpu68.vhd:695:43 */
  assign n436 = alu_ctrl == 6'b001111;
  /*# rtl/cpu68.vhd:695:43 */
  assign n437 = n434 | n436;
  /*# rtl/cpu68.vhd:695:53 */
  assign n439 = alu_ctrl == 6'b000100;
  /*# rtl/cpu68.vhd:695:53 */
  assign n440 = n437 | n439;
  /*# rtl/cpu68.vhd:701:49 */
  assign n441 = left - right;
  /*# rtl/cpu68.vhd:701:78 */
  assign n443 = {15'b000000000000000, n389};
  /*# rtl/cpu68.vhd:701:57 */
  assign n444 = n441 - n443;
  /*# rtl/cpu68.vhd:698:25 */
  assign n446 = alu_ctrl == 6'b000001;
  /*# rtl/cpu68.vhd:698:39 */
  assign n448 = alu_ctrl == 6'b001011;
  /*# rtl/cpu68.vhd:698:39 */
  assign n449 = n446 | n448;
  /*# rtl/cpu68.vhd:698:49 */
  assign n451 = alu_ctrl == 6'b000011;
  /*# rtl/cpu68.vhd:698:49 */
  assign n452 = n449 | n451;
  /*# rtl/cpu68.vhd:699:43 */
  assign n454 = alu_ctrl == 6'b010000;
  /*# rtl/cpu68.vhd:699:43 */
  assign n455 = n452 | n454;
  /*# rtl/cpu68.vhd:699:53 */
  assign n457 = alu_ctrl == 6'b000101;
  /*# rtl/cpu68.vhd:699:53 */
  assign n458 = n455 | n457;
  /*# rtl/cpu68.vhd:700:41 */
  assign n460 = alu_ctrl == 6'b010001;
  /*# rtl/cpu68.vhd:700:41 */
  assign n461 = n458 | n460;
  /*# rtl/cpu68.vhd:703:49 */
  assign n462 = left & right;
  /*# rtl/cpu68.vhd:702:25 */
  assign n464 = alu_ctrl == 6'b000110;
  /*# rtl/cpu68.vhd:705:49 */
  assign n465 = left | right;
  /*# rtl/cpu68.vhd:704:25 */
  assign n467 = alu_ctrl == 6'b000111;
  /*# rtl/cpu68.vhd:707:49 */
  assign n468 = left ^ right;
  /*# rtl/cpu68.vhd:706:25 */
  assign n470 = alu_ctrl == 6'b001000;
  /*# rtl/cpu68.vhd:709:48 */
  assign n471 = left[14:0]; // extract
  /*# rtl/cpu68.vhd:709:62 */
  assign n472 = {n471, n389};
  /*# rtl/cpu68.vhd:708:25 */
  assign n474 = alu_ctrl == 6'b010011;
  /*# rtl/cpu68.vhd:708:40 */
  assign n476 = alu_ctrl == 6'b010111;
  /*# rtl/cpu68.vhd:708:40 */
  assign n477 = n474 | n476;
  /*# rtl/cpu68.vhd:708:51 */
  assign n479 = alu_ctrl == 6'b010101;
  /*# rtl/cpu68.vhd:708:51 */
  assign n480 = n477 | n479;
  /*# rtl/cpu68.vhd:711:59 */
  assign n481 = left[15:1]; // extract
  /*# rtl/cpu68.vhd:711:53 */
  assign n482 = {n389, n481};
  /*# rtl/cpu68.vhd:710:25 */
  assign n484 = alu_ctrl == 6'b010010;
  /*# rtl/cpu68.vhd:710:40 */
  assign n486 = alu_ctrl == 6'b011000;
  /*# rtl/cpu68.vhd:710:40 */
  assign n487 = n484 | n486;
  /*# rtl/cpu68.vhd:713:55 */
  assign n489 = {8'b00000000, n389};
  /*# rtl/cpu68.vhd:713:72 */
  assign n490 = left[7:1]; // extract
  /*# rtl/cpu68.vhd:713:66 */
  assign n491 = {n489, n490};
  /*# rtl/cpu68.vhd:712:25 */
  assign n493 = alu_ctrl == 6'b010100;
  /*# rtl/cpu68.vhd:715:61 */
  assign n494 = left[7]; // extract
  /*# rtl/cpu68.vhd:715:55 */
  assign n496 = {8'b00000000, n494};
  /*# rtl/cpu68.vhd:715:71 */
  assign n497 = left[7:1]; // extract
  /*# rtl/cpu68.vhd:715:65 */
  assign n498 = {n496, n497};
  /*# rtl/cpu68.vhd:714:25 */
  assign n500 = alu_ctrl == 6'b010110;
  /*# rtl/cpu68.vhd:717:50 */
  assign n501 = right - left;
  /*# rtl/cpu68.vhd:716:25 */
  assign n503 = alu_ctrl == 6'b001101;
  /*# rtl/cpu68.vhd:719:44 */
  assign n504 = ~left;
  /*# rtl/cpu68.vhd:718:25 */
  assign n506 = alu_ctrl == 6'b001110;
  /*# rtl/cpu68.vhd:720:25 */
  assign n508 = alu_ctrl == 6'b001100;
  /*# rtl/cpu68.vhd:720:38 */
  assign n510 = alu_ctrl == 6'b100001;
  /*# rtl/cpu68.vhd:720:38 */
  assign n511 = n508 | n510;
  /*# rtl/cpu68.vhd:720:48 */
  assign n513 = alu_ctrl == 6'b100011;
  /*# rtl/cpu68.vhd:720:48 */
  assign n514 = n511 | n513;
  /*# rtl/cpu68.vhd:722:25 */
  assign n516 = alu_ctrl == 6'b100010;
  /*# rtl/cpu68.vhd:722:38 */
  assign n518 = alu_ctrl == 6'b100100;
  /*# rtl/cpu68.vhd:722:38 */
  assign n519 = n516 | n518;
  /*# rtl/cpu68.vhd:725:63 */
  assign n521 = {8'b00000000, n422};
  /*# rtl/cpu68.vhd:725:49 */
  assign n522 = left + n521;
  /*# rtl/cpu68.vhd:724:25 */
  assign n524 = alu_ctrl == 6'b100110;
  /*# rtl/cpu68.vhd:727:55 */
  assign n526 = {8'b00000000, cc};
  /*# rtl/cpu68.vhd:726:25 */
  assign n528 = alu_ctrl == 6'b011111;
  /*# rtl/cpu68.vhd:693:17 */
  assign n529 = {n528, n524, n519, n514, n506, n503, n500, n493, n487, n480, n470, n467, n464, n461, n440};
  /*# rtl/cpu68.vhd:693:17 */
  always @*
    case (n529)
      15'b100000000000000: n530 = n526;
      15'b010000000000000: n530 = n522;
      15'b001000000000000: n530 = left;
      15'b000100000000000: n530 = right;
      15'b000010000000000: n530 = n504;
      15'b000001000000000: n530 = n501;
      15'b000000100000000: n530 = n498;
      15'b000000010000000: n530 = n491;
      15'b000000001000000: n530 = n482;
      15'b000000000100000: n530 = n472;
      15'b000000000010000: n530 = n468;
      15'b000000000001000: n530 = n465;
      15'b000000000000100: n530 = n462;
      15'b000000000000010: n530 = n444;
      15'b000000000000001: n530 = n426;
      default: n530 = left;
    endcase
  /*# rtl/cpu68.vhd:737:54 */
  assign n531 = left[7]; // extract
  /*# rtl/cpu68.vhd:737:67 */
  assign n532 = right[7]; // extract
  /*# rtl/cpu68.vhd:737:58 */
  assign n533 = n531 & n532;
  /*# rtl/cpu68.vhd:738:46 */
  assign n534 = left[7]; // extract
  /*# rtl/cpu68.vhd:738:65 */
  assign n535 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:738:54 */
  assign n536 = ~n535;
  /*# rtl/cpu68.vhd:738:50 */
  assign n537 = n534 & n536;
  /*# rtl/cpu68.vhd:737:72 */
  assign n538 = n533 | n537;
  /*# rtl/cpu68.vhd:739:47 */
  assign n539 = right[7]; // extract
  /*# rtl/cpu68.vhd:739:66 */
  assign n540 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:739:55 */
  assign n541 = ~n540;
  /*# rtl/cpu68.vhd:739:51 */
  assign n542 = n539 & n541;
  /*# rtl/cpu68.vhd:738:70 */
  assign n543 = n538 | n542;
  /*# rtl/cpu68.vhd:736:25 */
  assign n545 = alu_ctrl == 6'b000000;
  /*# rtl/cpu68.vhd:736:39 */
  assign n547 = alu_ctrl == 6'b000100;
  /*# rtl/cpu68.vhd:736:39 */
  assign n548 = n545 | n547;
  /*# rtl/cpu68.vhd:741:59 */
  assign n549 = left[7]; // extract
  /*# rtl/cpu68.vhd:741:51 */
  assign n550 = ~n549;
  /*# rtl/cpu68.vhd:741:73 */
  assign n551 = right[7]; // extract
  /*# rtl/cpu68.vhd:741:64 */
  assign n552 = n550 & n551;
  /*# rtl/cpu68.vhd:742:51 */
  assign n553 = left[7]; // extract
  /*# rtl/cpu68.vhd:742:43 */
  assign n554 = ~n553;
  /*# rtl/cpu68.vhd:742:67 */
  assign n555 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:742:56 */
  assign n556 = n554 & n555;
  /*# rtl/cpu68.vhd:741:78 */
  assign n557 = n552 | n556;
  /*# rtl/cpu68.vhd:743:47 */
  assign n558 = right[7]; // extract
  /*# rtl/cpu68.vhd:743:62 */
  assign n559 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:743:51 */
  assign n560 = n558 & n559;
  /*# rtl/cpu68.vhd:742:72 */
  assign n561 = n557 | n560;
  /*# rtl/cpu68.vhd:740:25 */
  assign n563 = alu_ctrl == 6'b000001;
  /*# rtl/cpu68.vhd:740:39 */
  assign n565 = alu_ctrl == 6'b000101;
  /*# rtl/cpu68.vhd:740:39 */
  assign n566 = n563 | n565;
  /*# rtl/cpu68.vhd:745:54 */
  assign n567 = left[15]; // extract
  /*# rtl/cpu68.vhd:745:68 */
  assign n568 = right[15]; // extract
  /*# rtl/cpu68.vhd:745:59 */
  assign n569 = n567 & n568;
  /*# rtl/cpu68.vhd:746:46 */
  assign n570 = left[15]; // extract
  /*# rtl/cpu68.vhd:746:66 */
  assign n571 = out_alu[15]; // extract
  /*# rtl/cpu68.vhd:746:55 */
  assign n572 = ~n571;
  /*# rtl/cpu68.vhd:746:51 */
  assign n573 = n570 & n572;
  /*# rtl/cpu68.vhd:745:74 */
  assign n574 = n569 | n573;
  /*# rtl/cpu68.vhd:747:47 */
  assign n575 = right[15]; // extract
  /*# rtl/cpu68.vhd:747:67 */
  assign n576 = out_alu[15]; // extract
  /*# rtl/cpu68.vhd:747:56 */
  assign n577 = ~n576;
  /*# rtl/cpu68.vhd:747:52 */
  assign n578 = n575 & n577;
  /*# rtl/cpu68.vhd:746:72 */
  assign n579 = n574 | n578;
  /*# rtl/cpu68.vhd:744:25 */
  assign n581 = alu_ctrl == 6'b000010;
  /*# rtl/cpu68.vhd:749:59 */
  assign n582 = left[15]; // extract
  /*# rtl/cpu68.vhd:749:51 */
  assign n583 = ~n582;
  /*# rtl/cpu68.vhd:749:74 */
  assign n584 = right[15]; // extract
  /*# rtl/cpu68.vhd:749:65 */
  assign n585 = n583 & n584;
  /*# rtl/cpu68.vhd:750:51 */
  assign n586 = left[15]; // extract
  /*# rtl/cpu68.vhd:750:43 */
  assign n587 = ~n586;
  /*# rtl/cpu68.vhd:750:68 */
  assign n588 = out_alu[15]; // extract
  /*# rtl/cpu68.vhd:750:57 */
  assign n589 = n587 & n588;
  /*# rtl/cpu68.vhd:749:80 */
  assign n590 = n585 | n589;
  /*# rtl/cpu68.vhd:751:47 */
  assign n591 = right[15]; // extract
  /*# rtl/cpu68.vhd:751:63 */
  assign n592 = out_alu[15]; // extract
  /*# rtl/cpu68.vhd:751:52 */
  assign n593 = n591 & n592;
  /*# rtl/cpu68.vhd:750:74 */
  assign n594 = n590 | n593;
  /*# rtl/cpu68.vhd:748:25 */
  assign n596 = alu_ctrl == 6'b000011;
  /*# rtl/cpu68.vhd:753:53 */
  assign n597 = left[0]; // extract
  /*# rtl/cpu68.vhd:752:25 */
  assign n599 = alu_ctrl == 6'b010100;
  /*# rtl/cpu68.vhd:752:39 */
  assign n601 = alu_ctrl == 6'b010010;
  /*# rtl/cpu68.vhd:752:39 */
  assign n602 = n599 | n601;
  /*# rtl/cpu68.vhd:752:51 */
  assign n604 = alu_ctrl == 6'b011000;
  /*# rtl/cpu68.vhd:752:51 */
  assign n605 = n602 | n604;
  /*# rtl/cpu68.vhd:752:62 */
  assign n607 = alu_ctrl == 6'b010110;
  /*# rtl/cpu68.vhd:752:62 */
  assign n608 = n605 | n607;
  /*# rtl/cpu68.vhd:755:53 */
  assign n609 = left[7]; // extract
  /*# rtl/cpu68.vhd:754:25 */
  assign n611 = alu_ctrl == 6'b010101;
  /*# rtl/cpu68.vhd:754:39 */
  assign n613 = alu_ctrl == 6'b010111;
  /*# rtl/cpu68.vhd:754:39 */
  assign n614 = n611 | n613;
  /*# rtl/cpu68.vhd:757:53 */
  assign n615 = left[15]; // extract
  /*# rtl/cpu68.vhd:756:25 */
  assign n617 = alu_ctrl == 6'b010011;
  /*# rtl/cpu68.vhd:758:25 */
  assign n620 = alu_ctrl == 6'b001110;
  /*# rtl/cpu68.vhd:761:56 */
  assign n621 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:761:70 */
  assign n622 = out_alu[6]; // extract
  /*# rtl/cpu68.vhd:761:60 */
  assign n623 = n621 | n622;
  /*# rtl/cpu68.vhd:761:84 */
  assign n624 = out_alu[5]; // extract
  /*# rtl/cpu68.vhd:761:74 */
  assign n625 = n623 | n624;
  /*# rtl/cpu68.vhd:761:98 */
  assign n626 = out_alu[4]; // extract
  /*# rtl/cpu68.vhd:761:88 */
  assign n627 = n625 | n626;
  /*# rtl/cpu68.vhd:762:48 */
  assign n628 = out_alu[3]; // extract
  /*# rtl/cpu68.vhd:761:102 */
  assign n629 = n627 | n628;
  /*# rtl/cpu68.vhd:762:62 */
  assign n630 = out_alu[2]; // extract
  /*# rtl/cpu68.vhd:762:52 */
  assign n631 = n629 | n630;
  /*# rtl/cpu68.vhd:762:76 */
  assign n632 = out_alu[1]; // extract
  /*# rtl/cpu68.vhd:762:66 */
  assign n633 = n631 | n632;
  /*# rtl/cpu68.vhd:762:90 */
  assign n634 = out_alu[0]; // extract
  /*# rtl/cpu68.vhd:762:80 */
  assign n635 = n633 | n634;
  /*# rtl/cpu68.vhd:760:25 */
  assign n637 = alu_ctrl == 6'b001101;
  /*# rtl/cpu68.vhd:760:38 */
  assign n639 = alu_ctrl == 6'b001100;
  /*# rtl/cpu68.vhd:760:38 */
  assign n640 = n637 | n639;
  /*# rtl/cpu68.vhd:764:44 */
  assign n641 = n422[7:4]; // extract
  /*# rtl/cpu68.vhd:764:57 */
  assign n643 = n641 == 4'b0110;
  /*# rtl/cpu68.vhd:764:33 */
  assign n646 = n643 ? 1'b1 : 1'b0;
  /*# rtl/cpu68.vhd:763:25 */
  assign n648 = alu_ctrl == 6'b100110;
  /*# rtl/cpu68.vhd:769:25 */
  assign n651 = alu_ctrl == 6'b011011;
  /*# rtl/cpu68.vhd:771:25 */
  assign n654 = alu_ctrl == 6'b011100;
  /*# rtl/cpu68.vhd:774:53 */
  assign n655 = left[0]; // extract
  /*# rtl/cpu68.vhd:773:25 */
  assign n657 = alu_ctrl == 6'b100000;
  /*# rtl/cpu68.vhd:776:51 */
  assign n658 = cc[0]; // extract
  /*# rtl/cpu68.vhd:735:17 */
  assign n659 = {n657, n654, n651, n648, n640, n620, n617, n614, n608, n596, n581, n566, n548};
  /*# rtl/cpu68.vhd:735:17 */
  always @*
    case (n659)
      13'b1000000000000: n660 = n655;
      13'b0100000000000: n660 = 1'b0;
      13'b0010000000000: n660 = 1'b1;
      13'b0001000000000: n660 = n646;
      13'b0000100000000: n660 = n635;
      13'b0000010000000: n660 = 1'b1;
      13'b0000001000000: n660 = n615;
      13'b0000000100000: n660 = n609;
      13'b0000000010000: n660 = n597;
      13'b0000000001000: n660 = n594;
      13'b0000000000100: n660 = n579;
      13'b0000000000010: n660 = n561;
      13'b0000000000001: n660 = n543;
      default: n660 = n658;
    endcase
  /*# rtl/cpu68.vhd:789:60 */
  assign n661 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:789:74 */
  assign n662 = out_alu[6]; // extract
  /*# rtl/cpu68.vhd:789:64 */
  assign n663 = n661 | n662;
  /*# rtl/cpu68.vhd:789:88 */
  assign n664 = out_alu[5]; // extract
  /*# rtl/cpu68.vhd:789:78 */
  assign n665 = n663 | n664;
  /*# rtl/cpu68.vhd:789:102 */
  assign n666 = out_alu[4]; // extract
  /*# rtl/cpu68.vhd:789:92 */
  assign n667 = n665 | n666;
  /*# rtl/cpu68.vhd:790:48 */
  assign n668 = out_alu[3]; // extract
  /*# rtl/cpu68.vhd:789:106 */
  assign n669 = n667 | n668;
  /*# rtl/cpu68.vhd:790:62 */
  assign n670 = out_alu[2]; // extract
  /*# rtl/cpu68.vhd:790:52 */
  assign n671 = n669 | n670;
  /*# rtl/cpu68.vhd:790:76 */
  assign n672 = out_alu[1]; // extract
  /*# rtl/cpu68.vhd:790:66 */
  assign n673 = n671 | n672;
  /*# rtl/cpu68.vhd:790:90 */
  assign n674 = out_alu[0]; // extract
  /*# rtl/cpu68.vhd:790:80 */
  assign n675 = n673 | n674;
  /*# rtl/cpu68.vhd:789:49 */
  assign n676 = ~n675;
  /*# rtl/cpu68.vhd:782:25 */
  assign n678 = alu_ctrl == 6'b000000;
  /*# rtl/cpu68.vhd:782:39 */
  assign n680 = alu_ctrl == 6'b000001;
  /*# rtl/cpu68.vhd:782:39 */
  assign n681 = n678 | n680;
  /*# rtl/cpu68.vhd:782:50 */
  assign n683 = alu_ctrl == 6'b000100;
  /*# rtl/cpu68.vhd:782:50 */
  assign n684 = n681 | n683;
  /*# rtl/cpu68.vhd:783:41 */
  assign n686 = alu_ctrl == 6'b000101;
  /*# rtl/cpu68.vhd:783:41 */
  assign n687 = n684 | n686;
  /*# rtl/cpu68.vhd:783:51 */
  assign n689 = alu_ctrl == 6'b000110;
  /*# rtl/cpu68.vhd:783:51 */
  assign n690 = n687 | n689;
  /*# rtl/cpu68.vhd:784:41 */
  assign n692 = alu_ctrl == 6'b000111;
  /*# rtl/cpu68.vhd:784:41 */
  assign n693 = n690 | n692;
  /*# rtl/cpu68.vhd:784:51 */
  assign n695 = alu_ctrl == 6'b001000;
  /*# rtl/cpu68.vhd:784:51 */
  assign n696 = n693 | n695;
  /*# rtl/cpu68.vhd:784:61 */
  assign n698 = alu_ctrl == 6'b001010;
  /*# rtl/cpu68.vhd:784:61 */
  assign n699 = n696 | n698;
  /*# rtl/cpu68.vhd:785:41 */
  assign n701 = alu_ctrl == 6'b001011;
  /*# rtl/cpu68.vhd:785:41 */
  assign n702 = n699 | n701;
  /*# rtl/cpu68.vhd:785:51 */
  assign n704 = alu_ctrl == 6'b001101;
  /*# rtl/cpu68.vhd:785:51 */
  assign n705 = n702 | n704;
  /*# rtl/cpu68.vhd:786:41 */
  assign n707 = alu_ctrl == 6'b001110;
  /*# rtl/cpu68.vhd:786:41 */
  assign n708 = n705 | n707;
  /*# rtl/cpu68.vhd:786:51 */
  assign n710 = alu_ctrl == 6'b001100;
  /*# rtl/cpu68.vhd:786:51 */
  assign n711 = n708 | n710;
  /*# rtl/cpu68.vhd:786:61 */
  assign n713 = alu_ctrl == 6'b010101;
  /*# rtl/cpu68.vhd:786:61 */
  assign n714 = n711 | n713;
  /*# rtl/cpu68.vhd:787:42 */
  assign n716 = alu_ctrl == 6'b010100;
  /*# rtl/cpu68.vhd:787:42 */
  assign n717 = n714 | n716;
  /*# rtl/cpu68.vhd:787:53 */
  assign n719 = alu_ctrl == 6'b010110;
  /*# rtl/cpu68.vhd:787:53 */
  assign n720 = n717 | n719;
  /*# rtl/cpu68.vhd:787:64 */
  assign n722 = alu_ctrl == 6'b010111;
  /*# rtl/cpu68.vhd:787:64 */
  assign n723 = n720 | n722;
  /*# rtl/cpu68.vhd:787:75 */
  assign n725 = alu_ctrl == 6'b011000;
  /*# rtl/cpu68.vhd:787:75 */
  assign n726 = n723 | n725;
  /*# rtl/cpu68.vhd:787:86 */
  assign n728 = alu_ctrl == 6'b100001;
  /*# rtl/cpu68.vhd:787:86 */
  assign n729 = n726 | n728;
  /*# rtl/cpu68.vhd:788:41 */
  assign n731 = alu_ctrl == 6'b100010;
  /*# rtl/cpu68.vhd:788:41 */
  assign n732 = n729 | n731;
  /*# rtl/cpu68.vhd:795:60 */
  assign n733 = out_alu[15]; // extract
  /*# rtl/cpu68.vhd:795:75 */
  assign n734 = out_alu[14]; // extract
  /*# rtl/cpu68.vhd:795:65 */
  assign n735 = n733 | n734;
  /*# rtl/cpu68.vhd:795:90 */
  assign n736 = out_alu[13]; // extract
  /*# rtl/cpu68.vhd:795:80 */
  assign n737 = n735 | n736;
  /*# rtl/cpu68.vhd:795:105 */
  assign n738 = out_alu[12]; // extract
  /*# rtl/cpu68.vhd:795:95 */
  assign n739 = n737 | n738;
  /*# rtl/cpu68.vhd:796:48 */
  assign n740 = out_alu[11]; // extract
  /*# rtl/cpu68.vhd:795:110 */
  assign n741 = n739 | n740;
  /*# rtl/cpu68.vhd:796:63 */
  assign n742 = out_alu[10]; // extract
  /*# rtl/cpu68.vhd:796:53 */
  assign n743 = n741 | n742;
  /*# rtl/cpu68.vhd:796:78 */
  assign n744 = out_alu[9]; // extract
  /*# rtl/cpu68.vhd:796:68 */
  assign n745 = n743 | n744;
  /*# rtl/cpu68.vhd:796:92 */
  assign n746 = out_alu[8]; // extract
  /*# rtl/cpu68.vhd:796:82 */
  assign n747 = n745 | n746;
  /*# rtl/cpu68.vhd:797:48 */
  assign n748 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:796:96 */
  assign n749 = n747 | n748;
  /*# rtl/cpu68.vhd:797:62 */
  assign n750 = out_alu[6]; // extract
  /*# rtl/cpu68.vhd:797:52 */
  assign n751 = n749 | n750;
  /*# rtl/cpu68.vhd:797:76 */
  assign n752 = out_alu[5]; // extract
  /*# rtl/cpu68.vhd:797:66 */
  assign n753 = n751 | n752;
  /*# rtl/cpu68.vhd:797:90 */
  assign n754 = out_alu[4]; // extract
  /*# rtl/cpu68.vhd:797:80 */
  assign n755 = n753 | n754;
  /*# rtl/cpu68.vhd:798:48 */
  assign n756 = out_alu[3]; // extract
  /*# rtl/cpu68.vhd:797:94 */
  assign n757 = n755 | n756;
  /*# rtl/cpu68.vhd:798:62 */
  assign n758 = out_alu[2]; // extract
  /*# rtl/cpu68.vhd:798:52 */
  assign n759 = n757 | n758;
  /*# rtl/cpu68.vhd:798:76 */
  assign n760 = out_alu[1]; // extract
  /*# rtl/cpu68.vhd:798:66 */
  assign n761 = n759 | n760;
  /*# rtl/cpu68.vhd:798:90 */
  assign n762 = out_alu[0]; // extract
  /*# rtl/cpu68.vhd:798:80 */
  assign n763 = n761 | n762;
  /*# rtl/cpu68.vhd:795:49 */
  assign n764 = ~n763;
  /*# rtl/cpu68.vhd:791:25 */
  assign n766 = alu_ctrl == 6'b000010;
  /*# rtl/cpu68.vhd:791:40 */
  assign n768 = alu_ctrl == 6'b000011;
  /*# rtl/cpu68.vhd:791:40 */
  assign n769 = n766 | n768;
  /*# rtl/cpu68.vhd:791:52 */
  assign n771 = alu_ctrl == 6'b010011;
  /*# rtl/cpu68.vhd:791:52 */
  assign n772 = n769 | n771;
  /*# rtl/cpu68.vhd:792:43 */
  assign n774 = alu_ctrl == 6'b010010;
  /*# rtl/cpu68.vhd:792:43 */
  assign n775 = n772 | n774;
  /*# rtl/cpu68.vhd:792:55 */
  assign n777 = alu_ctrl == 6'b001111;
  /*# rtl/cpu68.vhd:792:55 */
  assign n778 = n775 | n777;
  /*# rtl/cpu68.vhd:793:41 */
  assign n780 = alu_ctrl == 6'b010000;
  /*# rtl/cpu68.vhd:793:41 */
  assign n781 = n778 | n780;
  /*# rtl/cpu68.vhd:793:51 */
  assign n783 = alu_ctrl == 6'b100011;
  /*# rtl/cpu68.vhd:793:51 */
  assign n784 = n781 | n783;
  /*# rtl/cpu68.vhd:794:42 */
  assign n786 = alu_ctrl == 6'b100100;
  /*# rtl/cpu68.vhd:794:42 */
  assign n787 = n784 | n786;
  /*# rtl/cpu68.vhd:794:53 */
  assign n789 = alu_ctrl == 6'b010001;
  /*# rtl/cpu68.vhd:794:53 */
  assign n790 = n787 | n789;
  /*# rtl/cpu68.vhd:800:53 */
  assign n791 = left[2]; // extract
  /*# rtl/cpu68.vhd:799:25 */
  assign n793 = alu_ctrl == 6'b100000;
  /*# rtl/cpu68.vhd:802:51 */
  assign n794 = cc[2]; // extract
  /*# rtl/cpu68.vhd:781:17 */
  assign n795 = {n793, n790, n732};
  /*# rtl/cpu68.vhd:781:17 */
  always @*
    case (n795)
      3'b100: n796 = n791;
      3'b010: n796 = n764;
      3'b001: n796 = n676;
      default: n796 = n794;
    endcase
  /*# rtl/cpu68.vhd:815:56 */
  assign n797 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:809:25 */
  assign n799 = alu_ctrl == 6'b000000;
  /*# rtl/cpu68.vhd:809:39 */
  assign n801 = alu_ctrl == 6'b000001;
  /*# rtl/cpu68.vhd:809:39 */
  assign n802 = n799 | n801;
  /*# rtl/cpu68.vhd:809:50 */
  assign n804 = alu_ctrl == 6'b000100;
  /*# rtl/cpu68.vhd:809:50 */
  assign n805 = n802 | n804;
  /*# rtl/cpu68.vhd:810:41 */
  assign n807 = alu_ctrl == 6'b000101;
  /*# rtl/cpu68.vhd:810:41 */
  assign n808 = n805 | n807;
  /*# rtl/cpu68.vhd:810:51 */
  assign n810 = alu_ctrl == 6'b000110;
  /*# rtl/cpu68.vhd:810:51 */
  assign n811 = n808 | n810;
  /*# rtl/cpu68.vhd:811:41 */
  assign n813 = alu_ctrl == 6'b000111;
  /*# rtl/cpu68.vhd:811:41 */
  assign n814 = n811 | n813;
  /*# rtl/cpu68.vhd:811:51 */
  assign n816 = alu_ctrl == 6'b001000;
  /*# rtl/cpu68.vhd:811:51 */
  assign n817 = n814 | n816;
  /*# rtl/cpu68.vhd:811:61 */
  assign n819 = alu_ctrl == 6'b010101;
  /*# rtl/cpu68.vhd:811:61 */
  assign n820 = n817 | n819;
  /*# rtl/cpu68.vhd:812:42 */
  assign n822 = alu_ctrl == 6'b010100;
  /*# rtl/cpu68.vhd:812:42 */
  assign n823 = n820 | n822;
  /*# rtl/cpu68.vhd:812:53 */
  assign n825 = alu_ctrl == 6'b010110;
  /*# rtl/cpu68.vhd:812:53 */
  assign n826 = n823 | n825;
  /*# rtl/cpu68.vhd:812:64 */
  assign n828 = alu_ctrl == 6'b010111;
  /*# rtl/cpu68.vhd:812:64 */
  assign n829 = n826 | n828;
  /*# rtl/cpu68.vhd:812:75 */
  assign n831 = alu_ctrl == 6'b011000;
  /*# rtl/cpu68.vhd:812:75 */
  assign n832 = n829 | n831;
  /*# rtl/cpu68.vhd:812:86 */
  assign n834 = alu_ctrl == 6'b001010;
  /*# rtl/cpu68.vhd:812:86 */
  assign n835 = n832 | n834;
  /*# rtl/cpu68.vhd:813:41 */
  assign n837 = alu_ctrl == 6'b001011;
  /*# rtl/cpu68.vhd:813:41 */
  assign n838 = n835 | n837;
  /*# rtl/cpu68.vhd:813:51 */
  assign n840 = alu_ctrl == 6'b001101;
  /*# rtl/cpu68.vhd:813:51 */
  assign n841 = n838 | n840;
  /*# rtl/cpu68.vhd:813:61 */
  assign n843 = alu_ctrl == 6'b001110;
  /*# rtl/cpu68.vhd:813:61 */
  assign n844 = n841 | n843;
  /*# rtl/cpu68.vhd:813:71 */
  assign n846 = alu_ctrl == 6'b001100;
  /*# rtl/cpu68.vhd:813:71 */
  assign n847 = n844 | n846;
  /*# rtl/cpu68.vhd:813:81 */
  assign n849 = alu_ctrl == 6'b100001;
  /*# rtl/cpu68.vhd:813:81 */
  assign n850 = n847 | n849;
  /*# rtl/cpu68.vhd:814:41 */
  assign n852 = alu_ctrl == 6'b100010;
  /*# rtl/cpu68.vhd:814:41 */
  assign n853 = n850 | n852;
  /*# rtl/cpu68.vhd:819:56 */
  assign n854 = out_alu[15]; // extract
  /*# rtl/cpu68.vhd:816:25 */
  assign n856 = alu_ctrl == 6'b000010;
  /*# rtl/cpu68.vhd:816:40 */
  assign n858 = alu_ctrl == 6'b000011;
  /*# rtl/cpu68.vhd:816:40 */
  assign n859 = n856 | n858;
  /*# rtl/cpu68.vhd:816:52 */
  assign n861 = alu_ctrl == 6'b010011;
  /*# rtl/cpu68.vhd:816:52 */
  assign n862 = n859 | n861;
  /*# rtl/cpu68.vhd:817:43 */
  assign n864 = alu_ctrl == 6'b010010;
  /*# rtl/cpu68.vhd:817:43 */
  assign n865 = n862 | n864;
  /*# rtl/cpu68.vhd:817:55 */
  assign n867 = alu_ctrl == 6'b100011;
  /*# rtl/cpu68.vhd:817:55 */
  assign n868 = n865 | n867;
  /*# rtl/cpu68.vhd:818:42 */
  assign n870 = alu_ctrl == 6'b100100;
  /*# rtl/cpu68.vhd:818:42 */
  assign n871 = n868 | n870;
  /*# rtl/cpu68.vhd:818:53 */
  assign n873 = alu_ctrl == 6'b010001;
  /*# rtl/cpu68.vhd:818:53 */
  assign n874 = n871 | n873;
  /*# rtl/cpu68.vhd:821:53 */
  assign n875 = left[3]; // extract
  /*# rtl/cpu68.vhd:820:25 */
  assign n877 = alu_ctrl == 6'b100000;
  /*# rtl/cpu68.vhd:823:51 */
  assign n878 = cc[3]; // extract
  /*# rtl/cpu68.vhd:808:17 */
  assign n879 = {n877, n874, n853};
  /*# rtl/cpu68.vhd:808:17 */
  always @*
    case (n879)
      3'b100: n880 = n875;
      3'b010: n880 = n854;
      3'b001: n880 = n797;
      default: n880 = n878;
    endcase
  /*# rtl/cpu68.vhd:830:25 */
  assign n883 = alu_ctrl == 6'b011001;
  /*# rtl/cpu68.vhd:832:25 */
  assign n886 = alu_ctrl == 6'b011010;
  /*# rtl/cpu68.vhd:835:53 */
  assign n887 = left[4]; // extract
  /*# rtl/cpu68.vhd:834:25 */
  assign n889 = alu_ctrl == 6'b100000;
  /*# rtl/cpu68.vhd:837:51 */
  assign n890 = cc[4]; // extract
  /*# rtl/cpu68.vhd:829:17 */
  assign n891 = {n889, n886, n883};
  /*# rtl/cpu68.vhd:829:17 */
  always @*
    case (n891)
      3'b100: n892 = n887;
      3'b010: n892 = 1'b0;
      3'b001: n892 = 1'b1;
      default: n892 = n890;
    endcase
  /*# rtl/cpu68.vhd:845:54 */
  assign n893 = left[3]; // extract
  /*# rtl/cpu68.vhd:845:67 */
  assign n894 = right[3]; // extract
  /*# rtl/cpu68.vhd:845:58 */
  assign n895 = n893 & n894;
  /*# rtl/cpu68.vhd:846:47 */
  assign n896 = right[3]; // extract
  /*# rtl/cpu68.vhd:846:66 */
  assign n897 = out_alu[3]; // extract
  /*# rtl/cpu68.vhd:846:55 */
  assign n898 = ~n897;
  /*# rtl/cpu68.vhd:846:51 */
  assign n899 = n896 & n898;
  /*# rtl/cpu68.vhd:845:72 */
  assign n900 = n895 | n899;
  /*# rtl/cpu68.vhd:847:46 */
  assign n901 = left[3]; // extract
  /*# rtl/cpu68.vhd:847:65 */
  assign n902 = out_alu[3]; // extract
  /*# rtl/cpu68.vhd:847:54 */
  assign n903 = ~n902;
  /*# rtl/cpu68.vhd:847:50 */
  assign n904 = n901 & n903;
  /*# rtl/cpu68.vhd:846:71 */
  assign n905 = n900 | n904;
  /*# rtl/cpu68.vhd:844:25 */
  assign n907 = alu_ctrl == 6'b000000;
  /*# rtl/cpu68.vhd:844:39 */
  assign n909 = alu_ctrl == 6'b000100;
  /*# rtl/cpu68.vhd:844:39 */
  assign n910 = n907 | n909;
  /*# rtl/cpu68.vhd:849:53 */
  assign n911 = left[5]; // extract
  /*# rtl/cpu68.vhd:848:25 */
  assign n913 = alu_ctrl == 6'b100000;
  /*# rtl/cpu68.vhd:851:51 */
  assign n914 = cc[5]; // extract
  /*# rtl/cpu68.vhd:843:17 */
  assign n915 = {n913, n910};
  /*# rtl/cpu68.vhd:843:17 */
  always @*
    case (n915)
      2'b10: n916 = n911;
      2'b01: n916 = n905;
      default: n916 = n914;
    endcase
  /*# rtl/cpu68.vhd:859:54 */
  assign n917 = left[7]; // extract
  /*# rtl/cpu68.vhd:859:67 */
  assign n918 = right[7]; // extract
  /*# rtl/cpu68.vhd:859:58 */
  assign n919 = n917 & n918;
  /*# rtl/cpu68.vhd:859:87 */
  assign n920 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:859:76 */
  assign n921 = ~n920;
  /*# rtl/cpu68.vhd:859:71 */
  assign n922 = n919 & n921;
  /*# rtl/cpu68.vhd:860:51 */
  assign n923 = left[7]; // extract
  /*# rtl/cpu68.vhd:860:43 */
  assign n924 = ~n923;
  /*# rtl/cpu68.vhd:860:70 */
  assign n925 = right[7]; // extract
  /*# rtl/cpu68.vhd:860:61 */
  assign n926 = ~n925;
  /*# rtl/cpu68.vhd:860:56 */
  assign n927 = n924 & n926;
  /*# rtl/cpu68.vhd:860:86 */
  assign n928 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:860:75 */
  assign n929 = n927 & n928;
  /*# rtl/cpu68.vhd:859:93 */
  assign n930 = n922 | n929;
  /*# rtl/cpu68.vhd:858:25 */
  assign n932 = alu_ctrl == 6'b000000;
  /*# rtl/cpu68.vhd:858:39 */
  assign n934 = alu_ctrl == 6'b000100;
  /*# rtl/cpu68.vhd:858:39 */
  assign n935 = n932 | n934;
  /*# rtl/cpu68.vhd:862:54 */
  assign n936 = left[7]; // extract
  /*# rtl/cpu68.vhd:862:72 */
  assign n937 = right[7]; // extract
  /*# rtl/cpu68.vhd:862:63 */
  assign n938 = ~n937;
  /*# rtl/cpu68.vhd:862:58 */
  assign n939 = n936 & n938;
  /*# rtl/cpu68.vhd:862:93 */
  assign n940 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:862:82 */
  assign n941 = ~n940;
  /*# rtl/cpu68.vhd:862:77 */
  assign n942 = n939 & n941;
  /*# rtl/cpu68.vhd:863:51 */
  assign n943 = left[7]; // extract
  /*# rtl/cpu68.vhd:863:43 */
  assign n944 = ~n943;
  /*# rtl/cpu68.vhd:863:65 */
  assign n945 = right[7]; // extract
  /*# rtl/cpu68.vhd:863:56 */
  assign n946 = n944 & n945;
  /*# rtl/cpu68.vhd:863:80 */
  assign n947 = out_alu[7]; // extract
  /*# rtl/cpu68.vhd:863:69 */
  assign n948 = n946 & n947;
  /*# rtl/cpu68.vhd:862:99 */
  assign n949 = n942 | n948;
  /*# rtl/cpu68.vhd:861:25 */
  assign n951 = alu_ctrl == 6'b000001;
  /*# rtl/cpu68.vhd:861:39 */
  assign n953 = alu_ctrl == 6'b000101;
  /*# rtl/cpu68.vhd:861:39 */
  assign n954 = n951 | n953;
  /*# rtl/cpu68.vhd:865:54 */
  assign n955 = left[15]; // extract
  /*# rtl/cpu68.vhd:865:68 */
  assign n956 = right[15]; // extract
  /*# rtl/cpu68.vhd:865:59 */
  assign n957 = n955 & n956;
  /*# rtl/cpu68.vhd:865:89 */
  assign n958 = out_alu[15]; // extract
  /*# rtl/cpu68.vhd:865:78 */
  assign n959 = ~n958;
  /*# rtl/cpu68.vhd:865:73 */
  assign n960 = n957 & n959;
  /*# rtl/cpu68.vhd:866:51 */
  assign n961 = left[15]; // extract
  /*# rtl/cpu68.vhd:866:43 */
  assign n962 = ~n961;
  /*# rtl/cpu68.vhd:866:71 */
  assign n963 = right[15]; // extract
  /*# rtl/cpu68.vhd:866:62 */
  assign n964 = ~n963;
  /*# rtl/cpu68.vhd:866:57 */
  assign n965 = n962 & n964;
  /*# rtl/cpu68.vhd:866:88 */
  assign n966 = out_alu[15]; // extract
  /*# rtl/cpu68.vhd:866:77 */
  assign n967 = n965 & n966;
  /*# rtl/cpu68.vhd:865:96 */
  assign n968 = n960 | n967;
  /*# rtl/cpu68.vhd:864:25 */
  assign n970 = alu_ctrl == 6'b000010;
  /*# rtl/cpu68.vhd:868:54 */
  assign n971 = left[15]; // extract
  /*# rtl/cpu68.vhd:868:73 */
  assign n972 = right[15]; // extract
  /*# rtl/cpu68.vhd:868:64 */
  assign n973 = ~n972;
  /*# rtl/cpu68.vhd:868:59 */
  assign n974 = n971 & n973;
  /*# rtl/cpu68.vhd:868:95 */
  assign n975 = out_alu[15]; // extract
  /*# rtl/cpu68.vhd:868:84 */
  assign n976 = ~n975;
  /*# rtl/cpu68.vhd:868:79 */
  assign n977 = n974 & n976;
  /*# rtl/cpu68.vhd:869:51 */
  assign n978 = left[15]; // extract
  /*# rtl/cpu68.vhd:869:43 */
  assign n979 = ~n978;
  /*# rtl/cpu68.vhd:869:66 */
  assign n980 = right[15]; // extract
  /*# rtl/cpu68.vhd:869:57 */
  assign n981 = n979 & n980;
  /*# rtl/cpu68.vhd:869:82 */
  assign n982 = out_alu[15]; // extract
  /*# rtl/cpu68.vhd:869:71 */
  assign n983 = n981 & n982;
  /*# rtl/cpu68.vhd:868:102 */
  assign n984 = n977 | n983;
  /*# rtl/cpu68.vhd:867:25 */
  assign n986 = alu_ctrl == 6'b000011;
  /*# rtl/cpu68.vhd:867:40 */
  assign n988 = alu_ctrl == 6'b010001;
  /*# rtl/cpu68.vhd:867:40 */
  assign n989 = n986 | n988;
  /*# rtl/cpu68.vhd:871:59 */
  assign n990 = left[7]; // extract
  /*# rtl/cpu68.vhd:871:51 */
  assign n991 = ~n990;
  /*# rtl/cpu68.vhd:871:72 */
  assign n992 = left[6]; // extract
  /*# rtl/cpu68.vhd:871:64 */
  assign n993 = n991 & n992;
  /*# rtl/cpu68.vhd:871:84 */
  assign n994 = left[5]; // extract
  /*# rtl/cpu68.vhd:871:76 */
  assign n995 = n993 & n994;
  /*# rtl/cpu68.vhd:871:96 */
  assign n996 = left[4]; // extract
  /*# rtl/cpu68.vhd:871:88 */
  assign n997 = n995 & n996;
  /*# rtl/cpu68.vhd:872:45 */
  assign n998 = left[3]; // extract
  /*# rtl/cpu68.vhd:871:100 */
  assign n999 = n997 & n998;
  /*# rtl/cpu68.vhd:872:57 */
  assign n1000 = left[2]; // extract
  /*# rtl/cpu68.vhd:872:49 */
  assign n1001 = n999 & n1000;
  /*# rtl/cpu68.vhd:872:69 */
  assign n1002 = left[1]; // extract
  /*# rtl/cpu68.vhd:872:61 */
  assign n1003 = n1001 & n1002;
  /*# rtl/cpu68.vhd:872:81 */
  assign n1004 = left[0]; // extract
  /*# rtl/cpu68.vhd:872:73 */
  assign n1005 = n1003 & n1004;
  /*# rtl/cpu68.vhd:870:25 */
  assign n1007 = alu_ctrl == 6'b001010;
  /*# rtl/cpu68.vhd:874:54 */
  assign n1008 = left[7]; // extract
  /*# rtl/cpu68.vhd:874:71 */
  assign n1009 = left[6]; // extract
  /*# rtl/cpu68.vhd:874:63 */
  assign n1010 = ~n1009;
  /*# rtl/cpu68.vhd:874:58 */
  assign n1011 = n1008 & n1010;
  /*# rtl/cpu68.vhd:874:89 */
  assign n1012 = left[5]; // extract
  /*# rtl/cpu68.vhd:874:81 */
  assign n1013 = ~n1012;
  /*# rtl/cpu68.vhd:874:76 */
  assign n1014 = n1011 & n1013;
  /*# rtl/cpu68.vhd:874:107 */
  assign n1015 = left[4]; // extract
  /*# rtl/cpu68.vhd:874:99 */
  assign n1016 = ~n1015;
  /*# rtl/cpu68.vhd:874:94 */
  assign n1017 = n1014 & n1016;
  /*# rtl/cpu68.vhd:875:50 */
  assign n1018 = left[3]; // extract
  /*# rtl/cpu68.vhd:875:42 */
  assign n1019 = ~n1018;
  /*# rtl/cpu68.vhd:874:112 */
  assign n1020 = n1017 & n1019;
  /*# rtl/cpu68.vhd:875:68 */
  assign n1021 = left[2]; // extract
  /*# rtl/cpu68.vhd:875:60 */
  assign n1022 = ~n1021;
  /*# rtl/cpu68.vhd:875:55 */
  assign n1023 = n1020 & n1022;
  /*# rtl/cpu68.vhd:875:86 */
  assign n1024 = left[1]; // extract
  /*# rtl/cpu68.vhd:875:78 */
  assign n1025 = ~n1024;
  /*# rtl/cpu68.vhd:875:73 */
  assign n1026 = n1023 & n1025;
  /*# rtl/cpu68.vhd:875:104 */
  assign n1027 = left[0]; // extract
  /*# rtl/cpu68.vhd:875:96 */
  assign n1028 = ~n1027;
  /*# rtl/cpu68.vhd:875:91 */
  assign n1029 = n1026 & n1028;
  /*# rtl/cpu68.vhd:873:25 */
  assign n1031 = alu_ctrl == 6'b001011;
  /*# rtl/cpu68.vhd:873:38 */
  assign n1033 = alu_ctrl == 6'b001101;
  /*# rtl/cpu68.vhd:873:38 */
  assign n1034 = n1031 | n1033;
  /*# rtl/cpu68.vhd:877:53 */
  assign n1035 = left[0]; // extract
  /*# rtl/cpu68.vhd:877:65 */
  assign n1036 = left[7]; // extract
  /*# rtl/cpu68.vhd:877:57 */
  assign n1037 = n1035 ^ n1036;
  /*# rtl/cpu68.vhd:876:25 */
  assign n1039 = alu_ctrl == 6'b010110;
  /*# rtl/cpu68.vhd:879:53 */
  assign n1040 = left[0]; // extract
  /*# rtl/cpu68.vhd:878:25 */
  assign n1042 = alu_ctrl == 6'b011000;
  /*# rtl/cpu68.vhd:878:39 */
  assign n1044 = alu_ctrl == 6'b010010;
  /*# rtl/cpu68.vhd:878:39 */
  assign n1045 = n1042 | n1044;
  /*# rtl/cpu68.vhd:881:53 */
  assign n1046 = left[0]; // extract
  /*# rtl/cpu68.vhd:881:63 */
  assign n1047 = cc[0]; // extract
  /*# rtl/cpu68.vhd:881:57 */
  assign n1048 = n1046 ^ n1047;
  /*# rtl/cpu68.vhd:880:25 */
  assign n1050 = alu_ctrl == 6'b010100;
  /*# rtl/cpu68.vhd:883:53 */
  assign n1051 = left[15]; // extract
  /*# rtl/cpu68.vhd:883:66 */
  assign n1052 = left[14]; // extract
  /*# rtl/cpu68.vhd:883:58 */
  assign n1053 = n1051 ^ n1052;
  /*# rtl/cpu68.vhd:882:25 */
  assign n1055 = alu_ctrl == 6'b010011;
  /*# rtl/cpu68.vhd:885:53 */
  assign n1056 = left[7]; // extract
  /*# rtl/cpu68.vhd:885:65 */
  assign n1057 = left[6]; // extract
  /*# rtl/cpu68.vhd:885:57 */
  assign n1058 = n1056 ^ n1057;
  /*# rtl/cpu68.vhd:884:25 */
  assign n1060 = alu_ctrl == 6'b010101;
  /*# rtl/cpu68.vhd:884:39 */
  assign n1062 = alu_ctrl == 6'b010111;
  /*# rtl/cpu68.vhd:884:39 */
  assign n1063 = n1060 | n1062;
  /*# rtl/cpu68.vhd:887:53 */
  assign n1064 = left[1]; // extract
  /*# rtl/cpu68.vhd:886:25 */
  assign n1066 = alu_ctrl == 6'b100000;
  /*# rtl/cpu68.vhd:888:25 */
  assign n1069 = alu_ctrl == 6'b000110;
  /*# rtl/cpu68.vhd:888:38 */
  assign n1071 = alu_ctrl == 6'b000111;
  /*# rtl/cpu68.vhd:888:38 */
  assign n1072 = n1069 | n1071;
  /*# rtl/cpu68.vhd:888:48 */
  assign n1074 = alu_ctrl == 6'b001000;
  /*# rtl/cpu68.vhd:888:48 */
  assign n1075 = n1072 | n1074;
  /*# rtl/cpu68.vhd:888:58 */
  assign n1077 = alu_ctrl == 6'b001110;
  /*# rtl/cpu68.vhd:888:58 */
  assign n1078 = n1075 | n1077;
  /*# rtl/cpu68.vhd:888:68 */
  assign n1080 = alu_ctrl == 6'b100010;
  /*# rtl/cpu68.vhd:888:68 */
  assign n1081 = n1078 | n1080;
  /*# rtl/cpu68.vhd:889:41 */
  assign n1083 = alu_ctrl == 6'b100100;
  /*# rtl/cpu68.vhd:889:41 */
  assign n1084 = n1081 | n1083;
  /*# rtl/cpu68.vhd:889:52 */
  assign n1086 = alu_ctrl == 6'b100001;
  /*# rtl/cpu68.vhd:889:52 */
  assign n1087 = n1084 | n1086;
  /*# rtl/cpu68.vhd:889:62 */
  assign n1089 = alu_ctrl == 6'b100011;
  /*# rtl/cpu68.vhd:889:62 */
  assign n1090 = n1087 | n1089;
  /*# rtl/cpu68.vhd:889:73 */
  assign n1092 = alu_ctrl == 6'b011110;
  /*# rtl/cpu68.vhd:889:73 */
  assign n1093 = n1090 | n1092;
  /*# rtl/cpu68.vhd:892:25 */
  assign n1096 = alu_ctrl == 6'b011101;
  /*# rtl/cpu68.vhd:895:51 */
  assign n1097 = cc[1]; // extract
  /*# rtl/cpu68.vhd:857:17 */
  assign n1098 = {n1096, n1093, n1066, n1063, n1055, n1050, n1045, n1039, n1034, n1007, n989, n970, n954, n935};
  /*# rtl/cpu68.vhd:857:17 */
  always @*
    case (n1098)
      14'b10000000000000: n1099 = 1'b1;
      14'b01000000000000: n1099 = 1'b0;
      14'b00100000000000: n1099 = n1064;
      14'b00010000000000: n1099 = n1058;
      14'b00001000000000: n1099 = n1053;
      14'b00000100000000: n1099 = n1048;
      14'b00000010000000: n1099 = n1040;
      14'b00000001000000: n1099 = n1037;
      14'b00000000100000: n1099 = n1029;
      14'b00000000010000: n1099 = n1005;
      14'b00000000001000: n1099 = n984;
      14'b00000000000100: n1099 = n968;
      14'b00000000000010: n1099 = n949;
      14'b00000000000001: n1099 = n930;
      default: n1099 = n1097;
    endcase
  /*# rtl/cpu68.vhd:900:51 */
  assign n1100 = cc[6]; // extract
  /*# rtl/cpu68.vhd:900:66 */
  assign n1101 = left[6]; // extract
  /*# rtl/cpu68.vhd:900:58 */
  assign n1102 = n1100 & n1101;
  /*# rtl/cpu68.vhd:901:53 */
  assign n1103 = left[7]; // extract
  /*# rtl/cpu68.vhd:899:25 */
  assign n1105 = alu_ctrl == 6'b100000;
  /*# rtl/cpu68.vhd:903:51 */
  assign n1106 = cc[6]; // extract
  /*# rtl/cpu68.vhd:903:66 */
  assign n1107 = left[6]; // extract
  /*# rtl/cpu68.vhd:903:58 */
  assign n1108 = n1106 & n1107;
  /*# rtl/cpu68.vhd:904:51 */
  assign n1109 = cc[7]; // extract
  /*# rtl/cpu68.vhd:898:17 */
  always @*
    case (n1105)
      1'b1: n1110 = n1102;
      default: n1110 = n1108;
    endcase
  /*# rtl/cpu68.vhd:898:17 */
  always @*
    case (n1105)
      1'b1: n1111 = n1103;
      default: n1111 = n1109;
    endcase
  /*# rtl/cpu68.vhd:926:69 */
  assign n1115 = ~nmi_ack;
  /*# rtl/cpu68.vhd:926:56 */
  assign n1116 = n1115 & nmi;
  /*# rtl/cpu68.vhd:929:57 */
  assign n1117 = ~nmi;
  /*# rtl/cpu68.vhd:929:64 */
  assign n1118 = nmi_ack & n1117;
  /*# rtl/cpu68.vhd:929:49 */
  assign n1120 = n1118 ? 1'b0 : nmi_req;
  /*# rtl/cpu68.vhd:926:41 */
  assign n1122 = n1116 ? 1'b1 : n1120;
  /*# rtl/cpu68.vhd:923:33 */
  assign n1124 = rst ? 1'b0 : n1122;
  /*# rtl/cpu68.vhd:920:25 */
  assign n1125 = hold ? nmi_req : n1124;
  /*# rtl/cpu68.vhd:953:41 */
  assign n1131 = nmi_ctrl == 2'b01;
  /*# rtl/cpu68.vhd:955:41 */
  assign n1133 = nmi_ctrl == 2'b00;
  /*# rtl/cpu68.vhd:952:33 */
  assign n1134 = {n1133, n1131};
  /*# rtl/cpu68.vhd:952:33 */
  always @*
    case (n1134)
      2'b10: n1137 = 1'b0;
      2'b01: n1137 = 1'b1;
      default: n1137 = nmi_ack;
    endcase
  /*# rtl/cpu68.vhd:949:25 */
  assign n1138 = hold ? nmi_ack : n1137;
  /*# rtl/cpu68.vhd:973:33 */
  assign n1144 = state == 7'b0000000;
  /*# rtl/cpu68.vhd:1000:33 */
  assign n1146 = state == 7'b0111010;
  /*# rtl/cpu68.vhd:1026:33 */
  assign n1148 = state == 7'b0111001;
  /*# rtl/cpu68.vhd:1056:53 */
  assign n1149 = op_code[7:4]; // extract
  /*# rtl/cpu68.vhd:1057:49 */
  assign n1151 = n1149 == 4'b0000;
  /*# rtl/cpu68.vhd:1057:61 */
  assign n1153 = n1149 == 4'b0001;
  /*# rtl/cpu68.vhd:1057:61 */
  assign n1154 = n1151 | n1153;
  /*# rtl/cpu68.vhd:1058:64 */
  assign n1156 = n1149 == 4'b0010;
  /*# rtl/cpu68.vhd:1058:64 */
  assign n1157 = n1154 | n1156;
  /*# rtl/cpu68.vhd:1059:72 */
  assign n1159 = n1149 == 4'b0011;
  /*# rtl/cpu68.vhd:1059:72 */
  assign n1160 = n1157 | n1159;
  /*# rtl/cpu68.vhd:1060:72 */
  assign n1162 = n1149 == 4'b0100;
  /*# rtl/cpu68.vhd:1060:72 */
  assign n1163 = n1160 | n1162;
  /*# rtl/cpu68.vhd:1061:72 */
  assign n1165 = n1149 == 4'b0101;
  /*# rtl/cpu68.vhd:1061:72 */
  assign n1166 = n1163 | n1165;
  /*# rtl/cpu68.vhd:1062:72 */
  assign n1168 = n1149 == 4'b0110;
  /*# rtl/cpu68.vhd:1062:72 */
  assign n1169 = n1166 | n1168;
  /*# rtl/cpu68.vhd:1063:72 */
  assign n1171 = n1149 == 4'b0111;
  /*# rtl/cpu68.vhd:1063:72 */
  assign n1172 = n1169 | n1171;
  /*# rtl/cpu68.vhd:1079:77 */
  assign n1173 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:1080:73 */
  assign n1175 = n1173 == 4'b0000;
  /*# rtl/cpu68.vhd:1089:73 */
  assign n1177 = n1173 == 4'b0001;
  /*# rtl/cpu68.vhd:1098:73 */
  assign n1179 = n1173 == 4'b0010;
  /*# rtl/cpu68.vhd:1107:73 */
  assign n1181 = n1173 == 4'b0011;
  /*# rtl/cpu68.vhd:1116:73 */
  assign n1183 = n1173 == 4'b0100;
  /*# rtl/cpu68.vhd:1125:73 */
  assign n1185 = n1173 == 4'b0101;
  /*# rtl/cpu68.vhd:1134:73 */
  assign n1187 = n1173 == 4'b0110;
  /*# rtl/cpu68.vhd:1143:73 */
  assign n1189 = n1173 == 4'b0111;
  /*# rtl/cpu68.vhd:1152:73 */
  assign n1191 = n1173 == 4'b1000;
  /*# rtl/cpu68.vhd:1161:73 */
  assign n1193 = n1173 == 4'b1001;
  /*# rtl/cpu68.vhd:1170:73 */
  assign n1195 = n1173 == 4'b1010;
  /*# rtl/cpu68.vhd:1179:73 */
  assign n1197 = n1173 == 4'b1011;
  /*# rtl/cpu68.vhd:1188:73 */
  assign n1199 = n1173 == 4'b1100;
  /*# rtl/cpu68.vhd:1197:73 */
  assign n1201 = n1173 == 4'b1101;
  /*# rtl/cpu68.vhd:1206:73 */
  assign n1203 = n1173 == 4'b1110;
  /*# rtl/cpu68.vhd:1215:73 */
  assign n1205 = n1173 == 4'b1111;
  /*# rtl/cpu68.vhd:1079:65 */
  assign n1206 = {n1205, n1203, n1201, n1199, n1197, n1195, n1193, n1191, n1189, n1187, n1185, n1183, n1181, n1179, n1177, n1175};
  /*# rtl/cpu68.vhd:1079:65 */
  always @*
    case (n1206)
      16'b1000000000000000: n1224 = 3'b100;
      16'b0100000000000000: n1224 = 3'b100;
      16'b0010000000000000: n1224 = 3'b100;
      16'b0001000000000000: n1224 = 3'b100;
      16'b0000100000000000: n1224 = 3'b001;
      16'b0000010000000000: n1224 = 3'b001;
      16'b0000001000000000: n1224 = 3'b001;
      16'b0000000100000000: n1224 = 3'b001;
      16'b0000000010000000: n1224 = 3'b100;
      16'b0000000001000000: n1224 = 3'b001;
      16'b0000000000100000: n1224 = 3'b100;
      16'b0000000000010000: n1224 = 3'b001;
      16'b0000000000001000: n1224 = 3'b010;
      16'b0000000000000100: n1224 = 3'b001;
      16'b0000000000000010: n1224 = 3'b100;
      16'b0000000000000001: n1224 = 3'b001;
      default: n1224 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1079:65 */
  always @*
    case (n1206)
      16'b1000000000000000: n1242 = 2'b11;
      16'b0100000000000000: n1242 = 2'b11;
      16'b0010000000000000: n1242 = 2'b11;
      16'b0001000000000000: n1242 = 2'b11;
      16'b0000100000000000: n1242 = 2'b11;
      16'b0000010000000000: n1242 = 2'b11;
      16'b0000001000000000: n1242 = 2'b11;
      16'b0000000100000000: n1242 = 2'b11;
      16'b0000000010000000: n1242 = 2'b11;
      16'b0000000001000000: n1242 = 2'b11;
      16'b0000000000100000: n1242 = 2'b11;
      16'b0000000000010000: n1242 = 2'b11;
      16'b0000000000001000: n1242 = 2'b01;
      16'b0000000000000100: n1242 = 2'b11;
      16'b0000000000000010: n1242 = 2'b11;
      16'b0000000000000001: n1242 = 2'b11;
      default: n1242 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1079:65 */
  always @*
    case (n1206)
      16'b1000000000000000: n1260 = 2'b01;
      16'b0100000000000000: n1260 = 2'b01;
      16'b0010000000000000: n1260 = 2'b11;
      16'b0001000000000000: n1260 = 2'b01;
      16'b0000100000000000: n1260 = 2'b01;
      16'b0000010000000000: n1260 = 2'b01;
      16'b0000001000000000: n1260 = 2'b01;
      16'b0000000100000000: n1260 = 2'b01;
      16'b0000000010000000: n1260 = 2'b01;
      16'b0000000001000000: n1260 = 2'b01;
      16'b0000000000100000: n1260 = 2'b01;
      16'b0000000000010000: n1260 = 2'b01;
      16'b0000000000001000: n1260 = 2'b01;
      16'b0000000000000100: n1260 = 2'b01;
      16'b0000000000000010: n1260 = 2'b01;
      16'b0000000000000001: n1260 = 2'b01;
      default: n1260 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1079:65 */
  always @*
    case (n1206)
      16'b1000000000000000: n1278 = 2'b01;
      16'b0100000000000000: n1278 = 2'b10;
      16'b0010000000000000: n1278 = 2'b01;
      16'b0001000000000000: n1278 = 2'b01;
      16'b0000100000000000: n1278 = 2'b01;
      16'b0000010000000000: n1278 = 2'b01;
      16'b0000001000000000: n1278 = 2'b01;
      16'b0000000100000000: n1278 = 2'b01;
      16'b0000000010000000: n1278 = 2'b01;
      16'b0000000001000000: n1278 = 2'b01;
      16'b0000000000100000: n1278 = 2'b01;
      16'b0000000000010000: n1278 = 2'b01;
      16'b0000000000001000: n1278 = 2'b01;
      16'b0000000000000100: n1278 = 2'b01;
      16'b0000000000000010: n1278 = 2'b01;
      16'b0000000000000001: n1278 = 2'b01;
      default: n1278 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:1079:65 */
  always @*
    case (n1206)
      16'b1000000000000000: n1296 = 3'b101;
      16'b0100000000000000: n1296 = 3'b101;
      16'b0010000000000000: n1296 = 3'b000;
      16'b0001000000000000: n1296 = 3'b100;
      16'b0000100000000000: n1296 = 3'b000;
      16'b0000010000000000: n1296 = 3'b000;
      16'b0000001000000000: n1296 = 3'b000;
      16'b0000000100000000: n1296 = 3'b000;
      16'b0000000010000000: n1296 = 3'b000;
      16'b0000000001000000: n1296 = 3'b000;
      16'b0000000000100000: n1296 = 3'b000;
      16'b0000000000010000: n1296 = 3'b000;
      16'b0000000000001000: n1296 = 3'b010;
      16'b0000000000000100: n1296 = 3'b000;
      16'b0000000000000010: n1296 = 3'b000;
      16'b0000000000000001: n1296 = 3'b000;
      default: n1296 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:1079:65 */
  always @*
    case (n1206)
      16'b1000000000000000: n1314 = 6'b100100;
      16'b0100000000000000: n1314 = 6'b100011;
      16'b0010000000000000: n1314 = 6'b100101;
      16'b0001000000000000: n1314 = 6'b010001;
      16'b0000100000000000: n1314 = 6'b000000;
      16'b0000010000000000: n1314 = 6'b000111;
      16'b0000001000000000: n1314 = 6'b000100;
      16'b0000000100000000: n1314 = 6'b001000;
      16'b0000000010000000: n1314 = 6'b100010;
      16'b0000000001000000: n1314 = 6'b100001;
      16'b0000000000100000: n1314 = 6'b000110;
      16'b0000000000010000: n1314 = 6'b000110;
      16'b0000000000001000: n1314 = 6'b000011;
      16'b0000000000000100: n1314 = 6'b000101;
      16'b0000000000000010: n1314 = 6'b000001;
      16'b0000000000000001: n1314 = 6'b000001;
      default: n1314 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:1075:49 */
  assign n1316 = n1149 == 4'b1000;
  /*# rtl/cpu68.vhd:1075:61 */
  assign n1318 = n1149 == 4'b1001;
  /*# rtl/cpu68.vhd:1075:61 */
  assign n1319 = n1316 | n1318;
  /*# rtl/cpu68.vhd:1076:64 */
  assign n1321 = n1149 == 4'b1010;
  /*# rtl/cpu68.vhd:1076:64 */
  assign n1322 = n1319 | n1321;
  /*# rtl/cpu68.vhd:1077:72 */
  assign n1324 = n1149 == 4'b1011;
  /*# rtl/cpu68.vhd:1077:72 */
  assign n1325 = n1322 | n1324;
  /*# rtl/cpu68.vhd:1238:77 */
  assign n1326 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:1239:73 */
  assign n1328 = n1326 == 4'b0000;
  /*# rtl/cpu68.vhd:1248:73 */
  assign n1330 = n1326 == 4'b0001;
  /*# rtl/cpu68.vhd:1257:73 */
  assign n1332 = n1326 == 4'b0010;
  /*# rtl/cpu68.vhd:1266:73 */
  assign n1334 = n1326 == 4'b0011;
  /*# rtl/cpu68.vhd:1275:73 */
  assign n1336 = n1326 == 4'b0100;
  /*# rtl/cpu68.vhd:1284:73 */
  assign n1338 = n1326 == 4'b0101;
  /*# rtl/cpu68.vhd:1293:73 */
  assign n1340 = n1326 == 4'b0110;
  /*# rtl/cpu68.vhd:1302:73 */
  assign n1342 = n1326 == 4'b0111;
  /*# rtl/cpu68.vhd:1311:73 */
  assign n1344 = n1326 == 4'b1000;
  /*# rtl/cpu68.vhd:1320:73 */
  assign n1346 = n1326 == 4'b1001;
  /*# rtl/cpu68.vhd:1329:73 */
  assign n1348 = n1326 == 4'b1010;
  /*# rtl/cpu68.vhd:1338:73 */
  assign n1350 = n1326 == 4'b1011;
  /*# rtl/cpu68.vhd:1347:73 */
  assign n1352 = n1326 == 4'b1100;
  /*# rtl/cpu68.vhd:1356:73 */
  assign n1354 = n1326 == 4'b1101;
  /*# rtl/cpu68.vhd:1365:73 */
  assign n1356 = n1326 == 4'b1110;
  /*# rtl/cpu68.vhd:1374:73 */
  assign n1358 = n1326 == 4'b1111;
  /*# rtl/cpu68.vhd:1238:65 */
  assign n1359 = {n1358, n1356, n1354, n1352, n1350, n1348, n1346, n1344, n1342, n1340, n1338, n1336, n1334, n1332, n1330, n1328};
  /*# rtl/cpu68.vhd:1238:65 */
  always @*
    case (n1359)
      16'b1000000000000000: n1377 = 3'b100;
      16'b0100000000000000: n1377 = 3'b100;
      16'b0010000000000000: n1377 = 3'b100;
      16'b0001000000000000: n1377 = 3'b010;
      16'b0000100000000000: n1377 = 3'b100;
      16'b0000010000000000: n1377 = 3'b100;
      16'b0000001000000000: n1377 = 3'b100;
      16'b0000000100000000: n1377 = 3'b100;
      16'b0000000010000000: n1377 = 3'b100;
      16'b0000000001000000: n1377 = 3'b100;
      16'b0000000000100000: n1377 = 3'b100;
      16'b0000000000010000: n1377 = 3'b100;
      16'b0000000000001000: n1377 = 3'b010;
      16'b0000000000000100: n1377 = 3'b100;
      16'b0000000000000010: n1377 = 3'b100;
      16'b0000000000000001: n1377 = 3'b100;
      default: n1377 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1238:65 */
  always @*
    case (n1359)
      16'b1000000000000000: n1395 = 2'b11;
      16'b0100000000000000: n1395 = 2'b11;
      16'b0010000000000000: n1395 = 2'b11;
      16'b0001000000000000: n1395 = 2'b01;
      16'b0000100000000000: n1395 = 2'b01;
      16'b0000010000000000: n1395 = 2'b01;
      16'b0000001000000000: n1395 = 2'b01;
      16'b0000000100000000: n1395 = 2'b01;
      16'b0000000010000000: n1395 = 2'b11;
      16'b0000000001000000: n1395 = 2'b01;
      16'b0000000000100000: n1395 = 2'b11;
      16'b0000000000010000: n1395 = 2'b01;
      16'b0000000000001000: n1395 = 2'b01;
      16'b0000000000000100: n1395 = 2'b01;
      16'b0000000000000010: n1395 = 2'b11;
      16'b0000000000000001: n1395 = 2'b01;
      default: n1395 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1238:65 */
  always @*
    case (n1359)
      16'b1000000000000000: n1413 = 3'b100;
      16'b0100000000000000: n1413 = 3'b001;
      16'b0010000000000000: n1413 = 3'b100;
      16'b0001000000000000: n1413 = 3'b100;
      16'b0000100000000000: n1413 = 3'b100;
      16'b0000010000000000: n1413 = 3'b100;
      16'b0000001000000000: n1413 = 3'b100;
      16'b0000000100000000: n1413 = 3'b100;
      16'b0000000010000000: n1413 = 3'b100;
      16'b0000000001000000: n1413 = 3'b100;
      16'b0000000000100000: n1413 = 3'b100;
      16'b0000000000010000: n1413 = 3'b100;
      16'b0000000000001000: n1413 = 3'b100;
      16'b0000000000000100: n1413 = 3'b100;
      16'b0000000000000010: n1413 = 3'b100;
      16'b0000000000000001: n1413 = 3'b100;
      default: n1413 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1238:65 */
  always @*
    case (n1359)
      16'b1000000000000000: n1431 = 2'b01;
      16'b0100000000000000: n1431 = 2'b01;
      16'b0010000000000000: n1431 = 2'b01;
      16'b0001000000000000: n1431 = 2'b01;
      16'b0000100000000000: n1431 = 2'b01;
      16'b0000010000000000: n1431 = 2'b01;
      16'b0000001000000000: n1431 = 2'b01;
      16'b0000000100000000: n1431 = 2'b01;
      16'b0000000010000000: n1431 = 2'b01;
      16'b0000000001000000: n1431 = 2'b01;
      16'b0000000000100000: n1431 = 2'b01;
      16'b0000000000010000: n1431 = 2'b01;
      16'b0000000000001000: n1431 = 2'b01;
      16'b0000000000000100: n1431 = 2'b01;
      16'b0000000000000010: n1431 = 2'b01;
      16'b0000000000000001: n1431 = 2'b01;
      default: n1431 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1238:65 */
  always @*
    case (n1359)
      16'b1000000000000000: n1449 = 3'b100;
      16'b0100000000000000: n1449 = 3'b100;
      16'b0010000000000000: n1449 = 3'b010;
      16'b0001000000000000: n1449 = 3'b010;
      16'b0000100000000000: n1449 = 3'b001;
      16'b0000010000000000: n1449 = 3'b001;
      16'b0000001000000000: n1449 = 3'b001;
      16'b0000000100000000: n1449 = 3'b001;
      16'b0000000010000000: n1449 = 3'b001;
      16'b0000000001000000: n1449 = 3'b001;
      16'b0000000000100000: n1449 = 3'b001;
      16'b0000000000010000: n1449 = 3'b001;
      16'b0000000000001000: n1449 = 3'b010;
      16'b0000000000000100: n1449 = 3'b001;
      16'b0000000000000010: n1449 = 3'b001;
      16'b0000000000000001: n1449 = 3'b001;
      default: n1449 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:1238:65 */
  always @*
    case (n1359)
      16'b1000000000000000: n1467 = 6'b100100;
      16'b0100000000000000: n1467 = 6'b100011;
      16'b0010000000000000: n1467 = 6'b100100;
      16'b0001000000000000: n1467 = 6'b100011;
      16'b0000100000000000: n1467 = 6'b000000;
      16'b0000010000000000: n1467 = 6'b000111;
      16'b0000001000000000: n1467 = 6'b000100;
      16'b0000000100000000: n1467 = 6'b001000;
      16'b0000000010000000: n1467 = 6'b100010;
      16'b0000000001000000: n1467 = 6'b100001;
      16'b0000000000100000: n1467 = 6'b000110;
      16'b0000000000010000: n1467 = 6'b000110;
      16'b0000000000001000: n1467 = 6'b000010;
      16'b0000000000000100: n1467 = 6'b000101;
      16'b0000000000000010: n1467 = 6'b000001;
      16'b0000000000000001: n1467 = 6'b000001;
      default: n1467 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:1234:49 */
  assign n1469 = n1149 == 4'b1100;
  /*# rtl/cpu68.vhd:1234:61 */
  assign n1471 = n1149 == 4'b1101;
  /*# rtl/cpu68.vhd:1234:61 */
  assign n1472 = n1469 | n1471;
  /*# rtl/cpu68.vhd:1235:64 */
  assign n1474 = n1149 == 4'b1110;
  /*# rtl/cpu68.vhd:1235:64 */
  assign n1475 = n1472 | n1474;
  /*# rtl/cpu68.vhd:1236:72 */
  assign n1477 = n1149 == 4'b1111;
  /*# rtl/cpu68.vhd:1236:72 */
  assign n1478 = n1475 | n1477;
  /*# rtl/cpu68.vhd:1056:41 */
  assign n1479 = {n1478, n1325, n1172};
  /*# rtl/cpu68.vhd:1056:41 */
  always @*
    case (n1479)
      3'b100: n1482 = n1377;
      3'b010: n1482 = n1224;
      3'b001: n1482 = 3'b100;
      default: n1482 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1056:41 */
  always @*
    case (n1479)
      3'b100: n1485 = n1395;
      3'b010: n1485 = n1242;
      3'b001: n1485 = 2'b11;
      default: n1485 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1056:41 */
  always @*
    case (n1479)
      3'b100: n1489 = n1413;
      3'b010: n1489 = 3'b100;
      3'b001: n1489 = 3'b100;
      default: n1489 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1056:41 */
  always @*
    case (n1479)
      3'b100: n1492 = n1431;
      3'b010: n1492 = n1260;
      3'b001: n1492 = 2'b11;
      default: n1492 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1056:41 */
  always @*
    case (n1479)
      3'b100: n1496 = 2'b01;
      3'b010: n1496 = n1278;
      3'b001: n1496 = 2'b01;
      default: n1496 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:1056:41 */
  always @*
    case (n1479)
      3'b100: n1499 = n1449;
      3'b010: n1499 = n1296;
      3'b001: n1499 = 3'b000;
      default: n1499 = 3'b010;
    endcase
  /*# rtl/cpu68.vhd:1056:41 */
  always @*
    case (n1479)
      3'b100: n1504 = 2'b00;
      3'b010: n1504 = 2'b00;
      3'b001: n1504 = 2'b01;
      default: n1504 = 2'b00;
    endcase
  /*# rtl/cpu68.vhd:1056:41 */
  always @*
    case (n1479)
      3'b100: n1507 = n1467;
      3'b010: n1507 = n1314;
      3'b001: n1507 = 6'b100101;
      default: n1507 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:1419:68 */
  assign n1508 = ~nmi_ack;
  /*# rtl/cpu68.vhd:1419:55 */
  assign n1509 = n1508 & nmi_req;
  /*# rtl/cpu68.vhd:1429:53 */
  assign n1510 = ~nmi_req;
  /*# rtl/cpu68.vhd:1429:60 */
  assign n1511 = nmi_ack & n1510;
  /*# rtl/cpu68.vhd:1429:41 */
  assign n1514 = n1511 ? 2'b00 : 2'b10;
  /*# rtl/cpu68.vhd:1437:63 */
  assign n1515 = cc[4]; // extract
  /*# rtl/cpu68.vhd:1437:70 */
  assign n1516 = ~n1515;
  /*# rtl/cpu68.vhd:1437:56 */
  assign n1517 = n1516 & irq;
  /*# rtl/cpu68.vhd:1437:41 */
  assign n1520 = n1517 ? 7'b0100000 : 7'b0000010;
  /*# rtl/cpu68.vhd:1437:41 */
  assign n1523 = n1517 ? 3'b001 : 3'b110;
  /*# rtl/cpu68.vhd:1437:41 */
  assign n1526 = n1517 ? 2'b00 : 2'b01;
  /*# rtl/cpu68.vhd:1419:33 */
  assign n1528 = n1509 ? 7'b0100000 : n1520;
  /*# rtl/cpu68.vhd:1419:33 */
  assign n1530 = n1509 ? 3'b001 : n1523;
  /*# rtl/cpu68.vhd:1419:33 */
  assign n1532 = n1509 ? 2'b00 : n1526;
  /*# rtl/cpu68.vhd:1419:33 */
  assign n1534 = n1509 ? 2'b01 : n1514;
  /*# rtl/cpu68.vhd:1410:33 */
  assign n1536 = halt ? 7'b0001011 : n1528;
  /*# rtl/cpu68.vhd:1410:33 */
  assign n1538 = halt ? 3'b001 : n1530;
  /*# rtl/cpu68.vhd:1410:33 */
  assign n1540 = halt ? 2'b00 : n1532;
  /*# rtl/cpu68.vhd:1410:33 */
  assign n1543 = halt ? 2'b10 : n1534;
  /*# rtl/cpu68.vhd:1055:33 */
  assign n1545 = state == 7'b0000001;
  /*# rtl/cpu68.vhd:1460:53 */
  assign n1546 = op_code[7:4]; // extract
  /*# rtl/cpu68.vhd:1465:69 */
  assign n1547 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:1466:65 */
  assign n1549 = n1547 == 4'b0001;
  /*# rtl/cpu68.vhd:1475:65 */
  assign n1551 = n1547 == 4'b0100;
  /*# rtl/cpu68.vhd:1484:65 */
  assign n1553 = n1547 == 4'b0101;
  /*# rtl/cpu68.vhd:1493:65 */
  assign n1555 = n1547 == 4'b0110;
  /*# rtl/cpu68.vhd:1502:65 */
  assign n1557 = n1547 == 4'b0111;
  /*# rtl/cpu68.vhd:1511:65 */
  assign n1559 = n1547 == 4'b1000;
  /*# rtl/cpu68.vhd:1520:65 */
  assign n1561 = n1547 == 4'b1001;
  /*# rtl/cpu68.vhd:1529:65 */
  assign n1563 = n1547 == 4'b1010;
  /*# rtl/cpu68.vhd:1538:65 */
  assign n1565 = n1547 == 4'b1011;
  /*# rtl/cpu68.vhd:1547:65 */
  assign n1567 = n1547 == 4'b1100;
  /*# rtl/cpu68.vhd:1556:65 */
  assign n1569 = n1547 == 4'b1101;
  /*# rtl/cpu68.vhd:1565:65 */
  assign n1571 = n1547 == 4'b1110;
  /*# rtl/cpu68.vhd:1574:65 */
  assign n1573 = n1547 == 4'b1111;
  /*# rtl/cpu68.vhd:1465:57 */
  assign n1574 = {n1573, n1571, n1569, n1567, n1565, n1563, n1561, n1559, n1557, n1555, n1553, n1551, n1549};
  /*# rtl/cpu68.vhd:1465:57 */
  always @*
    case (n1574)
      13'b1000000000000: n1589 = 7'b0000001;
      13'b0100000000000: n1589 = 7'b0000001;
      13'b0010000000000: n1589 = 7'b0000001;
      13'b0001000000000: n1589 = 7'b0000001;
      13'b0000100000000: n1589 = 7'b0000001;
      13'b0000010000000: n1589 = 7'b0000001;
      13'b0000001000000: n1589 = 7'b0111100;
      13'b0000000100000: n1589 = 7'b0111100;
      13'b0000000010000: n1589 = 7'b0000001;
      13'b0000000001000: n1589 = 7'b0000001;
      13'b0000000000100: n1589 = 7'b0000001;
      13'b0000000000010: n1589 = 7'b0000001;
      13'b0000000000001: n1589 = 7'b0000001;
      default: n1589 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:1465:57 */
  always @*
    case (n1574)
      13'b1000000000000: n1604 = 3'b100;
      13'b0100000000000: n1604 = 3'b100;
      13'b0010000000000: n1604 = 3'b100;
      13'b0001000000000: n1604 = 3'b100;
      13'b0000100000000: n1604 = 3'b100;
      13'b0000010000000: n1604 = 3'b100;
      13'b0000001000000: n1604 = 3'b100;
      13'b0000000100000: n1604 = 3'b100;
      13'b0000000010000: n1604 = 3'b001;
      13'b0000000001000: n1604 = 3'b100;
      13'b0000000000100: n1604 = 3'b010;
      13'b0000000000010: n1604 = 3'b010;
      13'b0000000000001: n1604 = 3'b100;
      default: n1604 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1465:57 */
  always @*
    case (n1574)
      13'b1000000000000: n1619 = 2'b11;
      13'b0100000000000: n1619 = 2'b11;
      13'b0010000000000: n1619 = 2'b11;
      13'b0001000000000: n1619 = 2'b11;
      13'b0000100000000: n1619 = 2'b11;
      13'b0000010000000: n1619 = 2'b11;
      13'b0000001000000: n1619 = 2'b11;
      13'b0000000100000: n1619 = 2'b11;
      13'b0000000010000: n1619 = 2'b11;
      13'b0000000001000: n1619 = 2'b11;
      13'b0000000000100: n1619 = 2'b01;
      13'b0000000000010: n1619 = 2'b01;
      13'b0000000000001: n1619 = 2'b11;
      default: n1619 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1465:57 */
  always @*
    case (n1574)
      13'b1000000000000: n1634 = 3'b100;
      13'b0100000000000: n1634 = 3'b100;
      13'b0010000000000: n1634 = 3'b100;
      13'b0001000000000: n1634 = 3'b100;
      13'b0000100000000: n1634 = 3'b100;
      13'b0000010000000: n1634 = 3'b100;
      13'b0000001000000: n1634 = 3'b001;
      13'b0000000100000: n1634 = 3'b001;
      13'b0000000010000: n1634 = 3'b100;
      13'b0000000001000: n1634 = 3'b100;
      13'b0000000000100: n1634 = 3'b100;
      13'b0000000000010: n1634 = 3'b100;
      13'b0000000000001: n1634 = 3'b100;
      default: n1634 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1465:57 */
  always @*
    case (n1574)
      13'b1000000000000: n1649 = 2'b01;
      13'b0100000000000: n1649 = 2'b01;
      13'b0010000000000: n1649 = 2'b01;
      13'b0001000000000: n1649 = 2'b01;
      13'b0000100000000: n1649 = 2'b01;
      13'b0000010000000: n1649 = 2'b01;
      13'b0000001000000: n1649 = 2'b01;
      13'b0000000100000: n1649 = 2'b01;
      13'b0000000010000: n1649 = 2'b11;
      13'b0000000001000: n1649 = 2'b01;
      13'b0000000000100: n1649 = 2'b01;
      13'b0000000000010: n1649 = 2'b01;
      13'b0000000000001: n1649 = 2'b11;
      default: n1649 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1465:57 */
  always @*
    case (n1574)
      13'b1000000000000: n1664 = 3'b000;
      13'b0100000000000: n1664 = 3'b000;
      13'b0010000000000: n1664 = 3'b000;
      13'b0001000000000: n1664 = 3'b000;
      13'b0000100000000: n1664 = 3'b000;
      13'b0000010000000: n1664 = 3'b000;
      13'b0000001000000: n1664 = 3'b100;
      13'b0000000100000: n1664 = 3'b100;
      13'b0000000010000: n1664 = 3'b000;
      13'b0000000001000: n1664 = 3'b000;
      13'b0000000000100: n1664 = 3'b010;
      13'b0000000000010: n1664 = 3'b010;
      13'b0000000000001: n1664 = 3'b010;
      default: n1664 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:1465:57 */
  always @*
    case (n1574)
      13'b1000000000000: n1679 = 2'b01;
      13'b0100000000000: n1679 = 2'b01;
      13'b0010000000000: n1679 = 2'b01;
      13'b0001000000000: n1679 = 2'b01;
      13'b0000100000000: n1679 = 2'b01;
      13'b0000010000000: n1679 = 2'b01;
      13'b0000001000000: n1679 = 2'b10;
      13'b0000000100000: n1679 = 2'b10;
      13'b0000000010000: n1679 = 2'b01;
      13'b0000000001000: n1679 = 2'b01;
      13'b0000000000100: n1679 = 2'b01;
      13'b0000000000010: n1679 = 2'b01;
      13'b0000000000001: n1679 = 2'b01;
      default: n1679 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:1465:57 */
  always @*
    case (n1574)
      13'b1000000000000: n1694 = 6'b011001;
      13'b0100000000000: n1694 = 6'b011010;
      13'b0010000000000: n1694 = 6'b011011;
      13'b0001000000000: n1694 = 6'b011100;
      13'b0000100000000: n1694 = 6'b011101;
      13'b0000010000000: n1694 = 6'b011110;
      13'b0000001000000: n1694 = 6'b010000;
      13'b0000000100000: n1694 = 6'b001111;
      13'b0000000010000: n1694 = 6'b011111;
      13'b0000000001000: n1694 = 6'b100000;
      13'b0000000000100: n1694 = 6'b010011;
      13'b0000000000010: n1694 = 6'b010010;
      13'b0000000000001: n1694 = 6'b100101;
      default: n1694 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:1461:49 */
  assign n1696 = n1546 == 4'b0000;
  /*# rtl/cpu68.vhd:1601:69 */
  assign n1697 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:1602:65 */
  assign n1699 = n1697 == 4'b0000;
  /*# rtl/cpu68.vhd:1607:65 */
  assign n1701 = n1697 == 4'b0001;
  /*# rtl/cpu68.vhd:1612:65 */
  assign n1703 = n1697 == 4'b0110;
  /*# rtl/cpu68.vhd:1617:65 */
  assign n1705 = n1697 == 4'b0111;
  /*# rtl/cpu68.vhd:1622:65 */
  assign n1707 = n1697 == 4'b1001;
  /*# rtl/cpu68.vhd:1627:65 */
  assign n1709 = n1697 == 4'b1011;
  /*# rtl/cpu68.vhd:1601:57 */
  assign n1710 = {n1709, n1707, n1705, n1703, n1701, n1699};
  /*# rtl/cpu68.vhd:1601:57 */
  always @*
    case (n1710)
      6'b100000: n1718 = 3'b001;
      6'b010000: n1718 = 3'b001;
      6'b001000: n1718 = 3'b001;
      6'b000100: n1718 = 3'b100;
      6'b000010: n1718 = 3'b100;
      6'b000001: n1718 = 3'b001;
      default: n1718 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1601:57 */
  always @*
    case (n1710)
      6'b100000: n1726 = 2'b11;
      6'b010000: n1726 = 2'b11;
      6'b001000: n1726 = 2'b11;
      6'b000100: n1726 = 2'b01;
      6'b000010: n1726 = 2'b11;
      6'b000001: n1726 = 2'b11;
      default: n1726 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1601:57 */
  always @*
    case (n1710)
      6'b100000: n1734 = 2'b01;
      6'b010000: n1734 = 2'b01;
      6'b001000: n1734 = 2'b01;
      6'b000100: n1734 = 2'b01;
      6'b000010: n1734 = 2'b01;
      6'b000001: n1734 = 2'b01;
      default: n1734 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1601:57 */
  always @*
    case (n1710)
      6'b100000: n1742 = 6'b000000;
      6'b010000: n1742 = 6'b100110;
      6'b001000: n1742 = 6'b100001;
      6'b000100: n1742 = 6'b100010;
      6'b000010: n1742 = 6'b000001;
      6'b000001: n1742 = 6'b000001;
      default: n1742 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:1594:49 */
  assign n1744 = n1546 == 4'b0001;
  /*# rtl/cpu68.vhd:1651:69 */
  assign n1745 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:1652:65 */
  assign n1747 = n1745 == 4'b0000;
  /*# rtl/cpu68.vhd:1654:65 */
  assign n1749 = n1745 == 4'b0001;
  /*# rtl/cpu68.vhd:1657:79 */
  assign n1750 = cc[0]; // extract
  /*# rtl/cpu68.vhd:1657:91 */
  assign n1751 = cc[2]; // extract
  /*# rtl/cpu68.vhd:1657:86 */
  assign n1752 = n1750 | n1751;
  /*# rtl/cpu68.vhd:1657:99 */
  assign n1753 = ~n1752;
  /*# rtl/cpu68.vhd:1657:73 */
  assign n1756 = n1753 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1656:65 */
  assign n1758 = n1745 == 4'b0010;
  /*# rtl/cpu68.vhd:1663:79 */
  assign n1759 = cc[0]; // extract
  /*# rtl/cpu68.vhd:1663:91 */
  assign n1760 = cc[2]; // extract
  /*# rtl/cpu68.vhd:1663:86 */
  assign n1761 = n1759 | n1760;
  /*# rtl/cpu68.vhd:1663:73 */
  assign n1764 = n1761 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1662:65 */
  assign n1766 = n1745 == 4'b0011;
  /*# rtl/cpu68.vhd:1669:78 */
  assign n1767 = cc[0]; // extract
  /*# rtl/cpu68.vhd:1669:85 */
  assign n1768 = ~n1767;
  /*# rtl/cpu68.vhd:1669:73 */
  assign n1771 = n1768 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1668:65 */
  assign n1773 = n1745 == 4'b0100;
  /*# rtl/cpu68.vhd:1675:78 */
  assign n1774 = cc[0]; // extract
  /*# rtl/cpu68.vhd:1675:73 */
  assign n1777 = n1774 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1674:65 */
  assign n1779 = n1745 == 4'b0101;
  /*# rtl/cpu68.vhd:1681:78 */
  assign n1780 = cc[2]; // extract
  /*# rtl/cpu68.vhd:1681:85 */
  assign n1781 = ~n1780;
  /*# rtl/cpu68.vhd:1681:73 */
  assign n1784 = n1781 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1680:65 */
  assign n1786 = n1745 == 4'b0110;
  /*# rtl/cpu68.vhd:1687:78 */
  assign n1787 = cc[2]; // extract
  /*# rtl/cpu68.vhd:1687:73 */
  assign n1790 = n1787 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1686:65 */
  assign n1792 = n1745 == 4'b0111;
  /*# rtl/cpu68.vhd:1693:78 */
  assign n1793 = cc[1]; // extract
  /*# rtl/cpu68.vhd:1693:85 */
  assign n1794 = ~n1793;
  /*# rtl/cpu68.vhd:1693:73 */
  assign n1797 = n1794 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1692:65 */
  assign n1799 = n1745 == 4'b1000;
  /*# rtl/cpu68.vhd:1699:78 */
  assign n1800 = cc[1]; // extract
  /*# rtl/cpu68.vhd:1699:73 */
  assign n1803 = n1800 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1698:65 */
  assign n1805 = n1745 == 4'b1001;
  /*# rtl/cpu68.vhd:1705:78 */
  assign n1806 = cc[3]; // extract
  /*# rtl/cpu68.vhd:1705:85 */
  assign n1807 = ~n1806;
  /*# rtl/cpu68.vhd:1705:73 */
  assign n1810 = n1807 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1704:65 */
  assign n1812 = n1745 == 4'b1010;
  /*# rtl/cpu68.vhd:1711:78 */
  assign n1813 = cc[3]; // extract
  /*# rtl/cpu68.vhd:1711:73 */
  assign n1816 = n1813 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1710:65 */
  assign n1818 = n1745 == 4'b1011;
  /*# rtl/cpu68.vhd:1717:79 */
  assign n1819 = cc[3]; // extract
  /*# rtl/cpu68.vhd:1717:92 */
  assign n1820 = cc[1]; // extract
  /*# rtl/cpu68.vhd:1717:86 */
  assign n1821 = n1819 ^ n1820;
  /*# rtl/cpu68.vhd:1717:100 */
  assign n1822 = ~n1821;
  /*# rtl/cpu68.vhd:1717:73 */
  assign n1825 = n1822 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1716:65 */
  assign n1827 = n1745 == 4'b1100;
  /*# rtl/cpu68.vhd:1723:79 */
  assign n1828 = cc[3]; // extract
  /*# rtl/cpu68.vhd:1723:92 */
  assign n1829 = cc[1]; // extract
  /*# rtl/cpu68.vhd:1723:86 */
  assign n1830 = n1828 ^ n1829;
  /*# rtl/cpu68.vhd:1723:73 */
  assign n1833 = n1830 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1722:65 */
  assign n1835 = n1745 == 4'b1101;
  /*# rtl/cpu68.vhd:1729:79 */
  assign n1836 = cc[2]; // extract
  /*# rtl/cpu68.vhd:1729:92 */
  assign n1837 = cc[3]; // extract
  /*# rtl/cpu68.vhd:1729:105 */
  assign n1838 = cc[1]; // extract
  /*# rtl/cpu68.vhd:1729:99 */
  assign n1839 = n1837 ^ n1838;
  /*# rtl/cpu68.vhd:1729:86 */
  assign n1840 = n1836 | n1839;
  /*# rtl/cpu68.vhd:1729:114 */
  assign n1841 = ~n1840;
  /*# rtl/cpu68.vhd:1729:73 */
  assign n1844 = n1841 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1728:65 */
  assign n1846 = n1745 == 4'b1110;
  /*# rtl/cpu68.vhd:1735:79 */
  assign n1847 = cc[2]; // extract
  /*# rtl/cpu68.vhd:1735:92 */
  assign n1848 = cc[3]; // extract
  /*# rtl/cpu68.vhd:1735:105 */
  assign n1849 = cc[1]; // extract
  /*# rtl/cpu68.vhd:1735:99 */
  assign n1850 = n1848 ^ n1849;
  /*# rtl/cpu68.vhd:1735:86 */
  assign n1851 = n1847 | n1850;
  /*# rtl/cpu68.vhd:1735:73 */
  assign n1854 = n1851 ? 7'b0011011 : 7'b0111100;
  /*# rtl/cpu68.vhd:1734:65 */
  assign n1856 = n1745 == 4'b1111;
  /*# rtl/cpu68.vhd:1651:57 */
  assign n1857 = {n1856, n1846, n1835, n1827, n1818, n1812, n1805, n1799, n1792, n1786, n1779, n1773, n1766, n1758, n1749, n1747};
  /*# rtl/cpu68.vhd:1651:57 */
  always @*
    case (n1857)
      16'b1000000000000000: n1861 = n1854;
      16'b0100000000000000: n1861 = n1844;
      16'b0010000000000000: n1861 = n1833;
      16'b0001000000000000: n1861 = n1825;
      16'b0000100000000000: n1861 = n1816;
      16'b0000010000000000: n1861 = n1810;
      16'b0000001000000000: n1861 = n1803;
      16'b0000000100000000: n1861 = n1797;
      16'b0000000010000000: n1861 = n1790;
      16'b0000000001000000: n1861 = n1784;
      16'b0000000000100000: n1861 = n1777;
      16'b0000000000010000: n1861 = n1771;
      16'b0000000000001000: n1861 = n1764;
      16'b0000000000000100: n1861 = n1756;
      16'b0000000000000010: n1861 = 7'b0111100;
      16'b0000000000000001: n1861 = 7'b0011011;
      default: n1861 = 7'b0111100;
    endcase
  /*# rtl/cpu68.vhd:1639:49 */
  assign n1863 = n1546 == 4'b0010;
  /*# rtl/cpu68.vhd:1752:69 */
  assign n1864 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:1753:65 */
  assign n1866 = n1864 == 4'b0000;
  /*# rtl/cpu68.vhd:1761:65 */
  assign n1868 = n1864 == 4'b0001;
  /*# rtl/cpu68.vhd:1769:65 */
  assign n1870 = n1864 == 4'b0010;
  /*# rtl/cpu68.vhd:1777:65 */
  assign n1872 = n1864 == 4'b0011;
  /*# rtl/cpu68.vhd:1785:65 */
  assign n1874 = n1864 == 4'b0100;
  /*# rtl/cpu68.vhd:1794:65 */
  assign n1876 = n1864 == 4'b0101;
  /*# rtl/cpu68.vhd:1802:65 */
  assign n1878 = n1864 == 4'b0110;
  /*# rtl/cpu68.vhd:1810:65 */
  assign n1880 = n1864 == 4'b0111;
  /*# rtl/cpu68.vhd:1818:65 */
  assign n1882 = n1864 == 4'b1000;
  /*# rtl/cpu68.vhd:1826:65 */
  assign n1884 = n1864 == 4'b1001;
  /*# rtl/cpu68.vhd:1834:65 */
  assign n1886 = n1864 == 4'b1010;
  /*# rtl/cpu68.vhd:1842:65 */
  assign n1888 = n1864 == 4'b1011;
  /*# rtl/cpu68.vhd:1850:65 */
  assign n1890 = n1864 == 4'b1100;
  /*# rtl/cpu68.vhd:1858:65 */
  assign n1892 = n1864 == 4'b1101;
  /*# rtl/cpu68.vhd:1866:65 */
  assign n1894 = n1864 == 4'b1110;
  /*# rtl/cpu68.vhd:1874:65 */
  assign n1896 = n1864 == 4'b1111;
  /*# rtl/cpu68.vhd:1752:57 */
  assign n1897 = {n1896, n1894, n1892, n1890, n1888, n1886, n1884, n1882, n1880, n1878, n1876, n1874, n1872, n1870, n1868, n1866};
  /*# rtl/cpu68.vhd:1752:57 */
  always @*
    case (n1897)
      16'b1000000000000000: n1915 = 7'b0100000;
      16'b0100000000000000: n1915 = 7'b0100000;
      16'b0010000000000000: n1915 = 7'b0001101;
      16'b0001000000000000: n1915 = 7'b0110111;
      16'b0000100000000000: n1915 = 7'b0101010;
      16'b0000010000000000: n1915 = 7'b0000001;
      16'b0000001000000000: n1915 = 7'b0011110;
      16'b0000000100000000: n1915 = 7'b0110110;
      16'b0000000010000000: n1915 = 7'b0110100;
      16'b0000000001000000: n1915 = 7'b0110010;
      16'b0000000000100000: n1915 = 7'b0111100;
      16'b0000000000010000: n1915 = 7'b0111100;
      16'b0000000000001000: n1915 = 7'b0110011;
      16'b0000000000000100: n1915 = 7'b0110001;
      16'b0000000000000010: n1915 = 7'b0111100;
      16'b0000000000000001: n1915 = 7'b0111100;
      default: n1915 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:1752:57 */
  always @*
    case (n1897)
      16'b1000000000000000: n1933 = 3'b100;
      16'b0100000000000000: n1933 = 3'b100;
      16'b0010000000000000: n1933 = 3'b100;
      16'b0001000000000000: n1933 = 3'b100;
      16'b0000100000000000: n1933 = 3'b100;
      16'b0000010000000000: n1933 = 3'b001;
      16'b0000001000000000: n1933 = 3'b100;
      16'b0000000100000000: n1933 = 3'b100;
      16'b0000000010000000: n1933 = 3'b100;
      16'b0000000001000000: n1933 = 3'b100;
      16'b0000000000100000: n1933 = 3'b100;
      16'b0000000000010000: n1933 = 3'b100;
      16'b0000000000001000: n1933 = 3'b100;
      16'b0000000000000100: n1933 = 3'b100;
      16'b0000000000000010: n1933 = 3'b100;
      16'b0000000000000001: n1933 = 3'b001;
      default: n1933 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1752:57 */
  always @*
    case (n1897)
      16'b1000000000000000: n1951 = 2'b01;
      16'b0100000000000000: n1951 = 2'b01;
      16'b0010000000000000: n1951 = 2'b01;
      16'b0001000000000000: n1951 = 2'b01;
      16'b0000100000000000: n1951 = 2'b10;
      16'b0000010000000000: n1951 = 2'b01;
      16'b0000001000000000: n1951 = 2'b10;
      16'b0000000100000000: n1951 = 2'b10;
      16'b0000000010000000: n1951 = 2'b01;
      16'b0000000001000000: n1951 = 2'b01;
      16'b0000000000100000: n1951 = 2'b10;
      16'b0000000000010000: n1951 = 2'b10;
      16'b0000000000001000: n1951 = 2'b10;
      16'b0000000000000100: n1951 = 2'b10;
      16'b0000000000000010: n1951 = 2'b10;
      16'b0000000000000001: n1951 = 2'b01;
      default: n1951 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:1752:57 */
  always @*
    case (n1897)
      16'b1000000000000000: n1969 = 3'b101;
      16'b0100000000000000: n1969 = 3'b101;
      16'b0010000000000000: n1969 = 3'b000;
      16'b0001000000000000: n1969 = 3'b101;
      16'b0000100000000000: n1969 = 3'b101;
      16'b0000010000000000: n1969 = 3'b100;
      16'b0000001000000000: n1969 = 3'b101;
      16'b0000000100000000: n1969 = 3'b101;
      16'b0000000010000000: n1969 = 3'b101;
      16'b0000000001000000: n1969 = 3'b101;
      16'b0000000000100000: n1969 = 3'b100;
      16'b0000000000010000: n1969 = 3'b101;
      16'b0000000000001000: n1969 = 3'b101;
      16'b0000000000000100: n1969 = 3'b101;
      16'b0000000000000010: n1969 = 3'b101;
      16'b0000000000000001: n1969 = 3'b101;
      default: n1969 = 3'b101;
    endcase
  /*# rtl/cpu68.vhd:1752:57 */
  always @*
    case (n1897)
      16'b1000000000000000: n1987 = 2'b01;
      16'b0100000000000000: n1987 = 2'b01;
      16'b0010000000000000: n1987 = 2'b11;
      16'b0001000000000000: n1987 = 2'b01;
      16'b0000100000000000: n1987 = 2'b10;
      16'b0000010000000000: n1987 = 2'b11;
      16'b0000001000000000: n1987 = 2'b10;
      16'b0000000100000000: n1987 = 2'b10;
      16'b0000000010000000: n1987 = 2'b01;
      16'b0000000001000000: n1987 = 2'b01;
      16'b0000000000100000: n1987 = 2'b10;
      16'b0000000000010000: n1987 = 2'b10;
      16'b0000000000001000: n1987 = 2'b10;
      16'b0000000000000100: n1987 = 2'b10;
      16'b0000000000000010: n1987 = 2'b10;
      16'b0000000000000001: n1987 = 2'b10;
      default: n1987 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:1752:57 */
  always @*
    case (n1897)
      16'b1000000000000000: n2005 = 6'b100101;
      16'b0100000000000000: n2005 = 6'b100101;
      16'b0010000000000000: n2005 = 6'b000010;
      16'b0001000000000000: n2005 = 6'b100101;
      16'b0000100000000000: n2005 = 6'b000010;
      16'b0000010000000000: n2005 = 6'b000010;
      16'b0000001000000000: n2005 = 6'b000010;
      16'b0000000100000000: n2005 = 6'b000010;
      16'b0000000010000000: n2005 = 6'b100101;
      16'b0000000001000000: n2005 = 6'b100101;
      16'b0000000000100000: n2005 = 6'b000011;
      16'b0000000000010000: n2005 = 6'b000011;
      16'b0000000000001000: n2005 = 6'b000010;
      16'b0000000000000100: n2005 = 6'b000010;
      16'b0000000000000010: n2005 = 6'b000010;
      16'b0000000000000001: n2005 = 6'b000010;
      default: n2005 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:1747:49 */
  assign n2007 = n1546 == 4'b0011;
  /*# rtl/cpu68.vhd:1903:69 */
  assign n2008 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:1904:65 */
  assign n2010 = n2008 == 4'b0000;
  /*# rtl/cpu68.vhd:1909:65 */
  assign n2012 = n2008 == 4'b0011;
  /*# rtl/cpu68.vhd:1914:65 */
  assign n2014 = n2008 == 4'b0100;
  /*# rtl/cpu68.vhd:1919:65 */
  assign n2016 = n2008 == 4'b0110;
  /*# rtl/cpu68.vhd:1924:65 */
  assign n2018 = n2008 == 4'b0111;
  /*# rtl/cpu68.vhd:1929:65 */
  assign n2020 = n2008 == 4'b1000;
  /*# rtl/cpu68.vhd:1934:65 */
  assign n2022 = n2008 == 4'b1001;
  /*# rtl/cpu68.vhd:1939:65 */
  assign n2024 = n2008 == 4'b1010;
  /*# rtl/cpu68.vhd:1944:65 */
  assign n2026 = n2008 == 4'b1011;
  /*# rtl/cpu68.vhd:1949:65 */
  assign n2028 = n2008 == 4'b1100;
  /*# rtl/cpu68.vhd:1954:65 */
  assign n2030 = n2008 == 4'b1101;
  /*# rtl/cpu68.vhd:1959:65 */
  assign n2032 = n2008 == 4'b1110;
  /*# rtl/cpu68.vhd:1964:65 */
  assign n2034 = n2008 == 4'b1111;
  /*# rtl/cpu68.vhd:1903:57 */
  assign n2035 = {n2034, n2032, n2030, n2028, n2026, n2024, n2022, n2020, n2018, n2016, n2014, n2012, n2010};
  /*# rtl/cpu68.vhd:1903:57 */
  always @*
    case (n2035)
      13'b1000000000000: n2050 = 3'b001;
      13'b0100000000000: n2050 = 3'b100;
      13'b0010000000000: n2050 = 3'b100;
      13'b0001000000000: n2050 = 3'b001;
      13'b0000100000000: n2050 = 3'b100;
      13'b0000010000000: n2050 = 3'b001;
      13'b0000001000000: n2050 = 3'b001;
      13'b0000000100000: n2050 = 3'b001;
      13'b0000000010000: n2050 = 3'b001;
      13'b0000000001000: n2050 = 3'b001;
      13'b0000000000100: n2050 = 3'b001;
      13'b0000000000010: n2050 = 3'b001;
      13'b0000000000001: n2050 = 3'b001;
      default: n2050 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1903:57 */
  always @*
    case (n2035)
      13'b1000000000000: n2065 = 2'b01;
      13'b0100000000000: n2065 = 2'b11;
      13'b0010000000000: n2065 = 2'b01;
      13'b0001000000000: n2065 = 2'b01;
      13'b0000100000000: n2065 = 2'b11;
      13'b0000010000000: n2065 = 2'b01;
      13'b0000001000000: n2065 = 2'b01;
      13'b0000000100000: n2065 = 2'b01;
      13'b0000000010000: n2065 = 2'b01;
      13'b0000000001000: n2065 = 2'b01;
      13'b0000000000100: n2065 = 2'b01;
      13'b0000000000010: n2065 = 2'b01;
      13'b0000000000001: n2065 = 2'b01;
      default: n2065 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1903:57 */
  always @*
    case (n2035)
      13'b1000000000000: n2080 = 2'b01;
      13'b0100000000000: n2080 = 2'b01;
      13'b0010000000000: n2080 = 2'b01;
      13'b0001000000000: n2080 = 2'b10;
      13'b0000100000000: n2080 = 2'b01;
      13'b0000010000000: n2080 = 2'b10;
      13'b0000001000000: n2080 = 2'b01;
      13'b0000000100000: n2080 = 2'b01;
      13'b0000000010000: n2080 = 2'b01;
      13'b0000000001000: n2080 = 2'b01;
      13'b0000000000100: n2080 = 2'b01;
      13'b0000000000010: n2080 = 2'b01;
      13'b0000000000001: n2080 = 2'b01;
      default: n2080 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:1903:57 */
  always @*
    case (n2035)
      13'b1000000000000: n2095 = 6'b001100;
      13'b0100000000000: n2095 = 6'b100101;
      13'b0010000000000: n2095 = 6'b100010;
      13'b0001000000000: n2095 = 6'b001010;
      13'b0000100000000: n2095 = 6'b100101;
      13'b0000010000000: n2095 = 6'b001011;
      13'b0000001000000: n2095 = 6'b010101;
      13'b0000000100000: n2095 = 6'b010111;
      13'b0000000010000: n2095 = 6'b010110;
      13'b0000000001000: n2095 = 6'b010100;
      13'b0000000000100: n2095 = 6'b011000;
      13'b0000000000010: n2095 = 6'b001110;
      13'b0000000000001: n2095 = 6'b001101;
      default: n2095 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:1896:49 */
  assign n2097 = n1546 == 4'b0100;
  /*# rtl/cpu68.vhd:1987:69 */
  assign n2098 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:1988:65 */
  assign n2100 = n2098 == 4'b0000;
  /*# rtl/cpu68.vhd:1993:65 */
  assign n2102 = n2098 == 4'b0011;
  /*# rtl/cpu68.vhd:1998:65 */
  assign n2104 = n2098 == 4'b0100;
  /*# rtl/cpu68.vhd:2003:65 */
  assign n2106 = n2098 == 4'b0110;
  /*# rtl/cpu68.vhd:2008:65 */
  assign n2108 = n2098 == 4'b0111;
  /*# rtl/cpu68.vhd:2013:65 */
  assign n2110 = n2098 == 4'b1000;
  /*# rtl/cpu68.vhd:2018:65 */
  assign n2112 = n2098 == 4'b1001;
  /*# rtl/cpu68.vhd:2023:65 */
  assign n2114 = n2098 == 4'b1010;
  /*# rtl/cpu68.vhd:2028:65 */
  assign n2116 = n2098 == 4'b1011;
  /*# rtl/cpu68.vhd:2033:65 */
  assign n2118 = n2098 == 4'b1100;
  /*# rtl/cpu68.vhd:2038:65 */
  assign n2120 = n2098 == 4'b1101;
  /*# rtl/cpu68.vhd:2043:65 */
  assign n2122 = n2098 == 4'b1110;
  /*# rtl/cpu68.vhd:2048:65 */
  assign n2124 = n2098 == 4'b1111;
  /*# rtl/cpu68.vhd:1987:57 */
  assign n2125 = {n2124, n2122, n2120, n2118, n2116, n2114, n2112, n2110, n2108, n2106, n2104, n2102, n2100};
  /*# rtl/cpu68.vhd:1987:57 */
  always @*
    case (n2125)
      13'b1000000000000: n2140 = 2'b01;
      13'b0100000000000: n2140 = 2'b11;
      13'b0010000000000: n2140 = 2'b11;
      13'b0001000000000: n2140 = 2'b01;
      13'b0000100000000: n2140 = 2'b11;
      13'b0000010000000: n2140 = 2'b01;
      13'b0000001000000: n2140 = 2'b01;
      13'b0000000100000: n2140 = 2'b01;
      13'b0000000010000: n2140 = 2'b01;
      13'b0000000001000: n2140 = 2'b01;
      13'b0000000000100: n2140 = 2'b01;
      13'b0000000000010: n2140 = 2'b01;
      13'b0000000000001: n2140 = 2'b01;
      default: n2140 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1987:57 */
  always @*
    case (n2125)
      13'b1000000000000: n2155 = 2'b01;
      13'b0100000000000: n2155 = 2'b11;
      13'b0010000000000: n2155 = 2'b01;
      13'b0001000000000: n2155 = 2'b01;
      13'b0000100000000: n2155 = 2'b11;
      13'b0000010000000: n2155 = 2'b01;
      13'b0000001000000: n2155 = 2'b01;
      13'b0000000100000: n2155 = 2'b01;
      13'b0000000010000: n2155 = 2'b01;
      13'b0000000001000: n2155 = 2'b01;
      13'b0000000000100: n2155 = 2'b01;
      13'b0000000000010: n2155 = 2'b01;
      13'b0000000000001: n2155 = 2'b01;
      default: n2155 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1987:57 */
  always @*
    case (n2125)
      13'b1000000000000: n2170 = 2'b01;
      13'b0100000000000: n2170 = 2'b01;
      13'b0010000000000: n2170 = 2'b01;
      13'b0001000000000: n2170 = 2'b10;
      13'b0000100000000: n2170 = 2'b01;
      13'b0000010000000: n2170 = 2'b10;
      13'b0000001000000: n2170 = 2'b01;
      13'b0000000100000: n2170 = 2'b01;
      13'b0000000010000: n2170 = 2'b01;
      13'b0000000001000: n2170 = 2'b01;
      13'b0000000000100: n2170 = 2'b01;
      13'b0000000000010: n2170 = 2'b01;
      13'b0000000000001: n2170 = 2'b01;
      default: n2170 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:1987:57 */
  always @*
    case (n2125)
      13'b1000000000000: n2185 = 6'b001100;
      13'b0100000000000: n2185 = 6'b100101;
      13'b0010000000000: n2185 = 6'b100010;
      13'b0001000000000: n2185 = 6'b001010;
      13'b0000100000000: n2185 = 6'b100101;
      13'b0000010000000: n2185 = 6'b001011;
      13'b0000001000000: n2185 = 6'b010101;
      13'b0000000100000: n2185 = 6'b010111;
      13'b0000000010000: n2185 = 6'b010110;
      13'b0000000001000: n2185 = 6'b010100;
      13'b0000000000100: n2185 = 6'b011000;
      13'b0000000000010: n2185 = 6'b001110;
      13'b0000000000001: n2185 = 6'b001101;
      default: n2185 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:1980:49 */
  assign n2187 = n1546 == 4'b0101;
  /*# rtl/cpu68.vhd:2065:49 */
  assign n2189 = n1546 == 4'b0110;
  /*# rtl/cpu68.vhd:2083:49 */
  assign n2191 = n1546 == 4'b0111;
  /*# rtl/cpu68.vhd:2109:69 */
  assign n2192 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2110:65 */
  assign n2194 = n2192 == 4'b0011;
  /*# rtl/cpu68.vhd:2110:77 */
  assign n2196 = n2192 == 4'b1100;
  /*# rtl/cpu68.vhd:2110:77 */
  assign n2197 = n2194 | n2196;
  /*# rtl/cpu68.vhd:2111:80 */
  assign n2199 = n2192 == 4'b1110;
  /*# rtl/cpu68.vhd:2111:80 */
  assign n2200 = n2197 | n2199;
  /*# rtl/cpu68.vhd:2114:65 */
  assign n2202 = n2192 == 4'b1101;
  /*# rtl/cpu68.vhd:2109:57 */
  assign n2203 = {n2202, n2200};
  /*# rtl/cpu68.vhd:2109:57 */
  always @*
    case (n2203)
      2'b10: n2207 = 7'b1000110;
      2'b01: n2207 = 7'b0000111;
      default: n2207 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:2109:57 */
  always @*
    case (n2203)
      2'b10: n2210 = 3'b001;
      2'b01: n2210 = 3'b011;
      default: n2210 = 3'b011;
    endcase
  /*# rtl/cpu68.vhd:2109:57 */
  always @*
    case (n2203)
      2'b10: n2214 = 2'b11;
      2'b01: n2214 = 2'b11;
      default: n2214 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:2109:57 */
  always @*
    case (n2203)
      2'b10: n2218 = 3'b000;
      2'b01: n2218 = 3'b000;
      default: n2218 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:2109:57 */
  always @*
    case (n2203)
      2'b10: n2222 = 2'b01;
      2'b01: n2222 = 2'b01;
      default: n2222 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:2109:57 */
  always @*
    case (n2203)
      2'b10: n2226 = 6'b100101;
      2'b01: n2226 = 6'b100101;
      default: n2226 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:2097:49 */
  assign n2229 = n1546 == 4'b1000;
  /*# rtl/cpu68.vhd:2132:69 */
  assign n2230 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2133:65 */
  assign n2232 = n2230 == 4'b0111;
  /*# rtl/cpu68.vhd:2140:65 */
  assign n2234 = n2230 == 4'b1111;
  /*# rtl/cpu68.vhd:2147:65 */
  assign n2236 = n2230 == 4'b1101;
  /*# rtl/cpu68.vhd:2132:57 */
  assign n2237 = {n2236, n2234, n2232};
  /*# rtl/cpu68.vhd:2132:57 */
  always @*
    case (n2237)
      3'b100: n2242 = 7'b0011001;
      3'b010: n2242 = 7'b0111111;
      3'b001: n2242 = 7'b0111101;
      default: n2242 = 7'b0000101;
    endcase
  /*# rtl/cpu68.vhd:2132:57 */
  always @*
    case (n2237)
      3'b100: n2247 = 3'b011;
      3'b010: n2247 = 3'b010;
      3'b001: n2247 = 3'b010;
      default: n2247 = 3'b011;
    endcase
  /*# rtl/cpu68.vhd:2132:57 */
  always @*
    case (n2237)
      3'b100: n2252 = 3'b000;
      3'b010: n2252 = 3'b101;
      3'b001: n2252 = 3'b000;
      default: n2252 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:2132:57 */
  always @*
    case (n2237)
      3'b100: n2257 = 6'b100101;
      3'b010: n2257 = 6'b100100;
      3'b001: n2257 = 6'b100010;
      default: n2257 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:2125:49 */
  assign n2259 = n1546 == 4'b1001;
  /*# rtl/cpu68.vhd:2163:49 */
  assign n2261 = n1546 == 4'b1010;
  /*# rtl/cpu68.vhd:2177:49 */
  assign n2263 = n1546 == 4'b1011;
  /*# rtl/cpu68.vhd:2203:69 */
  assign n2264 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2204:65 */
  assign n2266 = n2264 == 4'b0011;
  /*# rtl/cpu68.vhd:2204:77 */
  assign n2268 = n2264 == 4'b1100;
  /*# rtl/cpu68.vhd:2204:77 */
  assign n2269 = n2266 | n2268;
  /*# rtl/cpu68.vhd:2205:80 */
  assign n2271 = n2264 == 4'b1110;
  /*# rtl/cpu68.vhd:2205:80 */
  assign n2272 = n2269 | n2271;
  /*# rtl/cpu68.vhd:2203:57 */
  always @*
    case (n2272)
      1'b1: n2275 = 7'b0000111;
      default: n2275 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:2191:49 */
  assign n2277 = n1546 == 4'b1100;
  /*# rtl/cpu68.vhd:2219:69 */
  assign n2278 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2220:65 */
  assign n2280 = n2278 == 4'b0111;
  /*# rtl/cpu68.vhd:2227:65 */
  assign n2282 = n2278 == 4'b1101;
  /*# rtl/cpu68.vhd:2234:65 */
  assign n2284 = n2278 == 4'b1111;
  /*# rtl/cpu68.vhd:2219:57 */
  assign n2285 = {n2284, n2282, n2280};
  /*# rtl/cpu68.vhd:2219:57 */
  always @*
    case (n2285)
      3'b100: n2290 = 7'b0111111;
      3'b010: n2290 = 7'b0111111;
      3'b001: n2290 = 7'b0111101;
      default: n2290 = 7'b0000101;
    endcase
  /*# rtl/cpu68.vhd:2219:57 */
  always @*
    case (n2285)
      3'b100: n2295 = 3'b010;
      3'b010: n2295 = 3'b010;
      3'b001: n2295 = 3'b010;
      default: n2295 = 3'b011;
    endcase
  /*# rtl/cpu68.vhd:2219:57 */
  always @*
    case (n2285)
      3'b100: n2300 = 3'b100;
      3'b010: n2300 = 3'b010;
      3'b001: n2300 = 3'b001;
      default: n2300 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:2219:57 */
  always @*
    case (n2285)
      3'b100: n2305 = 6'b100100;
      3'b010: n2305 = 6'b100100;
      3'b001: n2305 = 6'b100010;
      default: n2305 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:2212:49 */
  assign n2307 = n1546 == 4'b1101;
  /*# rtl/cpu68.vhd:2250:49 */
  assign n2309 = n1546 == 4'b1110;
  /*# rtl/cpu68.vhd:2264:49 */
  assign n2311 = n1546 == 4'b1111;
  /*# rtl/cpu68.vhd:1460:41 */
  assign n2312 = {n2311, n2309, n2307, n2277, n2263, n2261, n2259, n2229, n2191, n2189, n2187, n2097, n2007, n1863, n1744, n1696};
  /*# rtl/cpu68.vhd:1460:41 */
  always @*
    case (n2312)
      16'b1000000000000000: n2323 = 7'b0000011;
      16'b0100000000000000: n2323 = 7'b0000100;
      16'b0010000000000000: n2323 = n2290;
      16'b0001000000000000: n2323 = n2275;
      16'b0000100000000000: n2323 = 7'b0000011;
      16'b0000010000000000: n2323 = 7'b0000100;
      16'b0000001000000000: n2323 = n2242;
      16'b0000000100000000: n2323 = n2207;
      16'b0000000010000000: n2323 = 7'b0000011;
      16'b0000000001000000: n2323 = 7'b0000100;
      16'b0000000000100000: n2323 = 7'b0000001;
      16'b0000000000010000: n2323 = 7'b0000001;
      16'b0000000000001000: n2323 = n1915;
      16'b0000000000000100: n2323 = n1861;
      16'b0000000000000010: n2323 = 7'b0000001;
      16'b0000000000000001: n2323 = n1589;
      default: n2323 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:1460:41 */
  always @*
    case (n2312)
      16'b1000000000000000: n2341 = 3'b110;
      16'b0100000000000000: n2341 = 3'b110;
      16'b0010000000000000: n2341 = 3'b110;
      16'b0001000000000000: n2341 = 3'b110;
      16'b0000100000000000: n2341 = 3'b110;
      16'b0000010000000000: n2341 = 3'b110;
      16'b0000001000000000: n2341 = 3'b110;
      16'b0000000100000000: n2341 = 3'b110;
      16'b0000000010000000: n2341 = 3'b110;
      16'b0000000001000000: n2341 = 3'b110;
      16'b0000000000100000: n2341 = 3'b001;
      16'b0000000000010000: n2341 = 3'b001;
      16'b0000000000001000: n2341 = 3'b001;
      16'b0000000000000100: n2341 = 3'b110;
      16'b0000000000000010: n2341 = 3'b001;
      16'b0000000000000001: n2341 = 3'b001;
      default: n2341 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:1460:41 */
  always @*
    case (n2312)
      16'b1000000000000000: n2356 = 3'b011;
      16'b0100000000000000: n2356 = 3'b011;
      16'b0010000000000000: n2356 = n2295;
      16'b0001000000000000: n2356 = 3'b011;
      16'b0000100000000000: n2356 = 3'b011;
      16'b0000010000000000: n2356 = 3'b011;
      16'b0000001000000000: n2356 = n2247;
      16'b0000000100000000: n2356 = n2210;
      16'b0000000010000000: n2356 = 3'b011;
      16'b0000000001000000: n2356 = 3'b011;
      16'b0000000000100000: n2356 = 3'b011;
      16'b0000000000010000: n2356 = 3'b011;
      16'b0000000000001000: n2356 = 3'b011;
      16'b0000000000000100: n2356 = 3'b011;
      16'b0000000000000010: n2356 = 3'b011;
      16'b0000000000000001: n2356 = 3'b011;
      default: n2356 = 3'b011;
    endcase
  /*# rtl/cpu68.vhd:1460:41 */
  always @*
    case (n2312)
      16'b1000000000000000: n2371 = 3'b100;
      16'b0100000000000000: n2371 = 3'b100;
      16'b0010000000000000: n2371 = 3'b100;
      16'b0001000000000000: n2371 = 3'b100;
      16'b0000100000000000: n2371 = 3'b100;
      16'b0000010000000000: n2371 = 3'b100;
      16'b0000001000000000: n2371 = 3'b100;
      16'b0000000100000000: n2371 = 3'b100;
      16'b0000000010000000: n2371 = 3'b100;
      16'b0000000001000000: n2371 = 3'b100;
      16'b0000000000100000: n2371 = 3'b100;
      16'b0000000000010000: n2371 = n2050;
      16'b0000000000001000: n2371 = 3'b100;
      16'b0000000000000100: n2371 = 3'b100;
      16'b0000000000000010: n2371 = n1718;
      16'b0000000000000001: n2371 = n1604;
      default: n2371 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1460:41 */
  always @*
    case (n2312)
      16'b1000000000000000: n2386 = 2'b11;
      16'b0100000000000000: n2386 = 2'b11;
      16'b0010000000000000: n2386 = 2'b11;
      16'b0001000000000000: n2386 = 2'b11;
      16'b0000100000000000: n2386 = 2'b11;
      16'b0000010000000000: n2386 = 2'b11;
      16'b0000001000000000: n2386 = 2'b11;
      16'b0000000100000000: n2386 = 2'b11;
      16'b0000000010000000: n2386 = 2'b11;
      16'b0000000001000000: n2386 = 2'b11;
      16'b0000000000100000: n2386 = n2140;
      16'b0000000000010000: n2386 = 2'b11;
      16'b0000000000001000: n2386 = 2'b11;
      16'b0000000000000100: n2386 = 2'b11;
      16'b0000000000000010: n2386 = n1726;
      16'b0000000000000001: n2386 = n1619;
      default: n2386 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1460:41 */
  always @*
    case (n2312)
      16'b1000000000000000: n2402 = 3'b100;
      16'b0100000000000000: n2402 = 3'b100;
      16'b0010000000000000: n2402 = 3'b100;
      16'b0001000000000000: n2402 = 3'b100;
      16'b0000100000000000: n2402 = 3'b100;
      16'b0000010000000000: n2402 = 3'b100;
      16'b0000001000000000: n2402 = 3'b100;
      16'b0000000100000000: n2402 = 3'b100;
      16'b0000000010000000: n2402 = 3'b100;
      16'b0000000001000000: n2402 = 3'b100;
      16'b0000000000100000: n2402 = 3'b100;
      16'b0000000000010000: n2402 = 3'b100;
      16'b0000000000001000: n2402 = n1933;
      16'b0000000000000100: n2402 = 3'b100;
      16'b0000000000000010: n2402 = 3'b100;
      16'b0000000000000001: n2402 = n1634;
      default: n2402 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:1460:41 */
  always @*
    case (n2312)
      16'b1000000000000000: n2415 = 2'b11;
      16'b0100000000000000: n2415 = 2'b11;
      16'b0010000000000000: n2415 = 2'b11;
      16'b0001000000000000: n2415 = 2'b11;
      16'b0000100000000000: n2415 = 2'b11;
      16'b0000010000000000: n2415 = 2'b11;
      16'b0000001000000000: n2415 = 2'b11;
      16'b0000000100000000: n2415 = n2214;
      16'b0000000010000000: n2415 = 2'b11;
      16'b0000000001000000: n2415 = 2'b11;
      16'b0000000000100000: n2415 = n2155;
      16'b0000000000010000: n2415 = n2065;
      16'b0000000000001000: n2415 = 2'b11;
      16'b0000000000000100: n2415 = 2'b11;
      16'b0000000000000010: n2415 = n1734;
      16'b0000000000000001: n2415 = n1649;
      default: n2415 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:1460:41 */
  always @*
    case (n2312)
      16'b1000000000000000: n2432 = 2'b01;
      16'b0100000000000000: n2432 = 2'b01;
      16'b0010000000000000: n2432 = 2'b01;
      16'b0001000000000000: n2432 = 2'b01;
      16'b0000100000000000: n2432 = 2'b01;
      16'b0000010000000000: n2432 = 2'b01;
      16'b0000001000000000: n2432 = 2'b01;
      16'b0000000100000000: n2432 = 2'b01;
      16'b0000000010000000: n2432 = 2'b01;
      16'b0000000001000000: n2432 = 2'b01;
      16'b0000000000100000: n2432 = 2'b01;
      16'b0000000000010000: n2432 = 2'b01;
      16'b0000000000001000: n2432 = n1951;
      16'b0000000000000100: n2432 = 2'b01;
      16'b0000000000000010: n2432 = 2'b01;
      16'b0000000000000001: n2432 = 2'b01;
      default: n2432 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:1460:41 */
  always @*
    case (n2312)
      16'b1000000000000000: n2445 = 3'b000;
      16'b0100000000000000: n2445 = 3'b000;
      16'b0010000000000000: n2445 = n2300;
      16'b0001000000000000: n2445 = 3'b000;
      16'b0000100000000000: n2445 = 3'b000;
      16'b0000010000000000: n2445 = 3'b000;
      16'b0000001000000000: n2445 = n2252;
      16'b0000000100000000: n2445 = n2218;
      16'b0000000010000000: n2445 = 3'b000;
      16'b0000000001000000: n2445 = 3'b000;
      16'b0000000000100000: n2445 = 3'b001;
      16'b0000000000010000: n2445 = 3'b000;
      16'b0000000000001000: n2445 = n1969;
      16'b0000000000000100: n2445 = 3'b000;
      16'b0000000000000010: n2445 = 3'b000;
      16'b0000000000000001: n2445 = n1664;
      default: n2445 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:1460:41 */
  always @*
    case (n2312)
      16'b1000000000000000: n2458 = 2'b01;
      16'b0100000000000000: n2458 = 2'b01;
      16'b0010000000000000: n2458 = 2'b01;
      16'b0001000000000000: n2458 = 2'b01;
      16'b0000100000000000: n2458 = 2'b01;
      16'b0000010000000000: n2458 = 2'b01;
      16'b0000001000000000: n2458 = 2'b01;
      16'b0000000100000000: n2458 = n2222;
      16'b0000000010000000: n2458 = 2'b01;
      16'b0000000001000000: n2458 = 2'b01;
      16'b0000000000100000: n2458 = n2170;
      16'b0000000000010000: n2458 = n2080;
      16'b0000000000001000: n2458 = n1987;
      16'b0000000000000100: n2458 = 2'b01;
      16'b0000000000000010: n2458 = 2'b11;
      16'b0000000000000001: n2458 = n1679;
      default: n2458 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:1460:41 */
  always @*
    case (n2312)
      16'b1000000000000000: n2468 = 6'b100101;
      16'b0100000000000000: n2468 = 6'b100101;
      16'b0010000000000000: n2468 = n2305;
      16'b0001000000000000: n2468 = 6'b100101;
      16'b0000100000000000: n2468 = 6'b100101;
      16'b0000010000000000: n2468 = 6'b100101;
      16'b0000001000000000: n2468 = n2257;
      16'b0000000100000000: n2468 = n2226;
      16'b0000000010000000: n2468 = 6'b100101;
      16'b0000000001000000: n2468 = 6'b100101;
      16'b0000000000100000: n2468 = n2185;
      16'b0000000000010000: n2468 = n2095;
      16'b0000000000001000: n2468 = n2005;
      16'b0000000000000100: n2468 = 6'b100101;
      16'b0000000000000010: n2468 = n1742;
      16'b0000000000000001: n2468 = n1694;
      default: n2468 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:1452:33 */
  assign n2470 = state == 7'b0000010;
  /*# rtl/cpu68.vhd:2293:33 */
  assign n2472 = state == 7'b0000111;
  /*# rtl/cpu68.vhd:2334:53 */
  assign n2473 = op_code[7:4]; // extract
  /*# rtl/cpu68.vhd:2341:69 */
  assign n2474 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2342:65 */
  assign n2476 = n2474 == 4'b1011;
  /*# rtl/cpu68.vhd:2344:65 */
  assign n2478 = n2474 == 4'b1110;
  /*# rtl/cpu68.vhd:2341:57 */
  assign n2479 = {n2478, n2476};
  /*# rtl/cpu68.vhd:2341:57 */
  always @*
    case (n2479)
      2'b10: n2483 = 7'b0011000;
      2'b01: n2483 = 7'b0000001;
      default: n2483 = 7'b0000101;
    endcase
  /*# rtl/cpu68.vhd:2335:49 */
  assign n2485 = n2473 == 4'b0110;
  /*# rtl/cpu68.vhd:2350:69 */
  assign n2486 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2351:65 */
  assign n2488 = n2486 == 4'b0111;
  /*# rtl/cpu68.vhd:2358:65 */
  assign n2490 = n2486 == 4'b1101;
  /*# rtl/cpu68.vhd:2365:65 */
  assign n2492 = n2486 == 4'b1111;
  /*# rtl/cpu68.vhd:2350:57 */
  assign n2493 = {n2492, n2490, n2488};
  /*# rtl/cpu68.vhd:2350:57 */
  always @*
    case (n2493)
      3'b100: n2498 = 7'b1000000;
      3'b010: n2498 = 7'b1000011;
      3'b001: n2498 = 7'b0111110;
      default: n2498 = 7'b1000001;
    endcase
  /*# rtl/cpu68.vhd:2350:57 */
  always @*
    case (n2493)
      3'b100: n2503 = 3'b010;
      3'b010: n2503 = 3'b001;
      3'b001: n2503 = 3'b010;
      default: n2503 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:2350:57 */
  always @*
    case (n2493)
      3'b100: n2508 = 3'b101;
      3'b010: n2508 = 3'b000;
      3'b001: n2508 = 3'b000;
      default: n2508 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:2350:57 */
  always @*
    case (n2493)
      3'b100: n2513 = 6'b100100;
      3'b010: n2513 = 6'b100101;
      3'b001: n2513 = 6'b100010;
      default: n2513 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:2349:49 */
  assign n2515 = n2473 == 4'b1010;
  /*# rtl/cpu68.vhd:2381:69 */
  assign n2516 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2382:65 */
  assign n2518 = n2516 == 4'b0111;
  /*# rtl/cpu68.vhd:2389:65 */
  assign n2520 = n2516 == 4'b1101;
  /*# rtl/cpu68.vhd:2396:65 */
  assign n2522 = n2516 == 4'b1111;
  /*# rtl/cpu68.vhd:2381:57 */
  assign n2523 = {n2522, n2520, n2518};
  /*# rtl/cpu68.vhd:2381:57 */
  always @*
    case (n2523)
      3'b100: n2528 = 7'b1000000;
      3'b010: n2528 = 7'b1000000;
      3'b001: n2528 = 7'b0111110;
      default: n2528 = 7'b1000001;
    endcase
  /*# rtl/cpu68.vhd:2381:57 */
  always @*
    case (n2523)
      3'b100: n2533 = 3'b010;
      3'b010: n2533 = 3'b010;
      3'b001: n2533 = 3'b010;
      default: n2533 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:2381:57 */
  always @*
    case (n2523)
      3'b100: n2538 = 3'b100;
      3'b010: n2538 = 3'b010;
      3'b001: n2538 = 3'b001;
      default: n2538 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:2381:57 */
  always @*
    case (n2523)
      3'b100: n2543 = 6'b100100;
      3'b010: n2543 = 6'b100100;
      3'b001: n2543 = 6'b100010;
      default: n2543 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:2380:49 */
  assign n2545 = n2473 == 4'b1110;
  /*# rtl/cpu68.vhd:2334:41 */
  assign n2546 = {n2545, n2515, n2485};
  /*# rtl/cpu68.vhd:2334:41 */
  always @*
    case (n2546)
      3'b100: n2548 = n2528;
      3'b010: n2548 = n2498;
      3'b001: n2548 = n2483;
      default: n2548 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:2334:41 */
  always @*
    case (n2546)
      3'b100: n2551 = n2533;
      3'b010: n2551 = n2503;
      3'b001: n2551 = 3'b001;
      default: n2551 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:2334:41 */
  always @*
    case (n2546)
      3'b100: n2554 = n2538;
      3'b010: n2554 = n2508;
      3'b001: n2554 = 3'b000;
      default: n2554 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:2334:41 */
  always @*
    case (n2546)
      3'b100: n2557 = n2543;
      3'b010: n2557 = n2513;
      3'b001: n2557 = 6'b100101;
      default: n2557 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:2318:33 */
  assign n2559 = state == 7'b0000100;
  /*# rtl/cpu68.vhd:2440:53 */
  assign n2560 = op_code[7:4]; // extract
  /*# rtl/cpu68.vhd:2447:69 */
  assign n2561 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2448:65 */
  assign n2563 = n2561 == 4'b1011;
  /*# rtl/cpu68.vhd:2450:65 */
  assign n2565 = n2561 == 4'b1110;
  /*# rtl/cpu68.vhd:2447:57 */
  assign n2566 = {n2565, n2563};
  /*# rtl/cpu68.vhd:2447:57 */
  always @*
    case (n2566)
      2'b10: n2570 = 7'b0000001;
      2'b01: n2570 = 7'b0000001;
      default: n2570 = 7'b0000101;
    endcase
  /*# rtl/cpu68.vhd:2447:57 */
  always @*
    case (n2566)
      2'b10: n2573 = 3'b111;
      2'b01: n2573 = 3'b110;
      default: n2573 = 3'b110;
    endcase
  /*# rtl/cpu68.vhd:2441:49 */
  assign n2575 = n2560 == 4'b0111;
  /*# rtl/cpu68.vhd:2457:69 */
  assign n2576 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2458:65 */
  assign n2578 = n2576 == 4'b0111;
  /*# rtl/cpu68.vhd:2465:65 */
  assign n2580 = n2576 == 4'b1101;
  /*# rtl/cpu68.vhd:2472:65 */
  assign n2582 = n2576 == 4'b1111;
  /*# rtl/cpu68.vhd:2457:57 */
  assign n2583 = {n2582, n2580, n2578};
  /*# rtl/cpu68.vhd:2457:57 */
  always @*
    case (n2583)
      3'b100: n2588 = 7'b0111111;
      3'b010: n2588 = 7'b1000100;
      3'b001: n2588 = 7'b0111101;
      default: n2588 = 7'b0000101;
    endcase
  /*# rtl/cpu68.vhd:2457:57 */
  always @*
    case (n2583)
      3'b100: n2593 = 3'b010;
      3'b010: n2593 = 3'b001;
      3'b001: n2593 = 3'b010;
      default: n2593 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:2457:57 */
  always @*
    case (n2583)
      3'b100: n2598 = 3'b101;
      3'b010: n2598 = 3'b000;
      3'b001: n2598 = 3'b000;
      default: n2598 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:2457:57 */
  always @*
    case (n2583)
      3'b100: n2603 = 6'b100100;
      3'b010: n2603 = 6'b100101;
      3'b001: n2603 = 6'b100010;
      default: n2603 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:2456:49 */
  assign n2605 = n2560 == 4'b1011;
  /*# rtl/cpu68.vhd:2488:69 */
  assign n2606 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2489:65 */
  assign n2608 = n2606 == 4'b0111;
  /*# rtl/cpu68.vhd:2496:65 */
  assign n2610 = n2606 == 4'b1101;
  /*# rtl/cpu68.vhd:2503:65 */
  assign n2612 = n2606 == 4'b1111;
  /*# rtl/cpu68.vhd:2488:57 */
  assign n2613 = {n2612, n2610, n2608};
  /*# rtl/cpu68.vhd:2488:57 */
  always @*
    case (n2613)
      3'b100: n2618 = 7'b0111111;
      3'b010: n2618 = 7'b0111111;
      3'b001: n2618 = 7'b0111101;
      default: n2618 = 7'b0000101;
    endcase
  /*# rtl/cpu68.vhd:2488:57 */
  always @*
    case (n2613)
      3'b100: n2623 = 3'b010;
      3'b010: n2623 = 3'b010;
      3'b001: n2623 = 3'b010;
      default: n2623 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:2488:57 */
  always @*
    case (n2613)
      3'b100: n2628 = 3'b100;
      3'b010: n2628 = 3'b010;
      3'b001: n2628 = 3'b001;
      default: n2628 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:2488:57 */
  always @*
    case (n2613)
      3'b100: n2633 = 6'b100100;
      3'b010: n2633 = 6'b100100;
      3'b001: n2633 = 6'b100010;
      default: n2633 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:2487:49 */
  assign n2635 = n2560 == 4'b1111;
  /*# rtl/cpu68.vhd:2440:41 */
  assign n2636 = {n2635, n2605, n2575};
  /*# rtl/cpu68.vhd:2440:41 */
  always @*
    case (n2636)
      3'b100: n2638 = n2618;
      3'b010: n2638 = n2588;
      3'b001: n2638 = n2570;
      default: n2638 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:2440:41 */
  always @*
    case (n2636)
      3'b100: n2640 = 3'b110;
      3'b010: n2640 = 3'b110;
      3'b001: n2640 = n2573;
      default: n2640 = 3'b110;
    endcase
  /*# rtl/cpu68.vhd:2440:41 */
  always @*
    case (n2636)
      3'b100: n2644 = n2623;
      3'b010: n2644 = n2593;
      3'b001: n2644 = 3'b001;
      default: n2644 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:2440:41 */
  always @*
    case (n2636)
      3'b100: n2647 = n2628;
      3'b010: n2647 = n2598;
      3'b001: n2647 = 3'b000;
      default: n2647 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:2440:41 */
  always @*
    case (n2636)
      3'b100: n2650 = n2633;
      3'b010: n2650 = n2603;
      3'b001: n2650 = 6'b100101;
      default: n2650 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:2425:33 */
  assign n2652 = state == 7'b0000011;
  /*# rtl/cpu68.vhd:2544:53 */
  assign n2653 = op_code[7:4]; // extract
  /*# rtl/cpu68.vhd:2545:49 */
  assign n2655 = n2653 == 4'b0110;
  /*# rtl/cpu68.vhd:2545:61 */
  assign n2657 = n2653 == 4'b0111;
  /*# rtl/cpu68.vhd:2545:61 */
  assign n2658 = n2655 | n2657;
  /*# rtl/cpu68.vhd:2555:69 */
  assign n2659 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2556:65 */
  assign n2661 = n2659 == 4'b0011;
  /*# rtl/cpu68.vhd:2556:77 */
  assign n2663 = n2659 == 4'b1110;
  /*# rtl/cpu68.vhd:2556:77 */
  assign n2664 = n2661 | n2663;
  /*# rtl/cpu68.vhd:2557:80 */
  assign n2666 = n2659 == 4'b1100;
  /*# rtl/cpu68.vhd:2557:80 */
  assign n2667 = n2664 | n2666;
  /*# rtl/cpu68.vhd:2555:57 */
  always @*
    case (n2667)
      1'b1: n2670 = 7'b0000110;
      default: n2670 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:2555:57 */
  always @*
    case (n2667)
      1'b1: n2673 = 3'b100;
      default: n2673 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:2554:49 */
  assign n2675 = n2653 == 4'b1001;
  /*# rtl/cpu68.vhd:2554:61 */
  assign n2677 = n2653 == 4'b1010;
  /*# rtl/cpu68.vhd:2554:61 */
  assign n2678 = n2675 | n2677;
  /*# rtl/cpu68.vhd:2554:70 */
  assign n2680 = n2653 == 4'b1011;
  /*# rtl/cpu68.vhd:2554:70 */
  assign n2681 = n2678 | n2680;
  /*# rtl/cpu68.vhd:2602:69 */
  assign n2682 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:2603:65 */
  assign n2684 = n2682 == 4'b0011;
  /*# rtl/cpu68.vhd:2603:77 */
  assign n2686 = n2682 == 4'b1100;
  /*# rtl/cpu68.vhd:2603:77 */
  assign n2687 = n2684 | n2686;
  /*# rtl/cpu68.vhd:2604:80 */
  assign n2689 = n2682 == 4'b1110;
  /*# rtl/cpu68.vhd:2604:80 */
  assign n2690 = n2687 | n2689;
  /*# rtl/cpu68.vhd:2602:57 */
  always @*
    case (n2690)
      1'b1: n2693 = 7'b0000110;
      default: n2693 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:2602:57 */
  always @*
    case (n2690)
      1'b1: n2696 = 3'b100;
      default: n2696 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:2601:49 */
  assign n2698 = n2653 == 4'b1101;
  /*# rtl/cpu68.vhd:2601:61 */
  assign n2700 = n2653 == 4'b1110;
  /*# rtl/cpu68.vhd:2601:61 */
  assign n2701 = n2698 | n2700;
  /*# rtl/cpu68.vhd:2601:70 */
  assign n2703 = n2653 == 4'b1111;
  /*# rtl/cpu68.vhd:2601:70 */
  assign n2704 = n2701 | n2703;
  /*# rtl/cpu68.vhd:2544:41 */
  assign n2705 = {n2704, n2681, n2658};
  /*# rtl/cpu68.vhd:2544:41 */
  always @*
    case (n2705)
      3'b100: n2708 = n2693;
      3'b010: n2708 = n2670;
      3'b001: n2708 = 7'b0001010;
      default: n2708 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:2544:41 */
  always @*
    case (n2705)
      3'b100: n2711 = n2696;
      3'b010: n2711 = n2673;
      3'b001: n2711 = 3'b001;
      default: n2711 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:2532:33 */
  assign n2713 = state == 7'b0000101;
  /*# rtl/cpu68.vhd:2657:33 */
  assign n2715 = state == 7'b0000110;
  /*# rtl/cpu68.vhd:2684:33 */
  assign n2717 = state == 7'b0001001;
  /*# rtl/cpu68.vhd:2709:33 */
  assign n2719 = state == 7'b0001000;
  /*# rtl/cpu68.vhd:2731:33 */
  assign n2721 = state == 7'b0011000;
  /*# rtl/cpu68.vhd:2752:33 */
  assign n2723 = state == 7'b0011001;
  /*# rtl/cpu68.vhd:2774:33 */
  assign n2725 = state == 7'b0011010;
  /*# rtl/cpu68.vhd:2795:33 */
  assign n2727 = state == 7'b0011011;
  /*# rtl/cpu68.vhd:2817:33 */
  assign n2729 = state == 7'b0011100;
  /*# rtl/cpu68.vhd:2839:33 */
  assign n2731 = state == 7'b0011101;
  /*# rtl/cpu68.vhd:2861:33 */
  assign n2733 = state == 7'b0011110;
  /*# rtl/cpu68.vhd:2884:33 */
  assign n2735 = state == 7'b0011111;
  /*# rtl/cpu68.vhd:2906:33 */
  assign n2737 = state == 7'b0001101;
  /*# rtl/cpu68.vhd:2928:33 */
  assign n2739 = state == 7'b0001110;
  /*# rtl/cpu68.vhd:2951:33 */
  assign n2741 = state == 7'b0001111;
  /*# rtl/cpu68.vhd:2986:46 */
  assign n2742 = ea[0]; // extract
  /*# rtl/cpu68.vhd:2986:41 */
  assign n2745 = n2742 ? 3'b010 : 3'b100;
  /*# rtl/cpu68.vhd:2986:41 */
  assign n2748 = n2742 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:2986:41 */
  assign n2751 = n2742 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:2973:33 */
  assign n2753 = state == 7'b0010000;
  /*# rtl/cpu68.vhd:3014:46 */
  assign n2754 = ea[1]; // extract
  /*# rtl/cpu68.vhd:3014:41 */
  assign n2757 = n2754 ? 3'b010 : 3'b100;
  /*# rtl/cpu68.vhd:3014:41 */
  assign n2760 = n2754 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3014:41 */
  assign n2763 = n2754 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3001:33 */
  assign n2765 = state == 7'b0010001;
  /*# rtl/cpu68.vhd:3042:46 */
  assign n2766 = ea[2]; // extract
  /*# rtl/cpu68.vhd:3042:41 */
  assign n2769 = n2766 ? 3'b010 : 3'b100;
  /*# rtl/cpu68.vhd:3042:41 */
  assign n2772 = n2766 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3042:41 */
  assign n2775 = n2766 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3029:33 */
  assign n2777 = state == 7'b0010010;
  /*# rtl/cpu68.vhd:3070:46 */
  assign n2778 = ea[3]; // extract
  /*# rtl/cpu68.vhd:3070:41 */
  assign n2781 = n2778 ? 3'b010 : 3'b100;
  /*# rtl/cpu68.vhd:3070:41 */
  assign n2784 = n2778 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3070:41 */
  assign n2787 = n2778 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3057:33 */
  assign n2789 = state == 7'b0010011;
  /*# rtl/cpu68.vhd:3098:46 */
  assign n2790 = ea[4]; // extract
  /*# rtl/cpu68.vhd:3098:41 */
  assign n2793 = n2790 ? 3'b010 : 3'b100;
  /*# rtl/cpu68.vhd:3098:41 */
  assign n2796 = n2790 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3098:41 */
  assign n2799 = n2790 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3085:33 */
  assign n2801 = state == 7'b0010100;
  /*# rtl/cpu68.vhd:3126:46 */
  assign n2802 = ea[5]; // extract
  /*# rtl/cpu68.vhd:3126:41 */
  assign n2805 = n2802 ? 3'b010 : 3'b100;
  /*# rtl/cpu68.vhd:3126:41 */
  assign n2808 = n2802 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3126:41 */
  assign n2811 = n2802 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3113:33 */
  assign n2813 = state == 7'b0010101;
  /*# rtl/cpu68.vhd:3154:46 */
  assign n2814 = ea[6]; // extract
  /*# rtl/cpu68.vhd:3154:41 */
  assign n2817 = n2814 ? 3'b010 : 3'b100;
  /*# rtl/cpu68.vhd:3154:41 */
  assign n2820 = n2814 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3154:41 */
  assign n2823 = n2814 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3141:33 */
  assign n2825 = state == 7'b0010110;
  /*# rtl/cpu68.vhd:3182:46 */
  assign n2826 = ea[7]; // extract
  /*# rtl/cpu68.vhd:3182:41 */
  assign n2829 = n2826 ? 3'b010 : 3'b100;
  /*# rtl/cpu68.vhd:3182:41 */
  assign n2832 = n2826 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3182:41 */
  assign n2835 = n2826 ? 2'b01 : 2'b11;
  /*# rtl/cpu68.vhd:3169:33 */
  assign n2837 = state == 7'b0010111;
  /*# rtl/cpu68.vhd:3201:53 */
  assign n2838 = op_code[7:4]; // extract
  /*# rtl/cpu68.vhd:3215:69 */
  assign n2839 = op_code[3:0]; // extract
  /*# rtl/cpu68.vhd:3221:83 */
  assign n2840 = op_code[4]; // extract
  /*# rtl/cpu68.vhd:3221:87 */
  assign n2841 = ~n2840;
  /*# rtl/cpu68.vhd:3221:73 */
  assign n2844 = n2841 ? 7'b0111101 : 7'b0001000;
  /*# rtl/cpu68.vhd:3216:65 */
  assign n2846 = n2839 == 4'b0000;
  /*# rtl/cpu68.vhd:3231:83 */
  assign n2847 = op_code[4]; // extract
  /*# rtl/cpu68.vhd:3231:87 */
  assign n2848 = ~n2847;
  /*# rtl/cpu68.vhd:3231:73 */
  assign n2851 = n2848 ? 7'b0111101 : 7'b0001000;
  /*# rtl/cpu68.vhd:3226:65 */
  assign n2853 = n2839 == 4'b0011;
  /*# rtl/cpu68.vhd:3241:83 */
  assign n2854 = op_code[4]; // extract
  /*# rtl/cpu68.vhd:3241:87 */
  assign n2855 = ~n2854;
  /*# rtl/cpu68.vhd:3241:73 */
  assign n2858 = n2855 ? 7'b0111101 : 7'b0001000;
  /*# rtl/cpu68.vhd:3236:65 */
  assign n2860 = n2839 == 4'b0100;
  /*# rtl/cpu68.vhd:3251:83 */
  assign n2861 = op_code[4]; // extract
  /*# rtl/cpu68.vhd:3251:87 */
  assign n2862 = ~n2861;
  /*# rtl/cpu68.vhd:3251:73 */
  assign n2865 = n2862 ? 7'b0111101 : 7'b0001000;
  /*# rtl/cpu68.vhd:3246:65 */
  assign n2867 = n2839 == 4'b0110;
  /*# rtl/cpu68.vhd:3261:83 */
  assign n2868 = op_code[4]; // extract
  /*# rtl/cpu68.vhd:3261:87 */
  assign n2869 = ~n2868;
  /*# rtl/cpu68.vhd:3261:73 */
  assign n2872 = n2869 ? 7'b0111101 : 7'b0001000;
  /*# rtl/cpu68.vhd:3256:65 */
  assign n2874 = n2839 == 4'b0111;
  /*# rtl/cpu68.vhd:3271:83 */
  assign n2875 = op_code[4]; // extract
  /*# rtl/cpu68.vhd:3271:87 */
  assign n2876 = ~n2875;
  /*# rtl/cpu68.vhd:3271:73 */
  assign n2879 = n2876 ? 7'b0111101 : 7'b0001000;
  /*# rtl/cpu68.vhd:3266:65 */
  assign n2881 = n2839 == 4'b1000;
  /*# rtl/cpu68.vhd:3281:83 */
  assign n2882 = op_code[4]; // extract
  /*# rtl/cpu68.vhd:3281:87 */
  assign n2883 = ~n2882;
  /*# rtl/cpu68.vhd:3281:73 */
  assign n2886 = n2883 ? 7'b0111101 : 7'b0001000;
  /*# rtl/cpu68.vhd:3276:65 */
  assign n2888 = n2839 == 4'b1001;
  /*# rtl/cpu68.vhd:3291:83 */
  assign n2889 = op_code[4]; // extract
  /*# rtl/cpu68.vhd:3291:87 */
  assign n2890 = ~n2889;
  /*# rtl/cpu68.vhd:3291:73 */
  assign n2893 = n2890 ? 7'b0111101 : 7'b0001000;
  /*# rtl/cpu68.vhd:3286:65 */
  assign n2895 = n2839 == 4'b1010;
  /*# rtl/cpu68.vhd:3296:65 */
  assign n2897 = n2839 == 4'b1011;
  /*# rtl/cpu68.vhd:3307:83 */
  assign n2898 = op_code[4]; // extract
  /*# rtl/cpu68.vhd:3307:87 */
  assign n2899 = ~n2898;
  /*# rtl/cpu68.vhd:3307:73 */
  assign n2902 = n2899 ? 7'b0111101 : 7'b0001000;
  /*# rtl/cpu68.vhd:3302:65 */
  assign n2904 = n2839 == 4'b1100;
  /*# rtl/cpu68.vhd:3317:83 */
  assign n2905 = op_code[4]; // extract
  /*# rtl/cpu68.vhd:3317:87 */
  assign n2906 = ~n2905;
  /*# rtl/cpu68.vhd:3317:73 */
  assign n2909 = n2906 ? 7'b0111100 : 7'b0111011;
  /*# rtl/cpu68.vhd:3312:65 */
  assign n2911 = n2839 == 4'b1101;
  /*# rtl/cpu68.vhd:3322:65 */
  assign n2913 = n2839 == 4'b1110;
  /*# rtl/cpu68.vhd:3333:83 */
  assign n2914 = op_code[4]; // extract
  /*# rtl/cpu68.vhd:3333:87 */
  assign n2915 = ~n2914;
  /*# rtl/cpu68.vhd:3333:73 */
  assign n2918 = n2915 ? 7'b0111101 : 7'b0001000;
  /*# rtl/cpu68.vhd:3328:65 */
  assign n2920 = n2839 == 4'b1111;
  /*# rtl/cpu68.vhd:3215:57 */
  assign n2921 = {n2920, n2913, n2911, n2904, n2897, n2895, n2888, n2881, n2874, n2867, n2860, n2853, n2846};
  /*# rtl/cpu68.vhd:3215:57 */
  always @*
    case (n2921)
      13'b1000000000000: n2925 = n2918;
      13'b0100000000000: n2925 = 7'b0000001;
      13'b0010000000000: n2925 = n2909;
      13'b0001000000000: n2925 = n2902;
      13'b0000100000000: n2925 = 7'b0000001;
      13'b0000010000000: n2925 = n2893;
      13'b0000001000000: n2925 = n2886;
      13'b0000000100000: n2925 = n2879;
      13'b0000000010000: n2925 = n2872;
      13'b0000000001000: n2925 = n2865;
      13'b0000000000100: n2925 = n2858;
      13'b0000000000010: n2925 = n2851;
      13'b0000000000001: n2925 = n2844;
      default: n2925 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:3215:57 */
  always @*
    case (n2921)
      13'b1000000000000: n2940 = 3'b010;
      13'b0100000000000: n2940 = 3'b001;
      13'b0010000000000: n2940 = 3'b001;
      13'b0001000000000: n2940 = 3'b010;
      13'b0000100000000: n2940 = 3'b001;
      13'b0000010000000: n2940 = 3'b010;
      13'b0000001000000: n2940 = 3'b010;
      13'b0000000100000: n2940 = 3'b010;
      13'b0000000010000: n2940 = 3'b010;
      13'b0000000001000: n2940 = 3'b010;
      13'b0000000000100: n2940 = 3'b010;
      13'b0000000000010: n2940 = 3'b010;
      13'b0000000000001: n2940 = 3'b010;
      default: n2940 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:3215:57 */
  always @*
    case (n2921)
      13'b1000000000000: n2955 = 2'b01;
      13'b0100000000000: n2955 = 2'b11;
      13'b0010000000000: n2955 = 2'b01;
      13'b0001000000000: n2955 = 2'b01;
      13'b0000100000000: n2955 = 2'b11;
      13'b0000010000000: n2955 = 2'b01;
      13'b0000001000000: n2955 = 2'b01;
      13'b0000000100000: n2955 = 2'b01;
      13'b0000000010000: n2955 = 2'b01;
      13'b0000000001000: n2955 = 2'b01;
      13'b0000000000100: n2955 = 2'b01;
      13'b0000000000010: n2955 = 2'b01;
      13'b0000000000001: n2955 = 2'b01;
      default: n2955 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:3215:57 */
  always @*
    case (n2921)
      13'b1000000000000: n2970 = 2'b01;
      13'b0100000000000: n2970 = 2'b01;
      13'b0010000000000: n2970 = 2'b01;
      13'b0001000000000: n2970 = 2'b10;
      13'b0000100000000: n2970 = 2'b01;
      13'b0000010000000: n2970 = 2'b10;
      13'b0000001000000: n2970 = 2'b01;
      13'b0000000100000: n2970 = 2'b01;
      13'b0000000010000: n2970 = 2'b01;
      13'b0000000001000: n2970 = 2'b01;
      13'b0000000000100: n2970 = 2'b01;
      13'b0000000000010: n2970 = 2'b01;
      13'b0000000000001: n2970 = 2'b01;
      default: n2970 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:3215:57 */
  always @*
    case (n2921)
      13'b1000000000000: n2985 = 6'b001100;
      13'b0100000000000: n2985 = 6'b100101;
      13'b0010000000000: n2985 = 6'b100010;
      13'b0001000000000: n2985 = 6'b001010;
      13'b0000100000000: n2985 = 6'b100101;
      13'b0000010000000: n2985 = 6'b001011;
      13'b0000001000000: n2985 = 6'b010101;
      13'b0000000100000: n2985 = 6'b010111;
      13'b0000000010000: n2985 = 6'b010110;
      13'b0000000001000: n2985 = 6'b010100;
      13'b0000000000100: n2985 = 6'b011000;
      13'b0000000000010: n2985 = 6'b001110;
      13'b0000000000001: n2985 = 6'b001101;
      default: n2985 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:3202:49 */
  assign n2987 = n2838 == 4'b0110;
  /*# rtl/cpu68.vhd:3202:61 */
  assign n2989 = n2838 == 4'b0111;
  /*# rtl/cpu68.vhd:3202:61 */
  assign n2990 = n2987 | n2989;
  /*# rtl/cpu68.vhd:3201:41 */
  always @*
    case (n2990)
      1'b1: n2992 = n2925;
      default: n2992 = 7'b0000001;
    endcase
  /*# rtl/cpu68.vhd:3201:41 */
  always @*
    case (n2990)
      1'b1: n2994 = n2940;
      default: n2994 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:3201:41 */
  always @*
    case (n2990)
      1'b1: n2996 = n2955;
      default: n2996 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:3201:41 */
  always @*
    case (n2990)
      1'b1: n2999 = 3'b011;
      default: n2999 = 3'b010;
    endcase
  /*# rtl/cpu68.vhd:3201:41 */
  always @*
    case (n2990)
      1'b1: n3001 = n2970;
      default: n3001 = 2'b00;
    endcase
  /*# rtl/cpu68.vhd:3201:41 */
  always @*
    case (n2990)
      1'b1: n3003 = n2985;
      default: n3003 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:3197:33 */
  assign n3005 = state == 7'b0001010;
  /*# rtl/cpu68.vhd:3365:33 */
  assign n3007 = state == 7'b0110010;
  /*# rtl/cpu68.vhd:3387:33 */
  assign n3009 = state == 7'b0110001;
  /*# rtl/cpu68.vhd:3410:33 */
  assign n3011 = state == 7'b0110100;
  /*# rtl/cpu68.vhd:3432:33 */
  assign n3013 = state == 7'b0110011;
  /*# rtl/cpu68.vhd:3455:33 */
  assign n3015 = state == 7'b0110111;
  /*# rtl/cpu68.vhd:3478:33 */
  assign n3017 = state == 7'b0111000;
  /*# rtl/cpu68.vhd:3500:33 */
  assign n3019 = state == 7'b0110110;
  /*# rtl/cpu68.vhd:3522:33 */
  assign n3021 = state == 7'b0110101;
  /*# rtl/cpu68.vhd:3548:33 */
  assign n3023 = state == 7'b0101001;
  /*# rtl/cpu68.vhd:3570:33 */
  assign n3025 = state == 7'b0101010;
  /*# rtl/cpu68.vhd:3592:33 */
  assign n3027 = state == 7'b0101100;
  /*# rtl/cpu68.vhd:3614:33 */
  assign n3029 = state == 7'b0101011;
  /*# rtl/cpu68.vhd:3636:33 */
  assign n3031 = state == 7'b0101110;
  /*# rtl/cpu68.vhd:3658:33 */
  assign n3033 = state == 7'b0101101;
  /*# rtl/cpu68.vhd:3680:33 */
  assign n3035 = state == 7'b0110000;
  /*# rtl/cpu68.vhd:3703:33 */
  assign n3037 = state == 7'b0101111;
  /*# rtl/cpu68.vhd:3729:33 */
  assign n3039 = state == 7'b0100000;
  /*# rtl/cpu68.vhd:3751:33 */
  assign n3041 = state == 7'b0100001;
  /*# rtl/cpu68.vhd:3773:33 */
  assign n3043 = state == 7'b0100010;
  /*# rtl/cpu68.vhd:3795:33 */
  assign n3045 = state == 7'b0100011;
  /*# rtl/cpu68.vhd:3817:33 */
  assign n3047 = state == 7'b0100101;
  /*# rtl/cpu68.vhd:3838:33 */
  assign n3049 = state == 7'b0100110;
  /*# rtl/cpu68.vhd:3891:71 */
  assign n3050 = cc[4]; // extract
  /*# rtl/cpu68.vhd:3891:78 */
  assign n3051 = ~n3050;
  /*# rtl/cpu68.vhd:3891:64 */
  assign n3052 = n3051 & irq;
  /*# rtl/cpu68.vhd:3896:65 */
  assign n3054 = op_code == 8'b00111110;
  /*# rtl/cpu68.vhd:3899:65 */
  assign n3056 = op_code == 8'b00111111;
  /*# rtl/cpu68.vhd:3895:57 */
  assign n3057 = {n3056, n3054};
  /*# rtl/cpu68.vhd:3895:57 */
  always @*
    case (n3057)
      2'b10: n3061 = 7'b0111010;
      2'b01: n3061 = 7'b0100111;
      default: n3061 = 7'b0101001;
    endcase
  /*# rtl/cpu68.vhd:3895:57 */
  always @*
    case (n3057)
      2'b10: n3065 = 3'b010;
      2'b01: n3065 = 3'b001;
      default: n3065 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:3891:49 */
  assign n3067 = n3052 ? 7'b0101000 : n3061;
  /*# rtl/cpu68.vhd:3891:49 */
  assign n3069 = n3052 ? 3'b100 : n3065;
  /*# rtl/cpu68.vhd:3884:41 */
  assign n3071 = nmi_req ? 7'b0101000 : n3067;
  /*# rtl/cpu68.vhd:3884:41 */
  assign n3073 = nmi_req ? 3'b011 : n3069;
  /*# rtl/cpu68.vhd:3860:33 */
  assign n3075 = state == 7'b0100100;
  /*# rtl/cpu68.vhd:3927:73 */
  assign n3076 = ~nmi_ack;
  /*# rtl/cpu68.vhd:3927:60 */
  assign n3077 = n3076 & nmi_req;
  /*# rtl/cpu68.vhd:3935:61 */
  assign n3078 = ~nmi_req;
  /*# rtl/cpu68.vhd:3935:68 */
  assign n3079 = nmi_ack & n3078;
  /*# rtl/cpu68.vhd:3935:49 */
  assign n3082 = n3079 ? 2'b00 : 2'b10;
  /*# rtl/cpu68.vhd:3943:71 */
  assign n3083 = cc[4]; // extract
  /*# rtl/cpu68.vhd:3943:78 */
  assign n3084 = ~n3083;
  /*# rtl/cpu68.vhd:3943:64 */
  assign n3085 = n3084 & irq;
  /*# rtl/cpu68.vhd:3943:49 */
  assign n3088 = n3085 ? 7'b0101000 : 7'b0100111;
  /*# rtl/cpu68.vhd:3943:49 */
  assign n3091 = n3085 ? 3'b100 : 3'b001;
  /*# rtl/cpu68.vhd:3927:41 */
  assign n3093 = n3077 ? 7'b0111010 : n3088;
  /*# rtl/cpu68.vhd:3927:41 */
  assign n3095 = n3077 ? 3'b011 : n3091;
  /*# rtl/cpu68.vhd:3927:41 */
  assign n3097 = n3077 ? 2'b01 : n3082;
  /*# rtl/cpu68.vhd:3909:33 */
  assign n3099 = state == 7'b0100111;
  /*# rtl/cpu68.vhd:3952:33 */
  assign n3101 = state == 7'b0101000;
  /*# rtl/cpu68.vhd:3994:41 */
  assign n3104 = halt ? 7'b0001011 : 7'b0000001;
  /*# rtl/cpu68.vhd:3974:33 */
  assign n3106 = state == 7'b0001011;
  /*# rtl/cpu68.vhd:4000:33 */
  assign n3108 = state == 7'b0111100;
  /*# rtl/cpu68.vhd:4022:33 */
  assign n3110 = state == 7'b0111011;
  /*# rtl/cpu68.vhd:4044:33 */
  assign n3112 = state == 7'b0111110;
  /*# rtl/cpu68.vhd:4066:33 */
  assign n3114 = state == 7'b0111101;
  /*# rtl/cpu68.vhd:4088:33 */
  assign n3116 = state == 7'b1000000;
  /*# rtl/cpu68.vhd:4110:33 */
  assign n3118 = state == 7'b0111111;
  /*# rtl/cpu68.vhd:4132:33 */
  assign n3120 = state == 7'b1000001;
  /*# rtl/cpu68.vhd:4154:33 */
  assign n3122 = state == 7'b1000100;
  /*# rtl/cpu68.vhd:4173:33 */
  assign n3124 = state == 7'b1000011;
  /*# rtl/cpu68.vhd:4192:33 */
  assign n3126 = state == 7'b1000010;
  /*# rtl/cpu68.vhd:4211:33 */
  assign n3128 = state == 7'b1000110;
  /*# rtl/cpu68.vhd:4230:33 */
  assign n3130 = state == 7'b1000101;
  /*# rtl/cpu68.vhd:972:25 */
  assign n3131 = {n3130, n3128, n3126, n3124, n3122, n3120, n3118, n3116, n3114, n3112, n3110, n3108, n3106, n3101, n3099, n3075, n3049, n3047, n3045, n3043, n3041, n3039, n3037, n3035, n3033, n3031, n3029, n3027, n3025, n3023, n3021, n3019, n3017, n3015, n3013, n3011, n3009, n3007, n3005, n2837, n2825, n2813, n2801, n2789, n2777, n2765, n2753, n2741, n2739, n2737, n2735, n2733, n2731, n2729, n2727, n2725, n2723, n2721, n2719, n2717, n2715, n2713, n2652, n2559, n2472, n2470, n1545, n1148, n1146, n1144};
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3194 = 7'b0011100;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3194 = 7'b1000101;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3194 = 7'b0011001;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3194 = 7'b1000010;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3194 = 7'b1000011;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3194 = 7'b0000101;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3194 = 7'b0001001;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3194 = 7'b0111111;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3194 = 7'b0001000;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3194 = 7'b0111101;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3194 = 7'b0000001;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3194 = 7'b0111011;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3194 = n3104;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3194 = 7'b0111010;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3194 = n3093;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3194 = n3071;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3194 = 7'b0100100;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3194 = 7'b0100110;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3194 = 7'b0100101;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3194 = 7'b0100011;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3194 = 7'b0100010;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3194 = 7'b0100001;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3194 = 7'b0000001;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3194 = 7'b0101111;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3194 = 7'b0110000;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3194 = 7'b0101101;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3194 = 7'b0101110;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3194 = 7'b0101011;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3194 = 7'b0101100;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3194 = 7'b0101010;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3194 = 7'b0000001;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3194 = 7'b0110101;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3194 = 7'b0000001;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3194 = 7'b0111000;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3194 = 7'b0111011;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3194 = 7'b0111011;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3194 = 7'b0111011;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3194 = 7'b0111011;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3194 = n2992;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3194 = 7'b0111011;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3194 = 7'b0010111;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3194 = 7'b0010110;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3194 = 7'b0010101;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3194 = 7'b0010100;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3194 = 7'b0010011;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3194 = 7'b0010010;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3194 = 7'b0010001;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3194 = 7'b0010000;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3194 = 7'b0001111;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3194 = 7'b0001110;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3194 = 7'b0111011;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3194 = 7'b0011111;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3194 = 7'b0011011;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3194 = 7'b0011101;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3194 = 7'b0111011;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3194 = 7'b0011000;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3194 = 7'b0011010;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3194 = 7'b0000001;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3194 = 7'b0000001;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3194 = 7'b0001000;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3194 = 7'b0000001;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3194 = n2708;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3194 = n2638;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3194 = n2548;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3194 = 7'b0000001;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3194 = n2323;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3194 = n1536;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3194 = 7'b0000001;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3194 = 7'b0111001;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3194 = 7'b0111010;
      default: n3194 = 7'b0001100;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3263 = 3'b100;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3263 = 3'b101;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3263 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3263 = 3'b101;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3263 = 3'b011;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3263 = 3'b010;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3263 = n2640;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3263 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3263 = 3'b110;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3263 = n2341;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3263 = n1538;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3263 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3263 = 3'b101;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3263 = 3'b000;
      default: n3263 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3334 = 3'b011;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3334 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3334 = n2711;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3334 = 3'b110;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3334 = 3'b010;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3334 = 3'b101;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3334 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3334 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3334 = 3'b000;
      default: n3334 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3405 = n1540;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3405 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3405 = 2'b00;
      default: n3405 = 2'b10;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3473 = n2994;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3473 = 3'b101;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3473 = 3'b101;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3473 = 3'b101;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3473 = 3'b101;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3473 = 3'b101;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3473 = 3'b101;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3473 = 3'b101;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3473 = 3'b101;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3473 = 3'b010;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3473 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3473 = 3'b011;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3473 = n2644;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3473 = n2551;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3473 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3473 = n2356;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3473 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3473 = 3'b000;
      default: n3473 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3535 = 3'b011;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3535 = 3'b011;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3535 = n2829;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3535 = n2817;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3535 = n2805;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3535 = n2793;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3535 = n2781;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3535 = n2769;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3535 = n2757;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3535 = n2745;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3535 = 3'b010;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3535 = n2371;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3535 = n1482;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3535 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3535 = 3'b000;
      default: n3535 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3597 = 2'b10;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3597 = 2'b10;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3597 = n2832;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3597 = n2820;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3597 = n2808;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3597 = n2796;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3597 = n2784;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3597 = n2772;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3597 = n2760;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3597 = n2748;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3597 = 2'b01;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3597 = n2386;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3597 = n1485;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3597 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3597 = 2'b00;
      default: n3597 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3667 = 3'b010;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3667 = 3'b011;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3667 = 3'b010;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3667 = 3'b011;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3667 = n2402;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3667 = n1489;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3667 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3667 = 3'b000;
      default: n3667 = 3'b100;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3728 = 2'b01;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3728 = 2'b01;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3728 = 2'b10;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3728 = n2996;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3728 = n2835;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3728 = n2823;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3728 = n2811;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3728 = n2799;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3728 = n2787;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3728 = n2775;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3728 = n2763;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3728 = n2751;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3728 = n2415;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3728 = n1492;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3728 = 2'b11;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3728 = 2'b00;
      default: n3728 = 2'b11;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3798 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3798 = n2432;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3798 = n1496;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3798 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3798 = 2'b00;
      default: n3798 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3868 = n3095;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3868 = n3073;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3868 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3868 = 3'b000;
      default: n3868 = 3'b001;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n3935 = 3'b000;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n3935 = n2999;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n3935 = 3'b010;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n3935 = 3'b010;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n3935 = 3'b010;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n3935 = 3'b010;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n3935 = 3'b010;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n3935 = 3'b010;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n3935 = 3'b010;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n3935 = 3'b010;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n3935 = 3'b101;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n3935 = n2647;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n3935 = n2554;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n3935 = n2445;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n3935 = n1499;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n3935 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n3935 = 3'b000;
      default: n3935 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n4004 = n3001;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n4004 = 2'b00;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n4004 = 2'b00;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n4004 = 2'b00;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n4004 = 2'b00;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n4004 = 2'b00;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n4004 = 2'b00;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n4004 = 2'b00;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n4004 = 2'b00;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n4004 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n4004 = n2458;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n4004 = n1504;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n4004 = 2'b01;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n4004 = 2'b01;
      default: n4004 = 2'b01;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n4071 = 6'b011001;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n4071 = 6'b011010;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n4071 = 6'b000011;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n4071 = 6'b000011;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n4071 = 6'b000011;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n4071 = 6'b000011;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n4071 = 6'b000011;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n4071 = 6'b000011;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n4071 = 6'b000011;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n4071 = 6'b000011;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n4071 = 6'b000011;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n4071 = 6'b000011;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n4071 = 6'b000011;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n4071 = n3003;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n4071 = 6'b100001;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n4071 = 6'b100100;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n4071 = 6'b000010;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n4071 = 6'b000011;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n4071 = 6'b000011;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n4071 = 6'b000011;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n4071 = 6'b000011;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n4071 = n2650;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n4071 = n2557;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n4071 = n2468;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n4071 = n1507;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n4071 = 6'b100101;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n4071 = 6'b100101;
      default: n4071 = 6'b100101;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n4143 = 3'b100;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n4143 = 3'b100;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n4143 = 3'b100;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n4143 = 3'b100;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n4143 = 3'b100;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n4143 = 3'b100;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n4143 = 3'b100;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n4143 = 3'b100;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n4143 = 3'b100;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n4143 = 3'b100;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n4143 = 3'b100;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n4143 = 3'b101;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n4143 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n4143 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n4143 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n4143 = 3'b100;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n4143 = 3'b011;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n4143 = 3'b011;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n4143 = 3'b010;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n4143 = 3'b010;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n4143 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n4143 = 3'b000;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n4143 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n4143 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n4143 = 3'b001;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n4143 = 3'b111;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n4143 = 3'b110;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n4143 = 3'b000;
      default: n4143 = 3'b000;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n4215 = 4'b0110;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n4215 = 4'b0110;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n4215 = 4'b0011;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n4215 = 4'b0010;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n4215 = 4'b0101;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n4215 = 4'b0100;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n4215 = 4'b1000;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n4215 = 4'b0111;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n4215 = 4'b0111;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n4215 = 4'b1000;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n4215 = 4'b0100;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n4215 = 4'b0101;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n4215 = 4'b0010;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n4215 = 4'b0011;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n4215 = 4'b0110;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n4215 = 4'b0110;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n4215 = 4'b0100;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n4215 = 4'b0101;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n4215 = 4'b0101;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n4215 = 4'b0100;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n4215 = 4'b0011;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n4215 = 4'b0011;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n4215 = 4'b0010;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n4215 = 4'b0010;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n4215 = 4'b0111;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n4215 = 4'b1000;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n4215 = 4'b1000;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n4215 = 4'b0111;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n4215 = 4'b1000;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n4215 = 4'b0111;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n4215 = 4'b0001;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n4215 = 4'b0000;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n4215 = 4'b0111;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n4215 = 4'b1000;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n4215 = 4'b0000;
      default: n4215 = 4'b0000;
    endcase
  /*# rtl/cpu68.vhd:972:25 */
  always @*
    case (n3131)
      70'b1000000000000000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0100000000000000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0010000000000000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0001000000000000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000100000000000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000010000000000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000001000000000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000100000000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000010000000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000001000000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000100000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000010000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000001000000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000100000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000010000000000000000000000000000000000000000000000000000000: n4285 = n3097;
      70'b0000000000000001000000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000100000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000010000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000001000000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000100000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000010000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000001000000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000100000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000010000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000001000000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000100000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000010000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000001000000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000100000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000010000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000001000000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000100000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000010000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000001000000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000100000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000010000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000001000000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000100000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000010000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000001000000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000100000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000010000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000001000000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000100000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000010000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000001000000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000100000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000010000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000001000000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000100000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000010000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000001000000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000100000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000010000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000001000000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000100000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000010000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000001000000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000100000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000010000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000001000000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000100000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000010000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000001000000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000000100000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000000010000: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000000001000: n4285 = n1543;
      70'b0000000000000000000000000000000000000000000000000000000000000000000100: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000000000010: n4285 = 2'b10;
      70'b0000000000000000000000000000000000000000000000000000000000000000000001: n4285 = 2'b00;
      default: n4285 = 2'b10;
    endcase
  /*# rtl/cpu68.vhd:4284:33 */
  assign n4289 = hold ? state : next_state;
  /*# rtl/cpu68.vhd:4282:33 */
  assign n4291 = rst ? 7'b0000000 : n4289;
  /*# rtl/cpu68.vhd:166:16 */
  assign n4294 = {n1111, n1110, n916, n892, n880, n796, n1099, n660};
  /*# rtl/cpu68.vhd:172:16 */
  assign n4295 = {n355, n351};
  /*# rtl/cpu68.vhd:572:17 */
  always @(negedge clk)
    n4296 <= n331;
  /*# rtl/cpu68.vhd:378:17 */
  always @(negedge clk)
    n4297 <= n195;
  /*# rtl/cpu68.vhd:406:17 */
  always @(negedge clk)
    n4298 <= n210;
  /*# rtl/cpu68.vhd:517:17 */
  always @(negedge clk)
    n4299 <= n300;
  /*# rtl/cpu68.vhd:432:17 */
  always @(negedge clk)
    n4300 <= n235;
  /*# rtl/cpu68.vhd:460:17 */
  always @(negedge clk)
    n4301 <= n247;
  /*# rtl/cpu68.vhd:362:17 */
  always @(negedge clk)
    n4302 <= n176;
  /*# rtl/cpu68.vhd:317:17 */
  always @(negedge clk)
    n4303 <= n130;
  /*# rtl/cpu68.vhd:484:17 */
  always @(negedge clk)
    n4304 <= n286;
  /*# rtl/cpu68.vhd:544:17 */
  always @(negedge clk)
    n4305 <= n319;
  /*# rtl/cpu68.vhd:919:17 */
  always @(negedge clk)
    n4306 <= n1125;
  /*# rtl/cpu68.vhd:948:17 */
  always @(negedge clk)
    n4307 <= n1138;
  /*# rtl/cpu68.vhd:4281:25 */
  always @(negedge clk)
    n4308 <= n4291;
endmodule

