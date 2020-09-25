Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54361278339
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgIYIvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgIYIvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:51:00 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AC220936;
        Fri, 25 Sep 2020 08:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601023859;
        bh=y5kjay8vQdDPybj7NrldtsrQKjzfRaOerm51iShfC54=;
        h=From:To:Cc:Subject:Date:From;
        b=KI8HITXXYi83ALtugdBIBFQ08LMHfi3mO+0FS2TQO6CxTfmF9XVnELjLTkM7f0vnH
         3dYtd2TiE7YSeY5ubwpI2Uz147kVOtlDFVYbM3CqBTIDExulR/QV1LD/dm7Mp+XrH4
         GnjsHb7LVY0VWkt3ZLUSZejkvZZAbAu/0zpPj3Zw=
Received: by pali.im (Postfix)
        id B22B7E94; Fri, 25 Sep 2020 10:50:56 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Heider <a.heider@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: espressobin: De-duplicate eMMC definitions
Date:   Fri, 25 Sep 2020 10:50:43 +0200
Message-Id: <20200925085043.16389-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eMMC definitions in files armada-3720-espressobin-emmc.dts and
armada-3720-espressobin-v7-emmc.dts is same. So move it into common
armada-3720-espressobin.dtsi file with status "disabled".

This change simplifies eMMC variants of DTS files for Espressobin.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Compiled DTB files armada-3720-espressobin-emmc.dtb and
armada-3720-espressobin-v7-emmc.dtb are identical as without applying
this patch.

Files armada-3720-espressobin.dtb and armada-3720-espressobin-v7.dtb
are slightly different compared to version without this patch.

Main change is that numering in all "phandle" nodes is shifted and
"sdhci0" node contains more attributes, but node is disabled.


Andre, could you test this change on Espressobin (without eMMC) if
everything is OK and there is no issue?

---
 .../marvell/armada-3720-espressobin-emmc.dts  | 18 --------------
 .../armada-3720-espressobin-v7-emmc.dts       | 18 --------------
 .../dts/marvell/armada-3720-espressobin.dtsi  | 24 +++++++++++++++++++
 3 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
index ec72a11ed80f..5c4d8f379704 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
@@ -21,24 +21,6 @@
 		     "marvell,armada3720", "marvell,armada3710";
 };
 
-/* U11 */
 &sdhci0 {
-	non-removable;
-	bus-width = <8>;
-	mmc-ddr-1_8v;
-	mmc-hs400-1_8v;
-	marvell,xenon-emmc;
-	marvell,xenon-tun-count = <9>;
-	marvell,pad-type = "fixed-1-8v";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc_pins>;
 	status = "okay";
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	mmccard: mmccard@0 {
-		compatible = "mmc-card";
-		reg = <0>;
-	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
index 6062a7df7342..4775a7eda481 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
@@ -36,24 +36,6 @@
 	label = "wan";
 };
 
-/* U11 */
 &sdhci0 {
-	non-removable;
-	bus-width = <8>;
-	mmc-ddr-1_8v;
-	mmc-hs400-1_8v;
-	marvell,xenon-emmc;
-	marvell,xenon-tun-count = <9>;
-	marvell,pad-type = "fixed-1-8v";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc_pins>;
 	status = "okay";
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	mmccard: mmccard@0 {
-		compatible = "mmc-card";
-		reg = <0>;
-	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 3169a820558f..8a1c678bea5f 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -58,6 +58,30 @@
 	phy-names = "sata-phy";
 };
 
+/* U11 */
+&sdhci0 {
+	/* Main DTS file for Espressobin is without eMMC */
+	status = "disabled";
+
+	non-removable;
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	marvell,xenon-emmc;
+	marvell,xenon-tun-count = <9>;
+	marvell,pad-type = "fixed-1-8v";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc_pins>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	mmccard: mmccard@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+	};
+};
+
 /* J1 */
 &sdhci1 {
 	wp-inverted;
-- 
2.20.1

