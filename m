Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E92276FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgIXL07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:26:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42078 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgIXL06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:26:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OBQsDh048694;
        Thu, 24 Sep 2020 06:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600946814;
        bh=UEcMGhKI+YhMDZDvZCTGlkUejh5uBTzr0IJIMk1v4Y0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=c3dOrUCAm37WZufTauefmcFeblStpSl4Zz8DQ5MBabXSqxCrU9Nx0fAGLBCELP2ns
         XI6t5dk6KQYoTtfRmODPcqKk9lfE6RUky+HMp7fvb7Lh/xvj/v6pqccXbBgP7JcVXv
         yRiV0+v4g/gOOETuGRYG4y8az+KkmtOQ3NBNo3iU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08OBQspd126181
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 06:26:54 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 06:26:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 06:26:53 -0500
Received: from a0230074-OptiPlex-7010.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OBQjMR036450;
        Thu, 24 Sep 2020 06:26:51 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j7200-common-proc-board: Add support for eMMC and SD card
Date:   Thu, 24 Sep 2020 16:56:44 +0530
Message-ID: <20200924112644.11076-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924112644.11076-1-faiz_abbas@ti.com>
References: <20200924112644.11076-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the eMMC and SD card connected on the common
processor board

sdhci0 is connected to an eMMC while sdhci1 is connected to the
micro SD slot.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 03c8817e8745..794241ba74cb 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -28,6 +28,19 @@
 			J721E_IOPAD(0xe0, PIN_INPUT_PULLUP, 3) /* (T3) EXT_REFCLK1.I2C1_SDA */
 		>;
 	};
+
+	main_mmc1_pins_default: main-mmc1-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x104, PIN_INPUT, 0) /* (M20) MMC1_CMD */
+			J721E_IOPAD(0x100, PIN_INPUT, 0) /* (P21) MMC1_CLK */
+			J721E_IOPAD(0xfc, PIN_INPUT, 0) /* (P25) MMC1_CLKLB */
+			J721E_IOPAD(0xf8, PIN_INPUT, 0) /* (M19) MMC1_DAT0 */
+			J721E_IOPAD(0xf4, PIN_INPUT, 0) /* (N21) MMC1_DAT1 */
+			J721E_IOPAD(0xf0, PIN_INPUT, 0) /* (N20) MMC1_DAT2 */
+			J721E_IOPAD(0xec, PIN_INPUT, 0) /* (N19) MMC1_DAT3 */
+			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -112,3 +125,18 @@
 		#gpio-cells = <2>;
 	};
 };
+
+&main_sdhci0 {
+	/* eMMC */
+	non-removable;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&main_sdhci1 {
+	/* SD card */
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	pinctrl-names = "default";
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
-- 
2.17.1

