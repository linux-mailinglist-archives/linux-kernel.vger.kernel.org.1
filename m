Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29635280773
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbgJATGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:06:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48486 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgJATGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:06:09 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091J61Se034244;
        Thu, 1 Oct 2020 14:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601579161;
        bh=qYTTQbTB8PlAUeUwgVAQod+Mm/LCHhA1aBjNXoABK4U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=r786lTQjSdm6wr0XGUeHeNNLkb5NRs1TZi2CZTHTpx0Evb/tPyEha0MewnVqLbixI
         bNM6bgH2WjYaPBVW5tx2ZyW4LcL36tUCjwLOwecinrGzpTngKUgVeFH/6NShW0uRZ5
         dIslR/Qid/mfCks3mvYBrnbooAIGzT3QZZdfTIx0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091J61jU091363
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 14:06:01 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 14:06:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 14:06:00 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091J5gYn070134;
        Thu, 1 Oct 2020 14:05:56 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 2/8] arm64: dts: ti: k3-j7200: Add gpio nodes in wakeup domain
Date:   Fri, 2 Oct 2020 00:35:35 +0530
Message-ID: <20201001190541.6364-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001190541.6364-1-faiz_abbas@ti.com>
References: <20201001190541.6364-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the gpio groups in main domain, there is one gpio group in
wakeup domain with 2 mdoules instances in it. The gpio group pins out
73 pins (5 banks). Add DT nodes for these 2 gpio module instances.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index eb2a78a53512..5ee64d4ee41f 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -107,6 +107,38 @@
 		ti,interrupt-ranges = <16 960 16>;
 	};
 
+	wkup_gpio0: gpio@42110000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x42110000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&wkup_gpio_intr>;
+		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <73>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 113 0>;
+		clock-names = "gpio";
+	};
+
+	wkup_gpio1: gpio@42100000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x42100000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&wkup_gpio_intr>;
+		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <73>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 114 0>;
+		clock-names = "gpio";
+	};
+
 	mcu_navss: bus@28380000 {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
-- 
2.17.1

