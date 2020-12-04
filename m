Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F96F2CE871
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgLDHMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:12:01 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:53624 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725550AbgLDHMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:12:01 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07448996|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.600806-0.00119886-0.397995;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=huangshuosheng@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.J2poTyq_1607065868;
Received: from allwinnertech.com(mailfrom:huangshuosheng@allwinnertech.com fp:SMTPD_---.J2poTyq_1607065868)
          by smtp.aliyun-inc.com(10.147.41.143);
          Fri, 04 Dec 2020 15:11:11 +0800
From:   Shuosheng Huang <huangshuosheng@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: [PATCH 2/2] arm64: dts: allwinner: a100: Add CPU Operating Performance Points table
Date:   Fri,  4 Dec 2020 15:11:07 +0800
Message-Id: <20201204071107.25206-1-huangshuosheng@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an Operating Performance Points table for the CPU cores to
enable Dynamic Voltage & Frequency Scaling on the A100.

Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
---
 .../allwinner/sun50i-a100-allwinner-perf1.dts |  5 ++
 .../dts/allwinner/sun50i-a100-cpu-opp.dtsi    | 90 +++++++++++++++++++
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi |  8 ++
 3 files changed, 103 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
index d34c2bb1079f..7c579923f973 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-a100.dtsi"
+#include "sun50i-a100-cpu-opp.dtsi"
 
 /{
 	model = "Allwinner A100 Perf1";
@@ -20,6 +21,10 @@ chosen {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &pio {
 	vcc-pb-supply = <&reg_dcdc1>;
 	vcc-pc-supply = <&reg_eldo1>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
new file mode 100644
index 000000000000..bc8ceaa38392
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
+// Copyright (c) 2020 ShuoSheng Huang <huangshuosheng@allwinnertech.com>
+
+/ {
+	cpu_opp_table: cpu-opp-table {
+		compatible = "allwinner,sun50i-h6-operating-points";
+		nvmem-cells = <&cpu_speed_grade>;
+		opp-shared;
+
+		opp@408000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <408000000>;
+
+			opp-microvolt-speed0 = <900000 900000 1200000>;
+			opp-microvolt-speed0 = <900000 900000 1200000>;
+			opp-microvolt-speed0 = <900000 900000 1200000>;
+		};
+
+		opp@600000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <600000000>;
+
+			opp-microvolt-speed0 = <900000 900000 1200000>;
+			opp-microvolt-speed0 = <900000 900000 1200000>;
+			opp-microvolt-speed0 = <900000 900000 1200000>;
+		};
+
+		opp@816000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <816000000>;
+
+			opp-microvolt-speed0 = <940000 940000 1200000>;
+			opp-microvolt-speed0 = <900000 900000 1200000>;
+			opp-microvolt-speed0 = <900000 900000 1200000>;
+		};
+
+		opp@1080000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1080000000>;
+
+			opp-microvolt-speed0 = <1020000 1020000 1200000>;
+			opp-microvolt-speed1 = <980000 980000 1200000>;
+			opp-microvolt-speed2 = <950000 950000 1200000>;
+		};
+
+		opp@1200000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1200000000>;
+
+			opp-microvolt-speed0 = <1100000 1100000 1200000>;
+			opp-microvolt-speed1 = <1020000 1020000 1200000>;
+			opp-microvolt-speed2 = <1000000 1000000 1200000>;
+		};
+
+		opp@1320000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1320000000>;
+
+			opp-microvolt-speed0 = <1160000 1160000 1200000>;
+			opp-microvolt-speed0 = <1060000 1060000 1200000>;
+			opp-microvolt-speed0 = <1030000 1030000 1200000>;
+		};
+
+		opp@1464000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1464000000>;
+
+			opp-microvolt-speed0 = <1180000 1180000 1200000>;
+			opp-microvolt-speed0 = <1180000 1180000 1200000>;
+			opp-microvolt-speed0 = <1130000 1130000 1200000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index cc321c04f121..8f370a175ce6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -23,6 +23,7 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0x0>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 
 		cpu@1 {
@@ -30,6 +31,7 @@ cpu@1 {
 			device_type = "cpu";
 			reg = <0x1>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 
 		cpu@2 {
@@ -37,6 +39,7 @@ cpu@2 {
 			device_type = "cpu";
 			reg = <0x2>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 
 		cpu@3 {
@@ -44,6 +47,7 @@ cpu@3 {
 			device_type = "cpu";
 			reg = <0x3>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 	};
 
@@ -121,6 +125,10 @@ efuse@3006000 {
 			ths_calibration: calib@14 {
 				reg = <0x14 8>;
 			};
+
+			cpu_speed_grade: cpu-speed-grade@1c {
+				reg = <0x1c 0x2>;
+			};
 		};
 
 		pio: pinctrl@300b000 {
-- 
2.28.0

