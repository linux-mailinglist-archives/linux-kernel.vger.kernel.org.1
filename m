Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5821A27E86D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgI3MVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:21:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40364 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbgI3MUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:20:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UCKjrM096052;
        Wed, 30 Sep 2020 07:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601468445;
        bh=2leD+MALZPIh4icko8e0nqOrMVsXZJUEsXFu5FT9lpM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mWHSAZqdf3UbjbYjxYv2dZYhMnFGdkZlmSLyIiJzIVxwaWipMtp8iYX79t47zDCeI
         lH9hfapz88bYCVFMmcYFNQt6BHfffVMAzHwIiVFROByCUrVOA2lP7zZhAOlU5jjkI/
         xPe+k1w3PQma3NgwwpA06h47Ti/1TwA34WzljLLA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UCKjJt064227
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 07:20:45 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 07:20:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 07:20:44 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UCKXr6049132;
        Wed, 30 Sep 2020 07:20:43 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <nm@ti.com>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 4/6] arm64: dts: ti: k3-j7200-main: Add USB controller
Date:   Wed, 30 Sep 2020 15:20:30 +0300
Message-ID: <20200930122032.23481-5-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930122032.23481-1-rogerq@ti.com>
References: <20200930122032.23481-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

j7200 has on USB controller instance. Add that.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index c638c3d8c0f2..72d6496e88dd 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -416,4 +416,34 @@
 		no-1-8-v;
 		dma-coherent;
 	};
+
+	usbss0: cdns-usb@4104000 {
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x4104000 0x00 0x100>;
+		dma-coherent;
+		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 288 12>, <&k3_clks 288 3>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 288 12>;	/* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 288 13>; /* HFOSC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		usb0: usb@6000000 {
+			compatible = "cdns,usb3";
+			reg = <0x00 0x6000000 0x00 0x10000>,
+			      <0x00 0x6010000 0x00 0x10000>,
+			      <0x00 0x6020000 0x00 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,	/* irq.0 */
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,	/* irq.6 */
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;	/* otgirq.0 */
+			interrupt-names = "host",
+					  "peripheral",
+					  "otg";
+			maximum-speed = "super-speed";
+			dr_mode = "otg";
+		};
+	};
 };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

