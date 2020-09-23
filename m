Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B602327639A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIWWKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:10:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33794 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:10:07 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NMA3ES114308;
        Wed, 23 Sep 2020 17:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600899003;
        bh=GD1fEmEazARBk317pqpPuhv10qzudlYM1CkQIflwrTc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UqnwngathM4F0rPUNW7cPnKxFD7AfS1M49Ruf7/Ov/lEsO1+tw6TVJvhYVPl+E4r0
         x2Wzird1p86TkVgxYNWKTV0YKqSzbXISovJgtjvApoJHUPg/FnPqdFcBh3+s4jOEY7
         2xqUkVzKEd6taW7tTphWGujGD7vkilfnEyOcD3xc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NMA3Fo050120;
        Wed, 23 Sep 2020 17:10:03 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 17:10:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 17:10:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NMA1mY095239;
        Wed, 23 Sep 2020 17:10:02 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v4 3/4] arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss node
Date:   Thu, 24 Sep 2020 01:09:37 +0300
Message-ID: <20200923220938.30788-4-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923220938.30788-1-grygorii.strashko@ti.com>
References: <20200923220938.30788-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for The TI J7200 MCU SoC Gigabit Ethernet two ports Switch
subsystem (MCU CPSW NUSS).

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 334c2fb2c082..c168171da429 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -34,6 +34,20 @@
 		};
 	};
 
+	mcu_conf: syscon@40f00000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x00 0x40f00000 0x00 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x40f00000 0x20000>;
+
+		phy_gmii_sel: phy@4040 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4040 0x4>;
+			#phy-cells = <1>;
+		};
+	};
+
 	chipid@43000014 {
 		compatible = "ti,am654-chipid";
 		reg = <0x00 0x43000014 0x00 0x4>;
@@ -136,4 +150,64 @@
 			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
 		};
 	};
+
+	mcu_cpsw: ethernet@46000000 {
+		compatible = "ti,j721e-cpsw-nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x00 0x46000000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0x46000000 0x00 0x200000>;
+		dma-coherent;
+		clocks = <&k3_clks 18 21>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 18 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&mcu_udmap 0xf000>,
+		       <&mcu_udmap 0xf001>,
+		       <&mcu_udmap 0xf002>,
+		       <&mcu_udmap 0xf003>,
+		       <&mcu_udmap 0xf004>,
+		       <&mcu_udmap 0xf005>,
+		       <&mcu_udmap 0xf006>,
+		       <&mcu_udmap 0xf007>,
+		       <&mcu_udmap 0x7000>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cpsw_port1: port@1 {
+				reg = <1>;
+				ti,mac-only;
+				label = "port1";
+				ti,syscon-efuse = <&mcu_conf 0x200>;
+				phys = <&phy_gmii_sel 1>;
+			};
+		};
+
+		davinci_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 18 21>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 18 2>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 858 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
 };
-- 
2.17.1

