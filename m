Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01152F858B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbhAOTbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:31:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38840 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbhAOTbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:31:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10FJUUSj068473;
        Fri, 15 Jan 2021 13:30:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610739030;
        bh=ET3b8SQtXsK1u7lP8qHpr68KgMOdtU3PXzl1PkdKbyk=;
        h=From:To:CC:Subject:Date;
        b=tePT5emK2GXilA8mvAq8RtwVucQpuxMy4rhnRSgUmmVkZIGeJ8jkqbgjpS5Jc7VU2
         taSw63g3M4XfMUdJlj+lZ4arOf0DOhvH4xo2bKEPY2X5zT50bCcQBg6r2zC+gEcWU8
         NtSNcsOI6+yjt99lACnWyLpkd1Wa8JLT4gvVuJG8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10FJUUKX097645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jan 2021 13:30:30 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 15
 Jan 2021 13:30:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 15 Jan 2021 13:30:30 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10FJUTa6061349;
        Fri, 15 Jan 2021 13:30:29 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] arm64: dts: ti: k3: mmc: fix dtbs_check warnings
Date:   Fri, 15 Jan 2021 21:30:16 +0200
Message-ID: <20210115193016.5581-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the dtbs_check produces below warnings
 sdhci@4f80000: clock-names:0: 'clk_ahb' was expected
 sdhci@4f80000: clock-names:1: 'clk_xin' was expected
 $nodename:0: 'sdhci@4f80000' does not match '^mmc(@.*)?$'

Fix above warnings by updating mmc DT definitions to follow
sdhci-am654.yaml bindings:
 - rename sdhci dt nodes to 'mmc@'
 - swap clk_xin/clk_ahb clocks, the clk_ahb clock expected to be defined
first

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi  |  4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi |  8 ++++----
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 18 +++++++++---------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 12591a854020..ceb579fb427d 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -256,7 +256,7 @@
 		#size-cells = <0>;
 	};
 
-	sdhci0: sdhci@4f80000 {
+	sdhci0: mmc@4f80000 {
 		compatible = "ti,am654-sdhci-5.1";
 		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
 		power-domains = <&k3_pds 47 TI_SCI_PD_EXCLUSIVE>;
@@ -280,7 +280,7 @@
 		dma-coherent;
 	};
 
-	sdhci1: sdhci@4fa0000 {
+	sdhci1: mmc@4fa0000 {
 		compatible = "ti,am654-sdhci-5.1";
 		reg = <0x0 0x4fa0000 0x0 0x260>, <0x0 0x4fb0000 0x0 0x134>;
 		power-domains = <&k3_pds 48 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 4e39f0325c03..3f23b913b498 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -506,8 +506,8 @@
 		reg = <0x00 0x04f80000 0x00 0x260>, <0x00 0x4f88000 0x00 0x134>;
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 91 TI_SCI_PD_EXCLUSIVE>;
-		clock-names = "clk_xin", "clk_ahb";
-		clocks = <&k3_clks 91 3>, <&k3_clks 91 0>;
+		clock-names = "clk_ahb", "clk_xin";
+		clocks = <&k3_clks 91 0>, <&k3_clks 91 3>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x6>;
@@ -525,8 +525,8 @@
 		reg = <0x00 0x04fb0000 0x00 0x260>, <0x00 0x4fb8000 0x00 0x134>;
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 92 TI_SCI_PD_EXCLUSIVE>;
-		clock-names = "clk_xin", "clk_ahb";
-		clocks = <&k3_clks 92 2>, <&k3_clks 92 1>;
+		clock-names = "clk_ahb", "clk_xin";
+		clocks = <&k3_clks 92 1>, <&k3_clks 92 2>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 2d526ea44a85..8c84dafb7125 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1032,13 +1032,13 @@
 		clock-names = "gpio";
 	};
 
-	main_sdhci0: sdhci@4f80000 {
+	main_sdhci0: mmc@4f80000 {
 		compatible = "ti,j721e-sdhci-8bit";
 		reg = <0x0 0x4f80000 0x0 0x1000>, <0x0 0x4f88000 0x0 0x400>;
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 91 TI_SCI_PD_EXCLUSIVE>;
-		clock-names = "clk_xin", "clk_ahb";
-		clocks = <&k3_clks 91 1>, <&k3_clks 91 0>;
+		clock-names = "clk_ahb", "clk_xin";
+		clocks = <&k3_clks 91 0>, <&k3_clks 91 1>;
 		assigned-clocks = <&k3_clks 91 1>;
 		assigned-clock-parents = <&k3_clks 91 2>;
 		bus-width = <8>;
@@ -1054,13 +1054,13 @@
 		dma-coherent;
 	};
 
-	main_sdhci1: sdhci@4fb0000 {
+	main_sdhci1: mmc@4fb0000 {
 		compatible = "ti,j721e-sdhci-4bit";
 		reg = <0x0 0x04fb0000 0x0 0x1000>, <0x0 0x4fb8000 0x0 0x400>;
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 92 TI_SCI_PD_EXCLUSIVE>;
-		clock-names = "clk_xin", "clk_ahb";
-		clocks = <&k3_clks 92 0>, <&k3_clks 92 5>;
+		clock-names = "clk_ahb", "clk_xin";
+		clocks = <&k3_clks 92 5>, <&k3_clks 92 0>;
 		assigned-clocks = <&k3_clks 92 0>;
 		assigned-clock-parents = <&k3_clks 92 1>;
 		ti,otap-del-sel-legacy = <0x0>;
@@ -1074,13 +1074,13 @@
 		dma-coherent;
 	};
 
-	main_sdhci2: sdhci@4f98000 {
+	main_sdhci2: mmc@4f98000 {
 		compatible = "ti,j721e-sdhci-4bit";
 		reg = <0x0 0x4f98000 0x0 0x1000>, <0x0 0x4f90000 0x0 0x400>;
 		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 93 TI_SCI_PD_EXCLUSIVE>;
-		clock-names = "clk_xin", "clk_ahb";
-		clocks = <&k3_clks 93 0>, <&k3_clks 93 5>;
+		clock-names = "clk_ahb", "clk_xin";
+		clocks = <&k3_clks 93 5>, <&k3_clks 93 0>;
 		assigned-clocks = <&k3_clks 93 0>;
 		assigned-clock-parents = <&k3_clks 93 1>;
 		ti,otap-del-sel-legacy = <0x0>;
-- 
2.17.1

