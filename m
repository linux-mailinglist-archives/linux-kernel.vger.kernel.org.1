Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEAF242C96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHLP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 11:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgHLP5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75F9823110;
        Wed, 12 Aug 2020 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=1xTwSBaK0XrIWe9LbB9uGe8VVCvj3/yyWB6BQEgYbYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1oxLthwueJZS1fIQ6xb35trXa3byng0WuSMJXgXp40nrqHbZxFfflQowzju+vrDL
         c+l0Zj52jwEWAOjJAu+lvRFjb6So1hvAK4pkvwBRu57z/WwxxP6sgB+lpdppULuk6o
         +n4cVwKNRPf/oeikfZ9Xvh7DMIRqcfoFzROPigfg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7b-005t7c-Hj; Wed, 12 Aug 2020 17:56:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 44/44] dt: hisilicon: add support for the PMIC found on Hikey 970
Date:   Wed, 12 Aug 2020 17:56:54 +0200
Message-Id: <dd91299e8ef786b3ca7ecdf3e13dec675420cefe.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree for the HiSilicon 6421v600 SPMI PMIC, used
on HiKey970 board.

As we now have support for it, change the fixed regulators
used by the SD I/O to use the proper LDO supplies.

We'll keep the 3v3 fixed regulator, as this will be used
by the DRM/KMS driver. So, let's just rename it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |  16 +-
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     | 200 ++++++++++++++++++
 2 files changed, 204 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 01234a175dcd..c8a72c0873bf 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -12,6 +12,7 @@
 
 #include "hi3670.dtsi"
 #include "hikey970-pinctrl.dtsi"
+#include "hikey970-pmic.dtsi"
 
 / {
 	model = "HiKey970";
@@ -39,7 +40,7 @@ memory@0 {
 		reg = <0x0 0x0 0x0 0x0>;
 	};
 
-	sd_1v8: regulator-1v8 {
+	fixed_1v8: regulator-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
 		regulator-min-microvolt = <1800000>;
@@ -47,15 +48,6 @@ sd_1v8: regulator-1v8 {
 		regulator-always-on;
 	};
 
-	sd_3v3: regulator-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
 	wlan_en: wlan-en-1-8v {
 		compatible = "regulator-fixed";
 		regulator-name = "wlan-en-regulator";
@@ -402,8 +394,8 @@ &dwmmc1 {
 	pinctrl-0 = <&sd_pmx_func
 		     &sd_clk_cfg_func
 		     &sd_cfg_func>;
-	vmmc-supply = <&sd_3v3>;
-	vqmmc-supply = <&sd_1v8>;
+	vmmc-supply = <&ldo16>;
+	vqmmc-supply = <&ldo9>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
new file mode 100644
index 000000000000..2a6c366d9be6
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Hi6421v600 SPMI PMIC used at the HiKey970 Development Board
+ *
+ * Copyright (C) 2020, Huawei Tech. Co., Ltd.
+ */
+
+/ {
+	spmi: spmi@fff24000 {
+		compatible = "hisilicon,spmi-controller";
+		#address-cells = <2>;
+		#size-cells = <0>;
+		status = "ok";
+		reg = <0x0 0xfff24000 0x0 0x1000>;
+		spmi-channel = <2>;
+
+		pmic: pmic@0 {
+			compatible = "hisilicon,hi6421-spmi-pmic";
+			slave_id = <0>;
+			reg = <0 0>;
+
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			gpios = <&gpio28 0 0>;
+			irq-num = <16>;
+			irq-array = <2>;
+			irq-mask-addr = <0x202 2>;
+			irq-addr = <0x212 2>;
+
+			regulators {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ldo3: ldo3@16 {
+					reg = <0x16>;
+					vsel-reg = <0x51>;
+
+					regulator-name = "ldo3";
+					regulator-min-microvolt = <1500000>;
+					regulator-max-microvolt = <2000000>;
+					regulator-boot-on;
+
+					enable-mask = <0x01>;
+
+					voltage-table = <1500000>, <1550000>,
+							<1600000>, <1650000>,
+							<1700000>, <1725000>,
+							<1750000>, <1775000>,
+							<1800000>, <1825000>,
+							<1850000>, <1875000>,
+							<1900000>, <1925000>,
+							<1950000>, <2000000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+
+				ldo4: ldo4@17 { /* 40 PIN */
+					reg = <0x17>;
+					vsel-reg = <0x52>;
+
+					regulator-name = "ldo4";
+					regulator-min-microvolt = <1725000>;
+					regulator-max-microvolt = <1900000>;
+					regulator-boot-on;
+
+					enable-mask = <0x01>;
+					idle-mode-mask = <0x10>;
+					eco-microamp = <10000>;
+
+					hi6421-vsel = <0x52 0x07>;
+					voltage-table = <1725000>, <1750000>,
+							<1775000>, <1800000>,
+							<1825000>, <1850000>,
+							<1875000>, <1900000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+
+				ldo9: ldo9@1C { /* SDCARD I/O */
+					reg = <0x1C>;
+					vsel-reg = <0x57>;
+
+					regulator-name = "ldo9";
+					regulator-min-microvolt = <1750000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
+
+					enable-mask = <0x01>;
+					idle-mode-mask = <0x10>;
+					eco-microamp = <10000>;
+
+					voltage-table = <1750000>, <1800000>,
+							<1825000>, <2800000>,
+							<2850000>, <2950000>,
+							<3000000>, <3300000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <360>;
+				};
+
+				ldo15: ldo15@21 { /* UFS */
+					reg = <0x21>;
+					vsel-reg = <0x5c>;
+
+					regulator-name = "ldo15";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
+
+					enable-mask = <0x01>;
+					idle-mode-mask = <0x10>;
+					eco-microamp = <10000>;
+
+					voltage-table = <1800000>, <1850000>,
+							<2400000>, <2600000>,
+							<2700000>, <2850000>,
+							<2950000>, <3000000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+
+				ldo16: ldo16@22 { /* SD */
+					reg = <0x22>;
+					vsel-reg = <0x5d>;
+
+					regulator-name = "ldo16";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-boot-on;
+
+					enable-mask = <0x01>;
+					idle-mode-mask = <0x10>;
+					eco-microamp = <10000>;
+
+					voltage-table = <1800000>, <1850000>,
+							<2400000>, <2600000>,
+							<2700000>, <2850000>,
+							<2950000>, <3000000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <360>;
+				};
+
+				ldo17: ldo17@23 {
+					reg = <0x23>;
+					vsel-reg = <0x5e>;
+
+					regulator-name = "ldo17";
+					regulator-min-microvolt = <2500000>;
+					regulator-max-microvolt = <3300000>;
+
+					enable-mask = <0x01>;
+					idle-mode-mask = <0x10>;
+					eco-microamp = <10000>;
+
+					voltage-table = <2500000>, <2600000>,
+							<2700000>, <2800000>,
+							<3000000>, <3100000>,
+							<3200000>, <3300000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+
+				ldo33: ldo33@32 { /* PEX8606 */
+					reg = <0x32>;
+					vsel-reg = <0x6d>;
+					regulator-name = "ldo33";
+					regulator-min-microvolt = <2500000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
+
+					enable-mask = <0x01>;
+
+					voltage-table = <2500000>, <2600000>,
+							<2700000>, <2800000>,
+							<3000000>, <3100000>,
+							<3200000>, <3300000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+
+				ldo34: ldo34@33 { /* GPS AUX IN VDD */
+					reg = <0x33>;
+					vsel-reg = <0x6e>;
+
+					regulator-name = "ldo34";
+					regulator-min-microvolt = <2600000>;
+					regulator-max-microvolt = <3300000>;
+
+					enable-mask = <0x01>;
+
+					voltage-table = <2600000>, <2700000>,
+							<2800000>, <2900000>,
+							<3000000>, <3100000>,
+							<3200000>, <3300000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+			};
+		};
+	};
+};
-- 
2.26.2

