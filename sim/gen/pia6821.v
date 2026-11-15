module pia6821
  (input  clk,
   input  rst,
   input  cs,
   input  rw,
   input  [1:0] addr,
   input  [7:0] data_in,
   output [7:0] data_out,
   output irqa,
   output irqb,
   input  [7:0] pa_i,
   output [7:0] pa_o,
   output [7:0] pa_oe,
   input  ca1,
   input  ca2_i,
   output ca2_o,
   output ca2_oe,
   input  [7:0] pb_i,
   output [7:0] pb_o,
   output [7:0] pb_oe,
   input  cb1,
   input  cb2_i,
   output cb2_o,
   output cb2_oe);
  wire [7:0] porta_ddr;
  wire [7:0] porta_data;
  wire [5:0] porta_ctrl;
  wire porta_read;
  wire [7:0] portb_ddr;
  wire [7:0] portb_data;
  wire [5:0] portb_ctrl;
  wire portb_read;
  wire portb_write;
  wire ca1_del;
  wire ca1_rise;
  wire ca1_fall;
  wire ca1_edge;
  wire irqa1;
  wire ca2_del;
  wire ca2_rise;
  wire ca2_fall;
  wire ca2_edge;
  wire irqa2;
  wire ca2_out;
  wire cb1_del;
  wire cb1_rise;
  wire cb1_fall;
  wire cb1_edge;
  wire irqb1;
  wire cb2_del;
  wire cb2_rise;
  wire cb2_fall;
  wire cb2_edge;
  wire irqb2;
  wire cb2_out;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n20;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n30;
  wire n33;
  wire n34;
  wire n35;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n40;
  wire n43;
  wire n44;
  wire n45;
  wire n46;
  wire n47;
  wire n48;
  wire n49;
  wire n50;
  wire n53;
  wire n54;
  wire n55;
  wire n56;
  wire n57;
  wire n58;
  wire n59;
  wire n60;
  wire n63;
  wire n64;
  wire n65;
  wire n66;
  wire n67;
  wire n68;
  wire n69;
  wire n70;
  wire n73;
  wire n74;
  wire n75;
  wire n76;
  wire n77;
  wire n78;
  wire n79;
  wire n80;
  wire n83;
  wire n84;
  wire n85;
  wire n86;
  wire n87;
  wire n88;
  wire n89;
  wire n90;
  wire n92;
  wire n94;
  wire [1:0] n95;
  wire [7:0] n96;
  wire n98;
  wire n99;
  wire n100;
  wire n101;
  wire n102;
  wire n103;
  wire n104;
  wire n105;
  wire n106;
  wire n109;
  wire n110;
  wire n111;
  wire n112;
  wire n113;
  wire n114;
  wire n115;
  wire n116;
  wire n119;
  wire n120;
  wire n121;
  wire n122;
  wire n123;
  wire n124;
  wire n125;
  wire n126;
  wire n129;
  wire n130;
  wire n131;
  wire n132;
  wire n133;
  wire n134;
  wire n135;
  wire n136;
  wire n139;
  wire n140;
  wire n141;
  wire n142;
  wire n143;
  wire n144;
  wire n145;
  wire n146;
  wire n149;
  wire n150;
  wire n151;
  wire n152;
  wire n153;
  wire n154;
  wire n155;
  wire n156;
  wire n159;
  wire n160;
  wire n161;
  wire n162;
  wire n163;
  wire n164;
  wire n165;
  wire n166;
  wire n169;
  wire n170;
  wire n171;
  wire n172;
  wire n173;
  wire n174;
  wire n175;
  wire n176;
  wire n178;
  wire n180;
  wire [1:0] n181;
  wire [7:0] n182;
  wire n184;
  wire [3:0] n185;
  wire n186;
  wire n187;
  reg n189;
  wire n190;
  wire n191;
  reg n193;
  wire n194;
  wire n195;
  reg n197;
  wire n198;
  wire n199;
  reg n201;
  wire n202;
  wire n203;
  reg n205;
  wire n206;
  wire n207;
  reg n209;
  wire n210;
  wire n211;
  reg n213;
  wire n214;
  wire n215;
  reg n217;
  reg n222;
  reg n227;
  wire n231;
  wire n232;
  wire n233;
  wire n234;
  wire [7:0] n235;
  wire [7:0] n236;
  wire n238;
  wire [5:0] n239;
  wire n241;
  wire n242;
  wire n243;
  wire [7:0] n244;
  wire [7:0] n245;
  wire n248;
  wire n250;
  wire [5:0] n251;
  wire n253;
  wire [3:0] n254;
  reg [7:0] n255;
  reg [7:0] n256;
  reg [5:0] n257;
  reg [7:0] n258;
  reg [7:0] n259;
  reg [5:0] n260;
  reg n265;
  wire n273;
  wire n298;
  wire n299;
  wire n303;
  wire n304;
  wire n305;
  wire n306;
  wire n310;
  wire n311;
  wire n312;
  wire n313;
  wire n317;
  wire n318;
  wire n319;
  wire n320;
  wire n324;
  wire n325;
  wire n326;
  wire n327;
  wire n331;
  wire n332;
  wire n333;
  wire n334;
  wire n338;
  wire n339;
  wire n340;
  wire n341;
  wire n345;
  wire n346;
  wire n347;
  wire n348;
  wire n352;
  wire n353;
  wire n357;
  wire n358;
  wire n359;
  wire n360;
  wire n362;
  wire n364;
  wire n379;
  wire n380;
  wire n381;
  wire n385;
  wire n386;
  wire n387;
  wire n388;
  wire n389;
  wire n390;
  wire n391;
  wire n393;
  wire n395;
  wire n410;
  wire n411;
  wire n412;
  wire [2:0] n416;
  wire n418;
  wire n420;
  wire n422;
  wire n423;
  wire n425;
  wire n427;
  wire n429;
  wire [3:0] n430;
  reg n433;
  wire n439;
  wire n440;
  wire n442;
  wire n445;
  wire n449;
  wire n450;
  wire n454;
  wire n455;
  wire n456;
  wire n457;
  wire n461;
  wire n462;
  wire n463;
  wire n464;
  wire n468;
  wire n469;
  wire n470;
  wire n471;
  wire n475;
  wire n476;
  wire n477;
  wire n478;
  wire n482;
  wire n483;
  wire n484;
  wire n485;
  wire n489;
  wire n490;
  wire n491;
  wire n492;
  wire n496;
  wire n497;
  wire n498;
  wire n499;
  wire n503;
  wire n504;
  wire n508;
  wire n509;
  wire n510;
  wire n511;
  wire n513;
  wire n515;
  wire n530;
  wire n531;
  wire n532;
  wire n536;
  wire n537;
  wire n538;
  wire n539;
  wire n540;
  wire n541;
  wire n542;
  wire n544;
  wire n546;
  wire n561;
  wire n562;
  wire n563;
  wire [2:0] n567;
  wire n569;
  wire n571;
  wire n573;
  wire n574;
  wire n576;
  wire n578;
  wire n580;
  wire [3:0] n581;
  reg n584;
  wire n590;
  wire n591;
  wire n593;
  wire n596;
  wire n599;
  wire n600;
  wire n601;
  wire n602;
  wire n603;
  wire n604;
  wire n605;
  wire n606;
  wire n607;
  wire n608;
  wire [7:0] n610;
  wire [7:0] n611;
  wire [7:0] n612;
  wire [7:0] n613;
  wire [7:0] n614;
  wire [7:0] n615;
  reg [7:0] n616;
  wire [7:0] n617;
  reg [7:0] n618;
  wire [5:0] n619;
  reg [5:0] n620;
  wire [7:0] n621;
  reg [7:0] n622;
  wire [7:0] n623;
  reg [7:0] n624;
  wire [5:0] n625;
  reg [5:0] n626;
  reg n627;
  reg n628;
  reg n629;
  reg n630;
  reg n631;
  reg n632;
  reg n633;
  reg n634;
  reg n635;
  reg n636;
  reg n637;
  reg n638;
  reg n639;
  reg n640;
  reg n641;
  reg n642;
  reg n643;
  reg n644;
  reg n645;
  assign data_out = n610; //(module output)
  assign irqa = n603; //(module output)
  assign irqb = n608; //(module output)
  assign pa_o = n611; //(module output)
  assign pa_oe = n612; //(module output)
  assign ca2_o = n442; //(module output)
  assign ca2_oe = n445; //(module output)
  assign pb_o = n613; //(module output)
  assign pb_oe = n614; //(module output)
  assign cb2_o = n593; //(module output)
  assign cb2_oe = n596; //(module output)
  /*# rtl/pia6821.vhd:78:8 */
  assign porta_ddr = n616; // (signal)
  /*# rtl/pia6821.vhd:79:8 */
  assign porta_data = n618; // (signal)
  /*# rtl/pia6821.vhd:80:8 */
  assign porta_ctrl = n620; // (signal)
  /*# rtl/pia6821.vhd:81:8 */
  assign porta_read = n222; // (signal)
  /*# rtl/pia6821.vhd:83:8 */
  assign portb_ddr = n622; // (signal)
  /*# rtl/pia6821.vhd:84:8 */
  assign portb_data = n624; // (signal)
  /*# rtl/pia6821.vhd:85:8 */
  assign portb_ctrl = n626; // (signal)
  /*# rtl/pia6821.vhd:86:8 */
  assign portb_read = n227; // (signal)
  /*# rtl/pia6821.vhd:87:8 */
  assign portb_write = n627; // (signal)
  /*# rtl/pia6821.vhd:89:8 */
  assign ca1_del = n628; // (signal)
  /*# rtl/pia6821.vhd:90:8 */
  assign ca1_rise = n629; // (signal)
  /*# rtl/pia6821.vhd:91:8 */
  assign ca1_fall = n630; // (signal)
  /*# rtl/pia6821.vhd:92:8 */
  assign ca1_edge = n381; // (signal)
  /*# rtl/pia6821.vhd:93:8 */
  assign irqa1 = n631; // (signal)
  /*# rtl/pia6821.vhd:95:8 */
  assign ca2_del = n632; // (signal)
  /*# rtl/pia6821.vhd:96:8 */
  assign ca2_rise = n633; // (signal)
  /*# rtl/pia6821.vhd:97:8 */
  assign ca2_fall = n634; // (signal)
  /*# rtl/pia6821.vhd:98:8 */
  assign ca2_edge = n412; // (signal)
  /*# rtl/pia6821.vhd:99:8 */
  assign irqa2 = n635; // (signal)
  /*# rtl/pia6821.vhd:100:8 */
  assign ca2_out = n636; // (signal)
  /*# rtl/pia6821.vhd:102:8 */
  assign cb1_del = n637; // (signal)
  /*# rtl/pia6821.vhd:103:8 */
  assign cb1_rise = n638; // (signal)
  /*# rtl/pia6821.vhd:104:8 */
  assign cb1_fall = n639; // (signal)
  /*# rtl/pia6821.vhd:105:8 */
  assign cb1_edge = n532; // (signal)
  /*# rtl/pia6821.vhd:106:8 */
  assign irqb1 = n640; // (signal)
  /*# rtl/pia6821.vhd:108:8 */
  assign cb2_del = n641; // (signal)
  /*# rtl/pia6821.vhd:109:8 */
  assign cb2_rise = n642; // (signal)
  /*# rtl/pia6821.vhd:110:8 */
  assign cb2_fall = n643; // (signal)
  /*# rtl/pia6821.vhd:111:8 */
  assign cb2_edge = n563; // (signal)
  /*# rtl/pia6821.vhd:112:8 */
  assign irqb2 = n644; // (signal)
  /*# rtl/pia6821.vhd:113:8 */
  assign cb2_out = n645; // (signal)
  /*# rtl/pia6821.vhd:134:41 */
  assign n13 = porta_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:134:45 */
  assign n14 = ~n13;
  /*# rtl/pia6821.vhd:135:63 */
  assign n15 = porta_ddr[0]; // extract
  /*# rtl/pia6821.vhd:138:47 */
  assign n16 = porta_ddr[0]; // extract
  /*# rtl/pia6821.vhd:139:46 */
  assign n17 = porta_data[0]; // extract
  /*# rtl/pia6821.vhd:141:40 */
  assign n18 = pa_i[0]; // extract
  /*# rtl/pia6821.vhd:138:35 */
  assign n19 = n16 ? n17 : n18;
  /*# rtl/pia6821.vhd:134:28 */
  assign n20 = n14 ? n15 : n19;
  /*# rtl/pia6821.vhd:134:41 */
  assign n23 = porta_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:134:45 */
  assign n24 = ~n23;
  /*# rtl/pia6821.vhd:135:63 */
  assign n25 = porta_ddr[1]; // extract
  /*# rtl/pia6821.vhd:138:47 */
  assign n26 = porta_ddr[1]; // extract
  /*# rtl/pia6821.vhd:139:46 */
  assign n27 = porta_data[1]; // extract
  /*# rtl/pia6821.vhd:141:40 */
  assign n28 = pa_i[1]; // extract
  /*# rtl/pia6821.vhd:138:35 */
  assign n29 = n26 ? n27 : n28;
  /*# rtl/pia6821.vhd:134:28 */
  assign n30 = n24 ? n25 : n29;
  /*# rtl/pia6821.vhd:134:41 */
  assign n33 = porta_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:134:45 */
  assign n34 = ~n33;
  /*# rtl/pia6821.vhd:135:63 */
  assign n35 = porta_ddr[2]; // extract
  /*# rtl/pia6821.vhd:138:47 */
  assign n36 = porta_ddr[2]; // extract
  /*# rtl/pia6821.vhd:139:46 */
  assign n37 = porta_data[2]; // extract
  /*# rtl/pia6821.vhd:141:40 */
  assign n38 = pa_i[2]; // extract
  /*# rtl/pia6821.vhd:138:35 */
  assign n39 = n36 ? n37 : n38;
  /*# rtl/pia6821.vhd:134:28 */
  assign n40 = n34 ? n35 : n39;
  /*# rtl/pia6821.vhd:134:41 */
  assign n43 = porta_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:134:45 */
  assign n44 = ~n43;
  /*# rtl/pia6821.vhd:135:63 */
  assign n45 = porta_ddr[3]; // extract
  /*# rtl/pia6821.vhd:138:47 */
  assign n46 = porta_ddr[3]; // extract
  /*# rtl/pia6821.vhd:139:46 */
  assign n47 = porta_data[3]; // extract
  /*# rtl/pia6821.vhd:141:40 */
  assign n48 = pa_i[3]; // extract
  /*# rtl/pia6821.vhd:138:35 */
  assign n49 = n46 ? n47 : n48;
  /*# rtl/pia6821.vhd:134:28 */
  assign n50 = n44 ? n45 : n49;
  /*# rtl/pia6821.vhd:134:41 */
  assign n53 = porta_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:134:45 */
  assign n54 = ~n53;
  /*# rtl/pia6821.vhd:135:63 */
  assign n55 = porta_ddr[4]; // extract
  /*# rtl/pia6821.vhd:138:47 */
  assign n56 = porta_ddr[4]; // extract
  /*# rtl/pia6821.vhd:139:46 */
  assign n57 = porta_data[4]; // extract
  /*# rtl/pia6821.vhd:141:40 */
  assign n58 = pa_i[4]; // extract
  /*# rtl/pia6821.vhd:138:35 */
  assign n59 = n56 ? n57 : n58;
  /*# rtl/pia6821.vhd:134:28 */
  assign n60 = n54 ? n55 : n59;
  /*# rtl/pia6821.vhd:134:41 */
  assign n63 = porta_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:134:45 */
  assign n64 = ~n63;
  /*# rtl/pia6821.vhd:135:63 */
  assign n65 = porta_ddr[5]; // extract
  /*# rtl/pia6821.vhd:138:47 */
  assign n66 = porta_ddr[5]; // extract
  /*# rtl/pia6821.vhd:139:46 */
  assign n67 = porta_data[5]; // extract
  /*# rtl/pia6821.vhd:141:40 */
  assign n68 = pa_i[5]; // extract
  /*# rtl/pia6821.vhd:138:35 */
  assign n69 = n66 ? n67 : n68;
  /*# rtl/pia6821.vhd:134:28 */
  assign n70 = n64 ? n65 : n69;
  /*# rtl/pia6821.vhd:134:41 */
  assign n73 = porta_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:134:45 */
  assign n74 = ~n73;
  /*# rtl/pia6821.vhd:135:63 */
  assign n75 = porta_ddr[6]; // extract
  /*# rtl/pia6821.vhd:138:47 */
  assign n76 = porta_ddr[6]; // extract
  /*# rtl/pia6821.vhd:139:46 */
  assign n77 = porta_data[6]; // extract
  /*# rtl/pia6821.vhd:141:40 */
  assign n78 = pa_i[6]; // extract
  /*# rtl/pia6821.vhd:138:35 */
  assign n79 = n76 ? n77 : n78;
  /*# rtl/pia6821.vhd:134:28 */
  assign n80 = n74 ? n75 : n79;
  /*# rtl/pia6821.vhd:134:41 */
  assign n83 = porta_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:134:45 */
  assign n84 = ~n83;
  /*# rtl/pia6821.vhd:135:63 */
  assign n85 = porta_ddr[7]; // extract
  /*# rtl/pia6821.vhd:138:47 */
  assign n86 = porta_ddr[7]; // extract
  /*# rtl/pia6821.vhd:139:46 */
  assign n87 = porta_data[7]; // extract
  /*# rtl/pia6821.vhd:141:40 */
  assign n88 = pa_i[7]; // extract
  /*# rtl/pia6821.vhd:138:35 */
  assign n89 = n86 ? n87 : n88;
  /*# rtl/pia6821.vhd:134:28 */
  assign n90 = n84 ? n85 : n89;
  /*# rtl/pia6821.vhd:134:28 */
  assign n92 = n84 ? 1'b0 : cs;
  /*# rtl/pia6821.vhd:132:14 */
  assign n94 = addr == 2'b00;
  /*# rtl/pia6821.vhd:149:39 */
  assign n95 = {irqa1, irqa2};
  /*# rtl/pia6821.vhd:149:47 */
  assign n96 = {n95, porta_ctrl};
  /*# rtl/pia6821.vhd:148:14 */
  assign n98 = addr == 2'b01;
  /*# rtl/pia6821.vhd:155:41 */
  assign n99 = portb_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:155:45 */
  assign n100 = ~n99;
  /*# rtl/pia6821.vhd:156:63 */
  assign n101 = portb_ddr[0]; // extract
  /*# rtl/pia6821.vhd:159:47 */
  assign n102 = portb_ddr[0]; // extract
  /*# rtl/pia6821.vhd:160:46 */
  assign n103 = portb_data[0]; // extract
  /*# rtl/pia6821.vhd:162:40 */
  assign n104 = pb_i[0]; // extract
  /*# rtl/pia6821.vhd:159:35 */
  assign n105 = n102 ? n103 : n104;
  /*# rtl/pia6821.vhd:155:28 */
  assign n106 = n100 ? n101 : n105;
  /*# rtl/pia6821.vhd:155:41 */
  assign n109 = portb_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:155:45 */
  assign n110 = ~n109;
  /*# rtl/pia6821.vhd:156:63 */
  assign n111 = portb_ddr[1]; // extract
  /*# rtl/pia6821.vhd:159:47 */
  assign n112 = portb_ddr[1]; // extract
  /*# rtl/pia6821.vhd:160:46 */
  assign n113 = portb_data[1]; // extract
  /*# rtl/pia6821.vhd:162:40 */
  assign n114 = pb_i[1]; // extract
  /*# rtl/pia6821.vhd:159:35 */
  assign n115 = n112 ? n113 : n114;
  /*# rtl/pia6821.vhd:155:28 */
  assign n116 = n110 ? n111 : n115;
  /*# rtl/pia6821.vhd:155:41 */
  assign n119 = portb_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:155:45 */
  assign n120 = ~n119;
  /*# rtl/pia6821.vhd:156:63 */
  assign n121 = portb_ddr[2]; // extract
  /*# rtl/pia6821.vhd:159:47 */
  assign n122 = portb_ddr[2]; // extract
  /*# rtl/pia6821.vhd:160:46 */
  assign n123 = portb_data[2]; // extract
  /*# rtl/pia6821.vhd:162:40 */
  assign n124 = pb_i[2]; // extract
  /*# rtl/pia6821.vhd:159:35 */
  assign n125 = n122 ? n123 : n124;
  /*# rtl/pia6821.vhd:155:28 */
  assign n126 = n120 ? n121 : n125;
  /*# rtl/pia6821.vhd:155:41 */
  assign n129 = portb_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:155:45 */
  assign n130 = ~n129;
  /*# rtl/pia6821.vhd:156:63 */
  assign n131 = portb_ddr[3]; // extract
  /*# rtl/pia6821.vhd:159:47 */
  assign n132 = portb_ddr[3]; // extract
  /*# rtl/pia6821.vhd:160:46 */
  assign n133 = portb_data[3]; // extract
  /*# rtl/pia6821.vhd:162:40 */
  assign n134 = pb_i[3]; // extract
  /*# rtl/pia6821.vhd:159:35 */
  assign n135 = n132 ? n133 : n134;
  /*# rtl/pia6821.vhd:155:28 */
  assign n136 = n130 ? n131 : n135;
  /*# rtl/pia6821.vhd:155:41 */
  assign n139 = portb_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:155:45 */
  assign n140 = ~n139;
  /*# rtl/pia6821.vhd:156:63 */
  assign n141 = portb_ddr[4]; // extract
  /*# rtl/pia6821.vhd:159:47 */
  assign n142 = portb_ddr[4]; // extract
  /*# rtl/pia6821.vhd:160:46 */
  assign n143 = portb_data[4]; // extract
  /*# rtl/pia6821.vhd:162:40 */
  assign n144 = pb_i[4]; // extract
  /*# rtl/pia6821.vhd:159:35 */
  assign n145 = n142 ? n143 : n144;
  /*# rtl/pia6821.vhd:155:28 */
  assign n146 = n140 ? n141 : n145;
  /*# rtl/pia6821.vhd:155:41 */
  assign n149 = portb_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:155:45 */
  assign n150 = ~n149;
  /*# rtl/pia6821.vhd:156:63 */
  assign n151 = portb_ddr[5]; // extract
  /*# rtl/pia6821.vhd:159:47 */
  assign n152 = portb_ddr[5]; // extract
  /*# rtl/pia6821.vhd:160:46 */
  assign n153 = portb_data[5]; // extract
  /*# rtl/pia6821.vhd:162:40 */
  assign n154 = pb_i[5]; // extract
  /*# rtl/pia6821.vhd:159:35 */
  assign n155 = n152 ? n153 : n154;
  /*# rtl/pia6821.vhd:155:28 */
  assign n156 = n150 ? n151 : n155;
  /*# rtl/pia6821.vhd:155:41 */
  assign n159 = portb_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:155:45 */
  assign n160 = ~n159;
  /*# rtl/pia6821.vhd:156:63 */
  assign n161 = portb_ddr[6]; // extract
  /*# rtl/pia6821.vhd:159:47 */
  assign n162 = portb_ddr[6]; // extract
  /*# rtl/pia6821.vhd:160:46 */
  assign n163 = portb_data[6]; // extract
  /*# rtl/pia6821.vhd:162:40 */
  assign n164 = pb_i[6]; // extract
  /*# rtl/pia6821.vhd:159:35 */
  assign n165 = n162 ? n163 : n164;
  /*# rtl/pia6821.vhd:155:28 */
  assign n166 = n160 ? n161 : n165;
  /*# rtl/pia6821.vhd:155:41 */
  assign n169 = portb_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:155:45 */
  assign n170 = ~n169;
  /*# rtl/pia6821.vhd:156:63 */
  assign n171 = portb_ddr[7]; // extract
  /*# rtl/pia6821.vhd:159:47 */
  assign n172 = portb_ddr[7]; // extract
  /*# rtl/pia6821.vhd:160:46 */
  assign n173 = portb_data[7]; // extract
  /*# rtl/pia6821.vhd:162:40 */
  assign n174 = pb_i[7]; // extract
  /*# rtl/pia6821.vhd:159:35 */
  assign n175 = n172 ? n173 : n174;
  /*# rtl/pia6821.vhd:155:28 */
  assign n176 = n170 ? n171 : n175;
  /*# rtl/pia6821.vhd:155:28 */
  assign n178 = n170 ? 1'b0 : cs;
  /*# rtl/pia6821.vhd:153:19 */
  assign n180 = addr == 2'b10;
  /*# rtl/pia6821.vhd:170:39 */
  assign n181 = {irqb1, irqb2};
  /*# rtl/pia6821.vhd:170:47 */
  assign n182 = {n181, portb_ctrl};
  /*# rtl/pia6821.vhd:169:19 */
  assign n184 = addr == 2'b11;
  /*# rtl/pia6821.vhd:131:7 */
  assign n185 = {n184, n180, n98, n94};
  /*# rtl/pia6821.vhd:149:47 */
  assign n186 = n96[0]; // extract
  /*# rtl/pia6821.vhd:170:47 */
  assign n187 = n182[0]; // extract
  /*# rtl/pia6821.vhd:131:7 */
  always @*
    case (n185)
      4'b1000: n189 = n187;
      4'b0100: n189 = n106;
      4'b0010: n189 = n186;
      4'b0001: n189 = n20;
      default: n189 = 1'b0;
    endcase
  /*# rtl/pia6821.vhd:149:47 */
  assign n190 = n96[1]; // extract
  /*# rtl/pia6821.vhd:170:47 */
  assign n191 = n182[1]; // extract
  /*# rtl/pia6821.vhd:131:7 */
  always @*
    case (n185)
      4'b1000: n193 = n191;
      4'b0100: n193 = n116;
      4'b0010: n193 = n190;
      4'b0001: n193 = n30;
      default: n193 = 1'b0;
    endcase
  /*# rtl/pia6821.vhd:149:47 */
  assign n194 = n96[2]; // extract
  /*# rtl/pia6821.vhd:170:47 */
  assign n195 = n182[2]; // extract
  /*# rtl/pia6821.vhd:131:7 */
  always @*
    case (n185)
      4'b1000: n197 = n195;
      4'b0100: n197 = n126;
      4'b0010: n197 = n194;
      4'b0001: n197 = n40;
      default: n197 = 1'b0;
    endcase
  /*# rtl/pia6821.vhd:149:47 */
  assign n198 = n96[3]; // extract
  /*# rtl/pia6821.vhd:170:47 */
  assign n199 = n182[3]; // extract
  /*# rtl/pia6821.vhd:131:7 */
  always @*
    case (n185)
      4'b1000: n201 = n199;
      4'b0100: n201 = n136;
      4'b0010: n201 = n198;
      4'b0001: n201 = n50;
      default: n201 = 1'b0;
    endcase
  /*# rtl/pia6821.vhd:149:47 */
  assign n202 = n96[4]; // extract
  /*# rtl/pia6821.vhd:170:47 */
  assign n203 = n182[4]; // extract
  /*# rtl/pia6821.vhd:131:7 */
  always @*
    case (n185)
      4'b1000: n205 = n203;
      4'b0100: n205 = n146;
      4'b0010: n205 = n202;
      4'b0001: n205 = n60;
      default: n205 = 1'b0;
    endcase
  /*# rtl/pia6821.vhd:149:47 */
  assign n206 = n96[5]; // extract
  /*# rtl/pia6821.vhd:170:47 */
  assign n207 = n182[5]; // extract
  /*# rtl/pia6821.vhd:131:7 */
  always @*
    case (n185)
      4'b1000: n209 = n207;
      4'b0100: n209 = n156;
      4'b0010: n209 = n206;
      4'b0001: n209 = n70;
      default: n209 = 1'b0;
    endcase
  /*# rtl/pia6821.vhd:149:47 */
  assign n210 = n96[6]; // extract
  /*# rtl/pia6821.vhd:170:47 */
  assign n211 = n182[6]; // extract
  /*# rtl/pia6821.vhd:131:7 */
  always @*
    case (n185)
      4'b1000: n213 = n211;
      4'b0100: n213 = n166;
      4'b0010: n213 = n210;
      4'b0001: n213 = n80;
      default: n213 = 1'b0;
    endcase
  /*# rtl/pia6821.vhd:149:47 */
  assign n214 = n96[7]; // extract
  /*# rtl/pia6821.vhd:170:47 */
  assign n215 = n182[7]; // extract
  /*# rtl/pia6821.vhd:131:7 */
  always @*
    case (n185)
      4'b1000: n217 = n215;
      4'b0100: n217 = n176;
      4'b0010: n217 = n214;
      4'b0001: n217 = n90;
      default: n217 = 1'b0;
    endcase
  /*# rtl/pia6821.vhd:131:7 */
  always @*
    case (n185)
      4'b1000: n222 = 1'b0;
      4'b0100: n222 = 1'b0;
      4'b0010: n222 = 1'b0;
      4'b0001: n222 = n92;
      default: n222 = 1'b0;
    endcase
  /*# rtl/pia6821.vhd:131:7 */
  always @*
    case (n185)
      4'b1000: n227 = 1'b0;
      4'b0100: n227 = n178;
      4'b0010: n227 = 1'b0;
      4'b0001: n227 = 1'b0;
      default: n227 = 1'b0;
    endcase
  /*# rtl/pia6821.vhd:202:24 */
  assign n231 = ~rw;
  /*# rtl/pia6821.vhd:202:17 */
  assign n232 = n231 & cs;
  /*# rtl/pia6821.vhd:205:34 */
  assign n233 = porta_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:205:38 */
  assign n234 = ~n233;
  /*# rtl/pia6821.vhd:205:21 */
  assign n235 = n234 ? data_in : porta_ddr;
  /*# rtl/pia6821.vhd:205:21 */
  assign n236 = n234 ? porta_data : data_in;
  /*# rtl/pia6821.vhd:204:14 */
  assign n238 = addr == 2'b00;
  /*# rtl/pia6821.vhd:220:48 */
  assign n239 = data_in[5:0]; // extract
  /*# rtl/pia6821.vhd:217:19 */
  assign n241 = addr == 2'b01;
  /*# rtl/pia6821.vhd:229:34 */
  assign n242 = portb_ctrl[2]; // extract
  /*# rtl/pia6821.vhd:229:38 */
  assign n243 = ~n242;
  /*# rtl/pia6821.vhd:229:21 */
  assign n244 = n243 ? data_in : portb_ddr;
  /*# rtl/pia6821.vhd:229:21 */
  assign n245 = n243 ? portb_data : data_in;
  /*# rtl/pia6821.vhd:229:21 */
  assign n248 = n243 ? 1'b0 : 1'b1;
  /*# rtl/pia6821.vhd:225:14 */
  assign n250 = addr == 2'b10;
  /*# rtl/pia6821.vhd:245:48 */
  assign n251 = data_in[5:0]; // extract
  /*# rtl/pia6821.vhd:239:19 */
  assign n253 = addr == 2'b11;
  /*# rtl/pia6821.vhd:203:7 */
  assign n254 = {n253, n250, n241, n238};
  /*# rtl/pia6821.vhd:203:7 */
  always @*
    case (n254)
      4'b1000: n255 = porta_ddr;
      4'b0100: n255 = porta_ddr;
      4'b0010: n255 = porta_ddr;
      4'b0001: n255 = n235;
      default: n255 = porta_ddr;
    endcase
  /*# rtl/pia6821.vhd:203:7 */
  always @*
    case (n254)
      4'b1000: n256 = porta_data;
      4'b0100: n256 = porta_data;
      4'b0010: n256 = porta_data;
      4'b0001: n256 = n236;
      default: n256 = porta_data;
    endcase
  /*# rtl/pia6821.vhd:203:7 */
  always @*
    case (n254)
      4'b1000: n257 = porta_ctrl;
      4'b0100: n257 = porta_ctrl;
      4'b0010: n257 = n239;
      4'b0001: n257 = porta_ctrl;
      default: n257 = porta_ctrl;
    endcase
  /*# rtl/pia6821.vhd:203:7 */
  always @*
    case (n254)
      4'b1000: n258 = portb_ddr;
      4'b0100: n258 = n244;
      4'b0010: n258 = portb_ddr;
      4'b0001: n258 = portb_ddr;
      default: n258 = portb_ddr;
    endcase
  /*# rtl/pia6821.vhd:203:7 */
  always @*
    case (n254)
      4'b1000: n259 = portb_data;
      4'b0100: n259 = n245;
      4'b0010: n259 = portb_data;
      4'b0001: n259 = portb_data;
      default: n259 = portb_data;
    endcase
  /*# rtl/pia6821.vhd:203:7 */
  always @*
    case (n254)
      4'b1000: n260 = n251;
      4'b0100: n260 = portb_ctrl;
      4'b0010: n260 = portb_ctrl;
      4'b0001: n260 = portb_ctrl;
      default: n260 = portb_ctrl;
    endcase
  /*# rtl/pia6821.vhd:203:7 */
  always @*
    case (n254)
      4'b1000: n265 = 1'b0;
      4'b0100: n265 = n248;
      4'b0010: n265 = 1'b0;
      4'b0001: n265 = 1'b0;
      default: n265 = 1'b0;
    endcase
  /*# rtl/pia6821.vhd:202:5 */
  assign n273 = n232 ? n265 : 1'b0;
  /*# rtl/pia6821.vhd:277:17 */
  assign n298 = porta_ddr[0]; // extract
  /*# rtl/pia6821.vhd:278:32 */
  assign n299 = porta_data[0]; // extract
  /*# rtl/pia6821.vhd:277:5 */
  assign n303 = n298 ? n299 : 1'b0;
  /*# rtl/pia6821.vhd:277:5 */
  assign n304 = n298 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:277:17 */
  assign n305 = porta_ddr[1]; // extract
  /*# rtl/pia6821.vhd:278:32 */
  assign n306 = porta_data[1]; // extract
  /*# rtl/pia6821.vhd:277:5 */
  assign n310 = n305 ? n306 : 1'b0;
  /*# rtl/pia6821.vhd:277:5 */
  assign n311 = n305 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:277:17 */
  assign n312 = porta_ddr[2]; // extract
  /*# rtl/pia6821.vhd:278:32 */
  assign n313 = porta_data[2]; // extract
  /*# rtl/pia6821.vhd:277:5 */
  assign n317 = n312 ? n313 : 1'b0;
  /*# rtl/pia6821.vhd:277:5 */
  assign n318 = n312 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:277:17 */
  assign n319 = porta_ddr[3]; // extract
  /*# rtl/pia6821.vhd:278:32 */
  assign n320 = porta_data[3]; // extract
  /*# rtl/pia6821.vhd:277:5 */
  assign n324 = n319 ? n320 : 1'b0;
  /*# rtl/pia6821.vhd:277:5 */
  assign n325 = n319 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:277:17 */
  assign n326 = porta_ddr[4]; // extract
  /*# rtl/pia6821.vhd:278:32 */
  assign n327 = porta_data[4]; // extract
  /*# rtl/pia6821.vhd:277:5 */
  assign n331 = n326 ? n327 : 1'b0;
  /*# rtl/pia6821.vhd:277:5 */
  assign n332 = n326 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:277:17 */
  assign n333 = porta_ddr[5]; // extract
  /*# rtl/pia6821.vhd:278:32 */
  assign n334 = porta_data[5]; // extract
  /*# rtl/pia6821.vhd:277:5 */
  assign n338 = n333 ? n334 : 1'b0;
  /*# rtl/pia6821.vhd:277:5 */
  assign n339 = n333 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:277:17 */
  assign n340 = porta_ddr[6]; // extract
  /*# rtl/pia6821.vhd:278:32 */
  assign n341 = porta_data[6]; // extract
  /*# rtl/pia6821.vhd:277:5 */
  assign n345 = n340 ? n341 : 1'b0;
  /*# rtl/pia6821.vhd:277:5 */
  assign n346 = n340 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:277:17 */
  assign n347 = porta_ddr[7]; // extract
  /*# rtl/pia6821.vhd:278:32 */
  assign n348 = porta_data[7]; // extract
  /*# rtl/pia6821.vhd:277:5 */
  assign n352 = n347 ? n348 : 1'b0;
  /*# rtl/pia6821.vhd:277:5 */
  assign n353 = n347 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:304:18 */
  assign n357 = ~ca1_del;
  /*# rtl/pia6821.vhd:304:31 */
  assign n358 = n357 & ca1;
  /*# rtl/pia6821.vhd:305:30 */
  assign n359 = ~ca1;
  /*# rtl/pia6821.vhd:305:25 */
  assign n360 = ca1_del & n359;
  /*# rtl/pia6821.vhd:308:10 */
  assign n362 = porta_read ? 1'b0 : irqa1;
  /*# rtl/pia6821.vhd:306:10 */
  assign n364 = ca1_edge ? 1'b1 : n362;
  /*# rtl/pia6821.vhd:315:16 */
  assign n379 = porta_ctrl[1]; // extract
  /*# rtl/pia6821.vhd:315:20 */
  assign n380 = ~n379;
  /*# rtl/pia6821.vhd:315:3 */
  assign n381 = n380 ? ca1_fall : ca1_rise;
  /*# rtl/pia6821.vhd:339:18 */
  assign n385 = ~ca2_del;
  /*# rtl/pia6821.vhd:339:31 */
  assign n386 = n385 & ca2_i;
  /*# rtl/pia6821.vhd:340:30 */
  assign n387 = ~ca2_i;
  /*# rtl/pia6821.vhd:340:25 */
  assign n388 = ca2_del & n387;
  /*# rtl/pia6821.vhd:341:23 */
  assign n389 = porta_ctrl[5]; // extract
  /*# rtl/pia6821.vhd:341:27 */
  assign n390 = ~n389;
  /*# rtl/pia6821.vhd:341:33 */
  assign n391 = ca2_edge & n390;
  /*# rtl/pia6821.vhd:343:10 */
  assign n393 = porta_read ? 1'b0 : irqa2;
  /*# rtl/pia6821.vhd:341:10 */
  assign n395 = n391 ? 1'b1 : n393;
  /*# rtl/pia6821.vhd:350:16 */
  assign n410 = porta_ctrl[4]; // extract
  /*# rtl/pia6821.vhd:350:20 */
  assign n411 = ~n410;
  /*# rtl/pia6821.vhd:350:3 */
  assign n412 = n411 ? ca2_fall : ca2_rise;
  /*# rtl/pia6821.vhd:367:20 */
  assign n416 = porta_ctrl[5:3]; // extract
  /*# rtl/pia6821.vhd:371:7 */
  assign n418 = ca1_edge ? 1'b1 : ca2_out;
  /*# rtl/pia6821.vhd:369:7 */
  assign n420 = porta_read ? 1'b0 : n418;
  /*# rtl/pia6821.vhd:368:5 */
  assign n422 = n416 == 3'b100;
  /*# rtl/pia6821.vhd:377:18 */
  assign n423 = ~porta_read;
  /*# rtl/pia6821.vhd:376:5 */
  assign n425 = n416 == 3'b101;
  /*# rtl/pia6821.vhd:378:5 */
  assign n427 = n416 == 3'b110;
  /*# rtl/pia6821.vhd:380:5 */
  assign n429 = n416 == 3'b111;
  /*# rtl/pia6821.vhd:367:5 */
  assign n430 = {n429, n427, n425, n422};
  /*# rtl/pia6821.vhd:367:5 */
  always @*
    case (n430)
      4'b1000: n433 = 1'b1;
      4'b0100: n433 = 1'b0;
      4'b0010: n433 = n423;
      4'b0001: n433 = n420;
      default: n433 = ca2_out;
    endcase
  /*# rtl/pia6821.vhd:395:16 */
  assign n439 = porta_ctrl[5]; // extract
  /*# rtl/pia6821.vhd:395:20 */
  assign n440 = ~n439;
  /*# rtl/pia6821.vhd:395:3 */
  assign n442 = n440 ? 1'b0 : ca2_out;
  /*# rtl/pia6821.vhd:395:3 */
  assign n445 = n440 ? 1'b0 : 1'b1;
  /*# rtl/pia6821.vhd:413:17 */
  assign n449 = portb_ddr[0]; // extract
  /*# rtl/pia6821.vhd:414:32 */
  assign n450 = portb_data[0]; // extract
  /*# rtl/pia6821.vhd:413:5 */
  assign n454 = n449 ? n450 : 1'b0;
  /*# rtl/pia6821.vhd:413:5 */
  assign n455 = n449 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:413:17 */
  assign n456 = portb_ddr[1]; // extract
  /*# rtl/pia6821.vhd:414:32 */
  assign n457 = portb_data[1]; // extract
  /*# rtl/pia6821.vhd:413:5 */
  assign n461 = n456 ? n457 : 1'b0;
  /*# rtl/pia6821.vhd:413:5 */
  assign n462 = n456 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:413:17 */
  assign n463 = portb_ddr[2]; // extract
  /*# rtl/pia6821.vhd:414:32 */
  assign n464 = portb_data[2]; // extract
  /*# rtl/pia6821.vhd:413:5 */
  assign n468 = n463 ? n464 : 1'b0;
  /*# rtl/pia6821.vhd:413:5 */
  assign n469 = n463 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:413:17 */
  assign n470 = portb_ddr[3]; // extract
  /*# rtl/pia6821.vhd:414:32 */
  assign n471 = portb_data[3]; // extract
  /*# rtl/pia6821.vhd:413:5 */
  assign n475 = n470 ? n471 : 1'b0;
  /*# rtl/pia6821.vhd:413:5 */
  assign n476 = n470 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:413:17 */
  assign n477 = portb_ddr[4]; // extract
  /*# rtl/pia6821.vhd:414:32 */
  assign n478 = portb_data[4]; // extract
  /*# rtl/pia6821.vhd:413:5 */
  assign n482 = n477 ? n478 : 1'b0;
  /*# rtl/pia6821.vhd:413:5 */
  assign n483 = n477 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:413:17 */
  assign n484 = portb_ddr[5]; // extract
  /*# rtl/pia6821.vhd:414:32 */
  assign n485 = portb_data[5]; // extract
  /*# rtl/pia6821.vhd:413:5 */
  assign n489 = n484 ? n485 : 1'b0;
  /*# rtl/pia6821.vhd:413:5 */
  assign n490 = n484 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:413:17 */
  assign n491 = portb_ddr[6]; // extract
  /*# rtl/pia6821.vhd:414:32 */
  assign n492 = portb_data[6]; // extract
  /*# rtl/pia6821.vhd:413:5 */
  assign n496 = n491 ? n492 : 1'b0;
  /*# rtl/pia6821.vhd:413:5 */
  assign n497 = n491 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:413:17 */
  assign n498 = portb_ddr[7]; // extract
  /*# rtl/pia6821.vhd:414:32 */
  assign n499 = portb_data[7]; // extract
  /*# rtl/pia6821.vhd:413:5 */
  assign n503 = n498 ? n499 : 1'b0;
  /*# rtl/pia6821.vhd:413:5 */
  assign n504 = n498 ? 1'b1 : 1'b0;
  /*# rtl/pia6821.vhd:440:18 */
  assign n508 = ~cb1_del;
  /*# rtl/pia6821.vhd:440:31 */
  assign n509 = n508 & cb1;
  /*# rtl/pia6821.vhd:441:30 */
  assign n510 = ~cb1;
  /*# rtl/pia6821.vhd:441:25 */
  assign n511 = cb1_del & n510;
  /*# rtl/pia6821.vhd:444:10 */
  assign n513 = portb_read ? 1'b0 : irqb1;
  /*# rtl/pia6821.vhd:442:10 */
  assign n515 = cb1_edge ? 1'b1 : n513;
  /*# rtl/pia6821.vhd:451:16 */
  assign n530 = portb_ctrl[1]; // extract
  /*# rtl/pia6821.vhd:451:20 */
  assign n531 = ~n530;
  /*# rtl/pia6821.vhd:451:3 */
  assign n532 = n531 ? cb1_fall : cb1_rise;
  /*# rtl/pia6821.vhd:475:18 */
  assign n536 = ~cb2_del;
  /*# rtl/pia6821.vhd:475:31 */
  assign n537 = n536 & cb2_i;
  /*# rtl/pia6821.vhd:476:30 */
  assign n538 = ~cb2_i;
  /*# rtl/pia6821.vhd:476:25 */
  assign n539 = cb2_del & n538;
  /*# rtl/pia6821.vhd:477:23 */
  assign n540 = portb_ctrl[5]; // extract
  /*# rtl/pia6821.vhd:477:27 */
  assign n541 = ~n540;
  /*# rtl/pia6821.vhd:477:33 */
  assign n542 = cb2_edge & n541;
  /*# rtl/pia6821.vhd:479:10 */
  assign n544 = portb_read ? 1'b0 : irqb2;
  /*# rtl/pia6821.vhd:477:10 */
  assign n546 = n542 ? 1'b1 : n544;
  /*# rtl/pia6821.vhd:486:16 */
  assign n561 = portb_ctrl[4]; // extract
  /*# rtl/pia6821.vhd:486:20 */
  assign n562 = ~n561;
  /*# rtl/pia6821.vhd:486:3 */
  assign n563 = n562 ? cb2_fall : cb2_rise;
  /*# rtl/pia6821.vhd:504:20 */
  assign n567 = portb_ctrl[5:3]; // extract
  /*# rtl/pia6821.vhd:508:7 */
  assign n569 = cb1_edge ? 1'b1 : cb2_out;
  /*# rtl/pia6821.vhd:506:7 */
  assign n571 = portb_write ? 1'b0 : n569;
  /*# rtl/pia6821.vhd:505:5 */
  assign n573 = n567 == 3'b100;
  /*# rtl/pia6821.vhd:514:18 */
  assign n574 = ~portb_write;
  /*# rtl/pia6821.vhd:513:5 */
  assign n576 = n567 == 3'b101;
  /*# rtl/pia6821.vhd:515:5 */
  assign n578 = n567 == 3'b110;
  /*# rtl/pia6821.vhd:517:5 */
  assign n580 = n567 == 3'b111;
  /*# rtl/pia6821.vhd:504:5 */
  assign n581 = {n580, n578, n576, n573};
  /*# rtl/pia6821.vhd:504:5 */
  always @*
    case (n581)
      4'b1000: n584 = 1'b1;
      4'b0100: n584 = 1'b0;
      4'b0010: n584 = n574;
      4'b0001: n584 = n571;
      default: n584 = cb2_out;
    endcase
  /*# rtl/pia6821.vhd:532:16 */
  assign n590 = portb_ctrl[5]; // extract
  /*# rtl/pia6821.vhd:532:20 */
  assign n591 = ~n590;
  /*# rtl/pia6821.vhd:532:3 */
  assign n593 = n591 ? 1'b0 : cb2_out;
  /*# rtl/pia6821.vhd:532:3 */
  assign n596 = n591 ? 1'b0 : 1'b1;
  /*# rtl/pia6821.vhd:548:32 */
  assign n599 = porta_ctrl[0]; // extract
  /*# rtl/pia6821.vhd:548:18 */
  assign n600 = irqa1 & n599;
  /*# rtl/pia6821.vhd:548:61 */
  assign n601 = porta_ctrl[3]; // extract
  /*# rtl/pia6821.vhd:548:47 */
  assign n602 = irqa2 & n601;
  /*# rtl/pia6821.vhd:548:37 */
  assign n603 = n600 | n602;
  /*# rtl/pia6821.vhd:549:32 */
  assign n604 = portb_ctrl[0]; // extract
  /*# rtl/pia6821.vhd:549:18 */
  assign n605 = irqb1 & n604;
  /*# rtl/pia6821.vhd:549:61 */
  assign n606 = portb_ctrl[3]; // extract
  /*# rtl/pia6821.vhd:549:47 */
  assign n607 = irqb2 & n606;
  /*# rtl/pia6821.vhd:549:37 */
  assign n608 = n605 | n607;
  /*# rtl/pia6821.vhd:56:17 */
  assign n610 = {n217, n213, n209, n205, n201, n197, n193, n189};
  /*# rtl/pia6821.vhd:60:17 */
  assign n611 = {n352, n345, n338, n331, n324, n317, n310, n303};
  /*# rtl/pia6821.vhd:61:17 */
  assign n612 = {n353, n346, n339, n332, n325, n318, n311, n304};
  /*# rtl/pia6821.vhd:67:17 */
  assign n613 = {n503, n496, n489, n482, n475, n468, n461, n454};
  /*# rtl/pia6821.vhd:68:17 */
  assign n614 = {n504, n497, n490, n483, n476, n469, n462, n455};
  /*# rtl/pia6821.vhd:201:3 */
  assign n615 = n232 ? n255 : porta_ddr;
  /*# rtl/pia6821.vhd:201:3 */
  always @(posedge clk or posedge rst)
    if (rst)
      n616 <= 8'b00000000;
    else
      n616 <= n615;
  /*# rtl/pia6821.vhd:201:3 */
  assign n617 = n232 ? n256 : porta_data;
  /*# rtl/pia6821.vhd:201:3 */
  always @(posedge clk or posedge rst)
    if (rst)
      n618 <= 8'b00000000;
    else
      n618 <= n617;
  /*# rtl/pia6821.vhd:201:3 */
  assign n619 = n232 ? n257 : porta_ctrl;
  /*# rtl/pia6821.vhd:201:3 */
  always @(posedge clk or posedge rst)
    if (rst)
      n620 <= 6'b000000;
    else
      n620 <= n619;
  /*# rtl/pia6821.vhd:201:3 */
  assign n621 = n232 ? n258 : portb_ddr;
  /*# rtl/pia6821.vhd:201:3 */
  always @(posedge clk or posedge rst)
    if (rst)
      n622 <= 8'b00000000;
    else
      n622 <= n621;
  /*# rtl/pia6821.vhd:201:3 */
  assign n623 = n232 ? n259 : portb_data;
  /*# rtl/pia6821.vhd:201:3 */
  always @(posedge clk or posedge rst)
    if (rst)
      n624 <= 8'b00000000;
    else
      n624 <= n623;
  /*# rtl/pia6821.vhd:201:3 */
  assign n625 = n232 ? n260 : portb_ctrl;
  /*# rtl/pia6821.vhd:201:3 */
  always @(posedge clk or posedge rst)
    if (rst)
      n626 <= 6'b000000;
    else
      n626 <= n625;
  /*# rtl/pia6821.vhd:201:3 */
  always @(posedge clk or posedge rst)
    if (rst)
      n627 <= 1'b0;
    else
      n627 <= n273;
  /*# rtl/pia6821.vhd:302:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n628 <= 1'b0;
    else
      n628 <= ca1;
  /*# rtl/pia6821.vhd:302:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n629 <= 1'b0;
    else
      n629 <= n358;
  /*# rtl/pia6821.vhd:302:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n630 <= 1'b0;
    else
      n630 <= n360;
  /*# rtl/pia6821.vhd:302:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n631 <= 1'b0;
    else
      n631 <= n364;
  /*# rtl/pia6821.vhd:337:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n632 <= 1'b0;
    else
      n632 <= ca2_i;
  /*# rtl/pia6821.vhd:337:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n633 <= 1'b0;
    else
      n633 <= n386;
  /*# rtl/pia6821.vhd:337:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n634 <= 1'b0;
    else
      n634 <= n388;
  /*# rtl/pia6821.vhd:337:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n635 <= 1'b0;
    else
      n635 <= n395;
  /*# rtl/pia6821.vhd:366:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n636 <= 1'b0;
    else
      n636 <= n433;
  /*# rtl/pia6821.vhd:438:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n637 <= 1'b0;
    else
      n637 <= cb1;
  /*# rtl/pia6821.vhd:438:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n638 <= 1'b0;
    else
      n638 <= n509;
  /*# rtl/pia6821.vhd:438:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n639 <= 1'b0;
    else
      n639 <= n511;
  /*# rtl/pia6821.vhd:438:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n640 <= 1'b0;
    else
      n640 <= n515;
  /*# rtl/pia6821.vhd:473:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n641 <= 1'b0;
    else
      n641 <= cb2_i;
  /*# rtl/pia6821.vhd:473:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n642 <= 1'b0;
    else
      n642 <= n537;
  /*# rtl/pia6821.vhd:473:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n643 <= 1'b0;
    else
      n643 <= n539;
  /*# rtl/pia6821.vhd:473:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n644 <= 1'b0;
    else
      n644 <= n546;
  /*# rtl/pia6821.vhd:503:3 */
  always @(negedge clk or posedge rst)
    if (rst)
      n645 <= 1'b0;
    else
      n645 <= n584;
endmodule

