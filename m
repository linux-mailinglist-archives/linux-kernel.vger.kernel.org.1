Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6D2B442A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgKPM7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:59:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgKPM7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:59:39 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F07822384;
        Mon, 16 Nov 2020 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605531578;
        bh=3MLkjMOzpkCzhqMZjpieN2eCUoUlK4znktltjX5CDf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ThjPlXBRSpOxlFAhR3QrGwTfVonSwzLJvrU+8tiQpxFp0JMB9MMyiCJBkjxJD6D6o
         LOp0loFZ69GaXOzb5APqJMgQHqbJlcGhRMCWG4+I7S+n8Aw5wNWA6gKcKD6MiVUaX2
         luqD7tWUlznH5gG3iYhK/UnjTZB2n42T/IY2FYB4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kee6Z-00Fyfk-Si; Mon, 16 Nov 2020 13:59:35 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "John Stultz" <john.stultz@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] dts: hisilicon: add support for the PMIC found on Hikey 970
Date:   Mon, 16 Nov 2020 13:59:34 +0100
Message-Id: <eb5250f1bb0d19efe2d3e48ba08f5f1a6613e175.1605530560.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605530560.git.mchehab+huawei@kernel.org>
References: <cover.1605530560.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree for the HiSilicon 6421v600 SPMI PMIC, used
on HiKey970 board.

As we now have support for it, change the fixed regulators
used by the SD I/O to use the proper LDO supplies.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |  22 +-
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     | 197 ++++++++++++++++++
 2 files changed, 200 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index fe6600dbad61..1f221cb97690 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -12,6 +12,7 @@
 
 #include "hi3670.dtsi"
 #include "hikey970-pinctrl.dtsi"
+#include "hikey970-pmic.dtsi"
 
 / {
 	model = "HiKey970";
@@ -39,23 +40,6 @@ memory@0 {
 		reg = <0x0 0x0 0x0 0x0>;
 	};
 
-	sd_1v8: regulator-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
-
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
@@ -425,8 +409,8 @@ &dwmmc1 {
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
index 000000000000..7d79017ccfa5
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Hi6421v600 SPMI PMIC used at the HiKey970 Development Board
+ *
+ * Copyright (C) 2020, Huawei Tech. Co., Ltd.
+ */
+
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	spmi: spmi@fff24000 {
+		compatible = "hisilicon,kirin970-spmi-controller";
+		#address-cells = <2>;
+		#size-cells = <0>;
+		status = "okay";
+		reg = <0x0 0xfff24000 0x0 0x1000>;
+		spmi-channel = <2>;
+
+		pmic: pmic@0 {
+			compatible = "hisilicon,hi6421-spmi";
+			reg = <0 SPMI_USID>;
+
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			gpios = <&gpio28 0 0>;
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
2.28.0

