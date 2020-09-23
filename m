Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97438275D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIWQcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:32:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58930 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgIWQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:32:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NGW5Gn062943;
        Wed, 23 Sep 2020 11:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600878725;
        bh=OO3JF5ndowKahtDEP41dXGZcFcG7VIMJgjO783W72yM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HkQlYmxpjB0F6PVjQY+zf1DVPT85hoqRe8tTdxzreOMT841WsimhDuxEMWSazGT5y
         kSuj52FGDLui+2rJZ4JwwtfazOsjDtj2SwrUqscsjCfmeWRINZ830X6FKr79zaicNA
         jJnNEgiJkJMXTfzZKuiceeCkTjM63l1iLTLmWQKo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NGW5lS072573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 11:32:05 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 11:32:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 11:32:04 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NGVudg099701;
        Wed, 23 Sep 2020 11:32:02 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j7200-som-p0: Add HyperFlash node
Date:   Wed, 23 Sep 2020 22:01:50 +0530
Message-ID: <20200923163150.16973-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923163150.16973-1-vigneshr@ti.com>
References: <20200923163150.16973-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J7200 SoM has a HyperFlash connected to HyperBus memory controller. But
HyperBus is muxed with OSPI, therefore keep HyperBus node disabled.
Bootloader will detect the mux and enable the node as required.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 36 +++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index f7e271c442a0..6a98ba499bc2 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -27,3 +27,39 @@ secure_ddr: optee@9e800000 {
 		};
 	};
 };
+
+&wkup_pmx0 {
+	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 1) /* (B6) MCU_OSPI0_CLK.MCU_HYPERBUS0_CK */
+			J721E_WKUP_IOPAD(0x4, PIN_OUTPUT, 1) /* (C8) MCU_OSPI0_LBCLKO.MCU_HYPERBUS0_CKn */
+			J721E_WKUP_IOPAD(0x2c, PIN_OUTPUT, 1) /* (D6) MCU_OSPI0_CSn0.MCU_HYPERBUS0_CSn0 */
+			J721E_WKUP_IOPAD(0x30, PIN_OUTPUT, 1) /* (D7) MCU_OSPI0_CSn1.MCU_HYPERBUS0_RESETn */
+			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 1) /* (B7) MCU_OSPI0_DQS.MCU_HYPERBUS0_RWDS */
+			J721E_WKUP_IOPAD(0xc, PIN_INPUT, 1) /* (D8) MCU_OSPI0_D0.MCU_HYPERBUS0_DQ0 */
+			J721E_WKUP_IOPAD(0x10, PIN_INPUT, 1) /* (C7) MCU_OSPI0_D1.MCU_HYPERBUS0_DQ1 */
+			J721E_WKUP_IOPAD(0x14, PIN_INPUT, 1) /* (C5) MCU_OSPI0_D2.MCU_HYPERBUS0_DQ2 */
+			J721E_WKUP_IOPAD(0x18, PIN_INPUT, 1) /* (A5) MCU_OSPI0_D3.MCU_HYPERBUS0_DQ3 */
+			J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 1) /* (A6) MCU_OSPI0_D4.MCU_HYPERBUS0_DQ4 */
+			J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (B8) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
+			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (A8) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
+			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
+		>;
+	};
+};
+
+&hbmc {
+	/* OSPI and HBMC are muxed inside FSS, Bootloader will enable
+	 * appropriate node based on board detection
+	 */
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_hpb0_pins_default>;
+	ranges = <0x00 0x00 0x05 0x00000000 0x4000000>, /* 64MB Flash on CS0 */
+		 <0x01 0x00 0x05 0x04000000 0x800000>; /* 8MB RAM on CS1 */
+
+	flash@0,0 {
+		compatible = "cypress,hyperflash", "cfi-flash";
+		reg = <0x00 0x00 0x4000000>;
+	};
+};
-- 
2.28.0

