Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AC12D20F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgLHCkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:40:14 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:44762 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727554AbgLHCkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:40:13 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08344597|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.260233-0.00193035-0.737837;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=huangshuosheng@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.J4MbkgC_1607395167;
Received: from allwinnertech.com(mailfrom:huangshuosheng@allwinnertech.com fp:SMTPD_---.J4MbkgC_1607395167)
          by smtp.aliyun-inc.com(10.147.41.138);
          Tue, 08 Dec 2020 10:39:30 +0800
From:   Shuosheng Huang <huangshuosheng@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: [RESEND v3 6/6] arm64: dts: allwinner: a100: Enable cpufreq on a100
Date:   Tue,  8 Dec 2020 10:39:26 +0800
Message-Id: <20201208023926.23476-1-huangshuosheng@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable cpufreq for all CPU cores on a100.

Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
---
 .../allwinner/sun50i-a100-allwinner-perf1.dts    | 16 ++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi   |  6 +++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
index 301793c72cb7..62a770f1a979 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
@@ -21,6 +21,22 @@ chosen {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&cpu1 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&cpu2 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&cpu3 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &pio {
 	vcc-pb-supply = <&reg_dcdc1>;
 	vcc-pc-supply = <&reg_eldo1>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index 8f370a175ce6..c6ff172bf599 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -26,7 +26,7 @@ cpu0: cpu@0 {
 			clocks = <&ccu CLK_CPUX>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			reg = <0x1>;
@@ -34,7 +34,7 @@ cpu@1 {
 			clocks = <&ccu CLK_CPUX>;
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			reg = <0x2>;
@@ -42,7 +42,7 @@ cpu@2 {
 			clocks = <&ccu CLK_CPUX>;
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			reg = <0x3>;
-- 
2.28.0

