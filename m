Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D5C2B69EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgKQQUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:20:08 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50636 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbgKQQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:20:03 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHGJsSE106065;
        Tue, 17 Nov 2020 10:19:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605629994;
        bh=XVvA09sBrLg0rV2ApBpdwuOCVUoDHc1YDJGQuDiMfRs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GASktGpLxSNFWTDzmliqFsh57RmB3oTJIRneHeaQeRC5oMEOs932ARwvULxv3hM91
         nSBT/48rO2yHWsfAOgjSRzuvcpsqrDeAx618AXENpzISU0O30U0K1osq8dkYqJyfqg
         jAvJiCvKBvu+vUw7g8eTr8gQz/a2TBUmvYeLOybw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHGJsMO049926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 10:19:54 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 10:19:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 10:19:53 -0600
Received: from pxplinux063.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHGJhwI032251;
        Tue, 17 Nov 2020 10:19:50 -0600
From:   Sekhar Nori <nsekhar@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 2/4] arm64: dts: ti: k3: squelch warnings regarding no #address-cells for interrupt-controller
Date:   Tue, 17 Nov 2020 21:49:40 +0530
Message-ID: <20201117161942.38754-3-nsekhar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117161942.38754-1-nsekhar@ti.com>
References: <20201117161942.38754-1-nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With dtc 1.6.0, building TI device-tree files with W=2 results in warnings
like below for all interrupt controllers.

/bus@100000/bus@30000000/interrupt-controller1: Missing #address-cells in interrupt provider

Fix these by adding #address-cells = <0>; for all interrupt controllers in
TI device-tree files. Any other #address-cells value is really only needed
if interrupt-map property is being used (which is not the case for existing
TI device-tree files)

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi              |  5 +++++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi            |  2 ++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts        |  1 +
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi             |  3 +++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi       |  1 +
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts |  1 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             | 11 +++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       |  3 +++
 8 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index aa8725db0187..55aaa1404d7d 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -440,6 +440,7 @@
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
 		#interrupt-cells = <1>;
+		#address-cells = <0>;
 		ti,sci = <&dmsc>;
 		ti,sci-dev-id = <100>;
 		ti,interrupt-ranges = <0 392 32>;
@@ -461,6 +462,7 @@
 			interrupt-controller;
 			interrupt-parent = <&gic500>;
 			#interrupt-cells = <1>;
+			#address-cells = <0>;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <182>;
 			ti,interrupt-ranges = <0 64 64>,
@@ -474,6 +476,7 @@
 			interrupt-parent = <&intr_main_navss>;
 			msi-controller;
 			#interrupt-cells = <0>;
+			#address-cells = <0>;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <179>;
 			ti,interrupt-ranges = <0 0 256>;
@@ -670,6 +673,7 @@
 		interrupts = <192>, <193>, <194>, <195>, <196>, <197>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <96>;
 		ti,davinci-gpio-unbanked = <0>;
 		clocks = <&k3_clks 57 0>;
@@ -685,6 +689,7 @@
 		interrupts = <200>, <201>, <202>, <203>, <204>, <205>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <90>;
 		ti,davinci-gpio-unbanked = <0>;
 		clocks = <&k3_clks 58 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index ed42f13e7663..7fe5782a1f79 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -75,6 +75,7 @@
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
 		#interrupt-cells = <1>;
+		#address-cells = <0>;
 		ti,sci = <&dmsc>;
 		ti,sci-dev-id = <156>;
 		ti,interrupt-ranges = <0 712 16>;
@@ -89,6 +90,7 @@
 		interrupts = <60>, <61>, <62>, <63>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <56>;
 		ti,davinci-gpio-unbanked = <0>;
 		clocks = <&k3_clks 59 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index d12dd89f3405..376de272cb4e 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -236,6 +236,7 @@
 		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 72d6496e88dd..d07081b20aee 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -67,6 +67,7 @@
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
 		#interrupt-cells = <1>;
+		#address-cells = <0>;
 		ti,sci = <&dmsc>;
 		ti,sci-dev-id = <131>;
 		ti,interrupt-ranges = <8 392 56>;
@@ -85,6 +86,7 @@
 			interrupt-controller;
 			interrupt-parent = <&gic500>;
 			#interrupt-cells = <1>;
+			#address-cells = <0>;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <213>;
 			ti,interrupt-ranges = <0 64 64>,
@@ -97,6 +99,7 @@
 			reg = <0x00 0x33d00000 0x00 0x100000>;
 			interrupt-controller;
 			#interrupt-cells = <0>;
+			#address-cells = <0>;
 			interrupt-parent = <&main_navss_intr>;
 			msi-controller;
 			ti,sci = <&dmsc>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index eb2a78a53512..4801876bd107 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -102,6 +102,7 @@
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
 		#interrupt-cells = <1>;
+		#address-cells = <0>;
 		ti,sci = <&dmsc>;
 		ti,sci-dev-id = <137>;
 		ti,interrupt-ranges = <16 960 16>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 52e121155563..0490cb15f0c9 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -442,6 +442,7 @@
 		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index ffedd9531362..7f44692e15ec 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -114,6 +114,7 @@
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
 		#interrupt-cells = <1>;
+		#address-cells = <0>;
 		ti,sci = <&dmsc>;
 		ti,sci-dev-id = <131>;
 		ti,interrupt-ranges = <8 392 56>;
@@ -135,6 +136,7 @@
 			interrupt-controller;
 			interrupt-parent = <&gic500>;
 			#interrupt-cells = <1>;
+			#address-cells = <0>;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <213>;
 			ti,interrupt-ranges = <0 64 64>,
@@ -149,6 +151,7 @@
 			interrupt-parent = <&main_navss_intr>;
 			msi-controller;
 			#interrupt-cells = <0>;
+			#address-cells = <0>;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <209>;
 			ti,interrupt-ranges = <0 0 256>;
@@ -948,6 +951,7 @@
 			     <260>, <261>, <262>, <263>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <128>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
@@ -964,6 +968,7 @@
 		interrupts = <288>, <289>, <290>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <36>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
@@ -981,6 +986,7 @@
 			     <268>, <269>, <270>, <271>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <128>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
@@ -997,6 +1003,7 @@
 		interrupts = <292>, <293>, <294>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <36>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 108 TI_SCI_PD_EXCLUSIVE>;
@@ -1014,6 +1021,7 @@
 			     <276>, <277>, <278>, <279>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <128>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
@@ -1030,6 +1038,7 @@
 		interrupts = <296>, <297>, <298>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <36>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
@@ -1047,6 +1056,7 @@
 			     <284>, <285>, <286>, <287>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <128>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
@@ -1063,6 +1073,7 @@
 		interrupts = <300>, <301>, <302>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <36>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index e581cb1d87ee..ed3098ed7b56 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -102,6 +102,7 @@
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
 		#interrupt-cells = <1>;
+		#address-cells = <0>;
 		ti,sci = <&dmsc>;
 		ti,sci-dev-id = <137>;
 		ti,interrupt-ranges = <16 960 16>;
@@ -116,6 +117,7 @@
 		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <84>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
@@ -132,6 +134,7 @@
 		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#address-cells = <0>;
 		ti,ngpio = <84>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
-- 
2.17.1

