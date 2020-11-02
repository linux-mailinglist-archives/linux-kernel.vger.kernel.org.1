Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DC22A33C4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgKBTN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:13:29 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56610 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgKBTN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:13:27 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2JDMDS083819;
        Mon, 2 Nov 2020 13:13:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604344402;
        bh=63JspDh+dZQIom5FV7gdIqvrJxjj+uV402skXAN0Vvw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HX8jc6K3b0p4XsasL3IEv7ACQgP8hwcP4nWpvcGct6v5meENI6VyAcYE9XfeOygMk
         qPQ4drhq16Cdtdaj+Yin8zWhz5uNfKhMXfXho3SlYvuaoT+czDhmjyFtofo11uAbYJ
         vd9K4K628IHm+5Tcw4gGxRGmES7PAX9zmY9GK+fU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2JDMRS094644
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 13:13:22 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 13:11:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 13:11:28 -0600
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2JBLoO093265;
        Mon, 2 Nov 2020 13:11:25 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-j7200-main: Add gpio nodes in main domain
Date:   Tue, 3 Nov 2020 00:41:18 +0530
Message-ID: <20201102191120.20380-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102191120.20380-1-faiz_abbas@ti.com>
References: <20201102191120.20380-1-faiz_abbas@ti.com>
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
index 72d6496e88dd..c22ef2efa531 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -446,4 +446,72 @@
 			dr_mode = "otg";
 		};
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

