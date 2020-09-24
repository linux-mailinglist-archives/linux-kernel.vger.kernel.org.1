Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D52276FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgIXL0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:26:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42066 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgIXL0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:26:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OBQpj5048676;
        Thu, 24 Sep 2020 06:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600946811;
        bh=11wNPHCeJzmpb4xamhc1BKOrVzXfCXolK5BtoFQqmgk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J9iBre6gZC/FNJGAIXppL/U14rQBbUAL9ap28N/UrvY4EvPhriDACZ/u0KNynUBWQ
         zJbdWC0cTQab8BgMEf8I5CD4ew0/Dq0dxVtXPZzAh5S5TPGCHrUdCWkaOrqKv35js+
         91oJqBlyPVLGU5M7NbhYVzhDcp8jAaMPSHGABaYU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08OBQpPn126146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 06:26:51 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 06:26:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 06:26:51 -0500
Received: from a0230074-OptiPlex-7010.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OBQjMQ036450;
        Thu, 24 Sep 2020 06:26:48 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j7200-main: Add support for MMC/SD controller nodes
Date:   Thu, 24 Sep 2020 16:56:43 +0530
Message-ID: <20200924112644.11076-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924112644.11076-1-faiz_abbas@ti.com>
References: <20200924112644.11076-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MMC/SD controller nodes present on TI's j7200 SoCs.

There are two nodes:
        1. sdhci0 (8 bit bus width, 200 MHz, HS200, 200 MBps)
        2. sdhci1 (4 bit bus width, 50 MHz, HS, 25 MBps)

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index f44f0b83d12a..e613f5d94281 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -310,4 +310,41 @@
 		clocks = <&k3_clks 193 1>;
 		power-domains = <&k3_pds 193 TI_SCI_PD_EXCLUSIVE>;
 	};
+
+	main_sdhci0: mmc@4f80000 {
+		compatible = "ti,j7200-sdhci-8bit", "ti,j721e-sdhci-8bit";
+		reg = <0x00 0x04f80000 0x00 0x260>, <0x00 0x4f88000 0x00 0x134>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 91 TI_SCI_PD_EXCLUSIVE>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&k3_clks 91 3>, <&k3_clks 91 0>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-ddr52 = <0x6>;
+		ti,otap-del-sel-hs200 = <0x8>;
+		ti,otap-del-sel-hs400 = <0x0>;
+		ti,strobe-sel = <0x77>;
+		ti,trm-icp = <0x8>;
+		bus-width = <8>;
+		mmc-ddr-1_8v;
+		dma-coherent;
+	};
+
+	main_sdhci1: mmc@4fb0000 {
+		compatible = "ti,j7200-sdhci-4bit", "ti,j721e-sdhci-4bit";
+		reg = <0x00 0x04fb0000 0x00 0x260>, <0x00 0x4fb8000 0x00 0x134>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 92 TI_SCI_PD_EXCLUSIVE>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&k3_clks 92 2>, <&k3_clks 92 1>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x5>;
+		ti,otap-del-sel-ddr50 = <0xc>;
+		no-1-8-v;
+		dma-coherent;
+	};
 };
-- 
2.17.1

