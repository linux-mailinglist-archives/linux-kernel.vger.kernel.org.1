Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1259022400F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgGQQBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 12:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgGQQBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:01:01 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54E2F21741;
        Fri, 17 Jul 2020 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595001660;
        bh=PHFcsOvSx0eeMSnfIXvWspi9b5ibhDTxlVNjTZcilaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FI+KBFNJvoZrc2MqqB1ASo9dbFdqGwL70n/9fpNpVIeU/t2Fv+bAzy7vaEdocmFPp
         m5+vAj0SFdMDFc8spft59hG81cUJVM10pta6YG/I8ZbFFVLroqCFqEbtgzQuySKCsy
         rAzxGtKt60uhm16kPNCq1xUMTnrKRqdt4cSpZfa0=
Received: by wens.tw (Postfix, from userid 1000)
        id 45C965FDC0; Sat, 18 Jul 2020 00:00:55 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] arm64: dts: allwinner: h5: Add CPU Operating Performance Points table
Date:   Sat, 18 Jul 2020 00:00:51 +0800
Message-Id: <20200717160053.31191-7-wens@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717160053.31191-1-wens@kernel.org>
References: <20200717160053.31191-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Add an OPP (Operating Performance Points) table for the CPU cores for
boards to include to DVFS (Dynamic Voltage & Frequency Scaling) on the
H5. The table originates from Armbian, but the maximum voltage is raised
slightly to account for boards using slightly higher voltages.

The table and tie in to the CPU cores are put in a separate dtsi file
that board files can include to opt in. Or they can define their own
tables if the standard one does not fit.

This has been tested on the Libre Computer ALL-H3-CC-H5 and the Bananapi
M2+ v1.2 H5, both with adequate cooling. The former has a fixed 1.2V
regulator, while the latter has a GPIO controlled regulator switchable
between 1.1V and 1.3V.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Unfortunately I couldn't find the original source and author for the OPP
table. So for now I put my name on it. If someone wants to claim
authorship please do so.

---
 .../boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi
new file mode 100644
index 000000000000..9d3a9fa78e2e
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2020 Chen-Yu Tsai <wens@csie.org>
+
+/ {
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <1000000 1000000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@648000000 {
+			opp-hz = /bits/ 64 <648000000>;
+			opp-microvolt = <1040000 1040000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1080000 1080000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@912000000 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-microvolt = <1120000 1120000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-microvolt = <1160000 1160000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1200000 1200000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-microvolt = <1240000 1240000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <1260000 1260000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1152000000 {
+			opp-hz = /bits/ 64 <1152000000>;
+			opp-microvolt = <1300000 1300000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
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
2.27.0

