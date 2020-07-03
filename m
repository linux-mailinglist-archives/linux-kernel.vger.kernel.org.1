Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750F7213F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 20:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGCSpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 14:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgGCSpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 14:45:06 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9CB20884;
        Fri,  3 Jul 2020 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593801905;
        bh=JbJl3AOcfwpMrT2bhuu2+7cLxEZGnG5dKbG+j3+JUrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkiH/27Dr8sQeImAZ0DOy4Ivi4tSPQ91X3QnHpDLX3rO0Ey7JklkClgqu0kvO+Bvr
         +46xyMLfqCtR+FXI/hCQtrYO8imOaAe9Vcg4ioyCn0FLw7dKrtc7Mpc/33aiPz5DVR
         Pb3TCSviKdd9NeOzK69zpfApAUB5ITwTeRnniyKY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v3 2/3] ARM: dts: exynos: Define fixed regulators in root node for consistency in Arndale
Date:   Fri,  3 Jul 2020 20:44:50 +0200
Message-Id: <20200703184451.19535-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703184451.19535-1-krzk@kernel.org>
References: <20200703184451.19535-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the regulators node and define fixed regulators directly under
the root node.  This makes Exynos5250 Arndale board consistent with
other Exynos boards.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Remove also "reg" property

Changes since v1:
1. New patch
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 86 ++++++++++--------------
 1 file changed, 37 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index c4cc7611898c..59872d83da6e 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -84,60 +84,48 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		main_dc_reg: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "MAIN_DC";
-			regulator-always-on;
-		};
+	main_dc_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "MAIN_DC";
+		regulator-always-on;
+	};
 
-		mmc_reg: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "VDD_MMC";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			regulator-always-on;
-		};
+	mmc_reg: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_MMC";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
 
-		reg_hdmi_en: regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "hdmi-en";
-			regulator-always-on;
-		};
+	reg_hdmi_en: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "hdmi-en";
+		regulator-always-on;
+	};
 
-		vcc_1v2_reg: regulator@3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "VCC_1V2";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-always-on;
-		};
+	vcc_1v2_reg: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+	};
 
-		vcc_1v8_reg: regulator@4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "VCC_1V8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
+	vcc_1v8_reg: regulator-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
 
-		vcc_3v3_reg: regulator@5 {
-			compatible = "regulator-fixed";
-			reg = <5>;
-			regulator-name = "VCC_3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	vcc_3v3_reg: regulator-5 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
 	};
 
 	sound {
-- 
2.17.1

