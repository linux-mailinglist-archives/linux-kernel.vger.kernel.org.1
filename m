Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534CB26A42D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 13:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgIOLbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 07:31:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34358 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgIOLWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:22:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKvHS114768;
        Tue, 15 Sep 2020 06:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600168857;
        bh=OUFHtcMGlbsIVzGZ4BgYQuW1IbIYJmWfeWS2S85IW3Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DDHwJkXBkCV5MwK6ctXgEHRaObfSUBTw2P6vYHLsweNkd/QT6IaLeyk/aOrKFEn/T
         eI98Kl75n1wmfy60bwHsGUjpSAPYoUXn4duzvI8UkIJlAaMPgZy8jIkThooymmRLkU
         WOMiUeMCi8ItlcJllXkSuMYGBDRry53EOFnH3eLY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FBKvwo051142
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 06:20:57 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 06:20:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 06:20:57 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKdmF013285;
        Tue, 15 Sep 2020 06:20:55 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 6/6] arm64: dts: ti: k3-j7200-common-proc-board: Add USB support
Date:   Tue, 15 Sep 2020 14:20:38 +0300
Message-ID: <20200915112038.30219-7-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915112038.30219-1-rogerq@ti.com>
References: <20200915112038.30219-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The board uses lane 3 of SERDES for USB. Set the mux
accordingly.

The USB controller and EVM supports super-speed for USB0
on the Type-C port. However, the SERDES has a limitation
that upto 2 protocols can be used at a time. The SERDES is
wired for PCIe, QSGMII and USB super-speed. It has been
chosen to use PCI2 and QSGMII as default. So restrict
USB0 to high-speed mode.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 0ecaba600704..5ce3fddbd617 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -42,6 +42,12 @@
 			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
 		>;
 	};
+
+	main_usbss0_pins_default: main-usbss0-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x120, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -145,3 +151,19 @@
 	idle-states = <SERDES0_LANE0_PCIE1_LANE0>, <SERDES0_LANE1_PCIE1_LANE1>,
 		      <SERDES0_LANE2_QSGMII_LANE1>, <SERDES0_LANE3_IP4_UNUSED>;
 };
+
+&usb_serdes_mux {
+	idle-states = <1>; /* USB0 to SERDES lane 3 */
+};
+
+&usbss0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usbss0_pins_default>;
+	ti,vbus-divider;
+	ti,usb2-only;
+};
+
+&usb0 {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

