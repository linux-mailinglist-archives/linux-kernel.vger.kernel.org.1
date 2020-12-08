Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762442D243E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgLHHVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:21:35 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:60242 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgLHHVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:21:35 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07864059|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.527866-0.00690117-0.465233;FP=2650707151995048983|1|1|6|0|-1|-1|-1;HT=ay29a033018047193;MF=huangshuosheng@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.J4UVlKR_1607412047;
Received: from allwinnertech.com(mailfrom:huangshuosheng@allwinnertech.com fp:SMTPD_---.J4UVlKR_1607412047)
          by smtp.aliyun-inc.com(10.147.41.158);
          Tue, 08 Dec 2020 15:20:50 +0800
From:   Shuosheng Huang <huangshuosheng@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: [PATCH v4 5/6] arm64: dts: allwinner: a100: Add Add CPU Operating Performance Points table
Date:   Tue,  8 Dec 2020 15:20:46 +0800
Message-Id: <20201208072046.14186-1-huangshuosheng@allwinnertech.com>
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
 .../allwinner/sun50i-a100-allwinner-perf1.dts |  1 +
 .../dts/allwinner/sun50i-a100-cpu-opp.dtsi    | 90 +++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
index d34c2bb1079f..301793c72cb7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-a100.dtsi"
+#include "sun50i-a100-cpu-opp.dtsi"
 
 /{
 	model = "Allwinner A100 Perf1";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
new file mode 100644
index 000000000000..e245823d70e8
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
+			opp-microvolt-speed1 = <900000 900000 1200000>;
+			opp-microvolt-speed2 = <900000 900000 1200000>;
+		};
+
+		opp@600000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <600000000>;
+
+			opp-microvolt-speed0 = <900000 900000 1200000>;
+			opp-microvolt-speed1 = <900000 900000 1200000>;
+			opp-microvolt-speed2 = <900000 900000 1200000>;
+		};
+
+		opp@816000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <816000000>;
+
+			opp-microvolt-speed0 = <940000 940000 1200000>;
+			opp-microvolt-speed1 = <900000 900000 1200000>;
+			opp-microvolt-speed2 = <900000 900000 1200000>;
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
+			opp-microvolt-speed1 = <1060000 1060000 1200000>;
+			opp-microvolt-speed2 = <1030000 1030000 1200000>;
+		};
+
+		opp@1464000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1464000000>;
+
+			opp-microvolt-speed0 = <1180000 1180000 1200000>;
+			opp-microvolt-speed1 = <1180000 1180000 1200000>;
+			opp-microvolt-speed2 = <1130000 1130000 1200000>;
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
-- 
2.28.0

