Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5D280770
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbgJATGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:06:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55772 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgJATGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:06:03 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091J5uEG130858;
        Thu, 1 Oct 2020 14:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601579156;
        bh=VMQaj9CRqRv+K4B6BWMdAC2HASgVNXrT4qpDvKPO1uk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=r1riCaXNj6lRB38NX/L4zOg5o5WSFXO8jiz+v4/U5q4KIEy92ojGVFME/KquVViE0
         cEzCE29S6GDWsobNmmeLnKqAC+codZcUmBNtspWZwTWHiAEcqbrRBjdjbGzlu2XmtL
         gkvIs2af8gXWKW+lIrNbSmH79OqfSkXrIifdefyA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091J5uw1010428
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 14:05:56 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 14:05:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 14:05:55 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091J5gYm070134;
        Thu, 1 Oct 2020 14:05:51 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 1/8] arm64: dts: ti: k3-j7200-main: Add gpio nodes in main domain
Date:   Fri, 2 Oct 2020 00:35:34 +0530
Message-ID: <20201001190541.6364-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001190541.6364-1-faiz_abbas@ti.com>
References: <20201001190541.6364-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 instances of gpio modules in main domain:
	gpio0, gpio2, gpio4 and gpio6

Groups are created to provide protection between different processor virtual
worlds. Each of these modules I/O pins are muxed within the group. Exactly
one module can be selected to control the corresponding pin by selecting it
in the pad mux configuration registers.

This group pins out 69 lines (5 banks).

Add DT modes for each module instance in the main domain.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 68 +++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 4a4fcd24f852..f21f22237e0f 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -395,4 +395,72 @@
 		no-1-8-v;
 		dma-coherent;
 	};
+
+	main_gpio0: gpio@600000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00600000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <145>, <146>, <147>, <148>,
+			     <149>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <69>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 105 0>;
+		clock-names = "gpio";
+	};
+
+	main_gpio2: gpio@610000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00610000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <154>, <155>, <156>, <157>,
+			     <158>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <69>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 107 0>;
+		clock-names = "gpio";
+	};
+
+	main_gpio4: gpio@620000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00620000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <163>, <164>, <165>, <166>,
+			     <167>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <69>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 109 0>;
+		clock-names = "gpio";
+	};
+
+	main_gpio6: gpio@630000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00630000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <172>, <173>, <174>, <175>,
+			     <176>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <69>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 111 0>;
+		clock-names = "gpio";
+	};
 };
-- 
2.17.1

