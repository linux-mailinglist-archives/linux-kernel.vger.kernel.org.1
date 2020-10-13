Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF46028CA01
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391032AbgJMIRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:17:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50578 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgJMIRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:17:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09D8GthU114502;
        Tue, 13 Oct 2020 03:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602577015;
        bh=zo2wxbpMBmimLkyAq0CF6UYmn27MgCFWIOPK/30nNeU=;
        h=From:To:CC:Subject:Date;
        b=nLIjrUbnNj+9lPo0YO+Z4j7PxDOMWgUXtDETFA/d2SeSTvCnZMmUn8xt1jS4//ghN
         hqvwOs8eZGgC8fDuVN36I3S2t59whTZVixwmAIKlHyPGSLUwoHPmdFKaCUskw22VG1
         6YjuK859e3rqHAlyt11n107eBUActo+YmsU/Ek/M=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09D8GtjA039820
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 03:16:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 13
 Oct 2020 03:16:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 13 Oct 2020 03:16:55 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09D8GqSY104847;
        Tue, 13 Oct 2020 03:16:53 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j7200-mcu-wakeup: Enable ADC support
Date:   Tue, 13 Oct 2020 13:46:50 +0530
Message-ID: <20201013081650.26090-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J7200 has a single instance of 8 channel ADC in MCU domain. Add DT node
for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     |  6 ++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index ef03e7636b66..7d2ff1c3b50f 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -213,3 +213,9 @@ &usb0 {
 	dr_mode = "otg";
 	maximum-speed = "high-speed";
 };
+
+&tscadc0 {
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index eb2a78a53512..bb1fe9c12e44 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -270,4 +270,23 @@ hbmc: hyperbus@47034000 {
 			mux-controls = <&hbmc_mux 0>;
 		};
 	};
+
+	tscadc0: tscadc@40200000 {
+		compatible = "ti,am3359-tscadc";
+		reg = <0x00 0x40200000 0x00 0x1000>;
+		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 0 1>;
+		assigned-clocks = <&k3_clks 0 3>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "adc_tsc_fck";
+		dmas = <&main_udmap 0x7400>,
+			<&main_udmap 0x7401>;
+		dma-names = "fifo0", "fifo1";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am3359-adc";
+		};
+	};
 };
-- 
2.28.0

