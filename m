Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAAF276396
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgIWWJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:09:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33402 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:09:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NM9n3n113986;
        Wed, 23 Sep 2020 17:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600898989;
        bh=Jg0udFslsQmi5iIK71UKn6uMHLsLqUEcva0Jc1wUErQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fOycuvNzQo2QOxMcK3SVMimYuP1ov2xqwm8sD2WYeZ4hpdx6gHZBNgK+1SqfU1E4R
         QvikWtJ8k8DMUkkBALz+i5SXwvucZNKCmaGnbLVWVWka/zVg0mDJkW3mmyidCX+CB3
         dcDU6QhQPApJsU3nPV9bB5G5dYfJzJ8F90B3htiM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NM9ndF049612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 17:09:49 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 17:09:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 17:09:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NM9mSq045198;
        Wed, 23 Sep 2020 17:09:48 -0500
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
Subject: [PATCH v4 1/4] arm64: dts: ti: k3-j7200: add DMA support
Date:   Thu, 24 Sep 2020 01:09:35 +0300
Message-ID: <20200923220938.30788-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923220938.30788-1-grygorii.strashko@ti.com>
References: <20200923220938.30788-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

Add the ringacc and udmap nodes for Main and MCU NAVSS.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 36 +++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 44 +++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 3df49577b06a..a44c3388c1a8 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -93,6 +93,42 @@
 			interrupt-names = "rx_011";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		main_ringacc: ringacc@3c000000 {
+			compatible = "ti,am654-navss-ringacc";
+			reg =	<0x00 0x3c000000 0x00 0x400000>,
+				<0x00 0x38000000 0x00 0x400000>,
+				<0x00 0x31120000 0x00 0x100>,
+				<0x00 0x33000000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			ti,num-rings = <1024>;
+			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <211>;
+			msi-parent = <&main_udmass_inta>;
+		};
+
+		main_udmap: dma-controller@31150000 {
+			compatible = "ti,j721e-navss-main-udmap";
+			reg =	<0x00 0x31150000 0x00 0x100>,
+				<0x00 0x34000000 0x00 0x100000>,
+				<0x00 0x35000000 0x00 0x100000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <1>;
+
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <212>;
+			ti,ringacc = <&main_ringacc>;
+
+			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
+						<0x0f>, /* TX_HCHAN */
+						<0x10>; /* TX_UHCHAN */
+			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
+						<0x0b>, /* RX_HCHAN */
+						<0x0c>; /* RX_UHCHAN */
+			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
+		};
 	};
 
 	main_pmx0: pinctrl@11c000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index ec2745e0768e..334c2fb2c082 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -92,4 +92,48 @@
 		ti,sci-dev-id = <137>;
 		ti,interrupt-ranges = <16 960 16>;
 	};
+
+	mcu_navss: bus@28380000 {
+		compatible = "simple-mfd";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
+		dma-coherent;
+		dma-ranges;
+		ti,sci-dev-id = <232>;
+
+		mcu_ringacc: ringacc@2b800000 {
+			compatible = "ti,am654-navss-ringacc";
+			reg =	<0x00 0x2b800000 0x00 0x400000>,
+				<0x00 0x2b000000 0x00 0x400000>,
+				<0x00 0x28590000 0x00 0x100>,
+				<0x00 0x2a500000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			ti,num-rings = <286>;
+			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <235>;
+			msi-parent = <&main_udmass_inta>;
+		};
+
+		mcu_udmap: dma-controller@285c0000 {
+			compatible = "ti,j721e-navss-mcu-udmap";
+			reg =	<0x00 0x285c0000 0x00 0x100>,
+				<0x00 0x2a800000 0x00 0x40000>,
+				<0x00 0x2aa00000 0x00 0x40000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <1>;
+
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <236>;
+			ti,ringacc = <&mcu_ringacc>;
+
+			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
+						<0x0f>; /* TX_HCHAN */
+			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
+						<0x0b>; /* RX_HCHAN */
+			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
+		};
+	};
 };
-- 
2.17.1

