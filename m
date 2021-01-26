Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6DF30401A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405787AbhAZOVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:21:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52462 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405790AbhAZOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:19:56 -0500
X-UUID: fcd4be705a884c9a8f7bacc97382811f-20210126
X-UUID: fcd4be705a884c9a8f7bacc97382811f-20210126
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1333734675; Tue, 26 Jan 2021 22:19:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 26 Jan 2021 22:19:08 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jan 2021 22:19:07 +0800
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hanks.chen@mediatek.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        Mason Zhang <mason.zhang@mediatek.com>
Subject: [PATCH v1 1/1] arm64: dts: mt6779: add spi host dts nodes
Date:   Tue, 26 Jan 2021 22:02:59 +0800
Message-ID: <20210126140257.20328-2-mason.zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210126140257.20328-1-mason.zhang@mediatek.com>
References: <20210126140257.20328-1-mason.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4CE4E7E32D4DB09CE34C1EE0767A23B90274359C5A26A0CE1F30E79B405E97AF2000:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mason Zhang <Mason.Zhang@mediatek.com>

This patch adds spi dts nodes for mt6779 IC.

Signed-off-by: Mason Zhang <mason.zhang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6779.dtsi | 96 ++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
index 370f309d32de..272f4346d35e 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
@@ -219,6 +219,102 @@
 			status = "disabled";
 		};
 
+		spi0: spi0@1100a000 {
+			compatible = "mediatek,mt6779-spi",
+				     "mediatek,mt6765-spi";
+			mediatek,pad-select = <0>;
+			reg = <0 0x1100a000 0 0x1000>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
+				<&topckgen CLK_TOP_SPI>,
+				<&infracfg_ao CLK_INFRA_SPI0>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+		};
+
+		spi1: spi1@11010000 {
+			compatible = "mediatek,mt6779-spi",
+				     "mediatek,mt6765-spi";
+			mediatek,pad-select = <0>;
+			reg = <0 0x11010000 0 0x1000>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
+				<&topckgen CLK_TOP_SPI>,
+				<&infracfg_ao CLK_INFRA_SPI1>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+		};
+
+		spi2: spi2@11012000 {
+			compatible = "mediatek,mt6779-spi",
+				     "mediatek,mt6765-spi";
+			mediatek,pad-select = <0>;
+			reg = <0 0x11012000 0 0x1000>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
+				 <&topckgen CLK_TOP_SPI>,
+				<&infracfg_ao CLK_INFRA_SPI2>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+		};
+
+		spi3: spi3@11013000 {
+			compatible = "mediatek,mt6779-spi",
+				     "mediatek,mt6765-spi";
+			mediatek,pad-select = <0>;
+			reg = <0 0x11013000 0 0x1000>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
+				 <&topckgen CLK_TOP_SPI>,
+				 <&infracfg_ao CLK_INFRA_SPI3>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+		};
+
+		spi4: spi4@11018000 {
+			compatible = "mediatek,mt6779-spi",
+				     "mediatek,mt6765-spi";
+			mediatek,pad-select = <0>;
+			reg = <0 0x11018000 0 0x1000>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
+				 <&topckgen CLK_TOP_SPI>,
+				 <&infracfg_ao CLK_INFRA_SPI4>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+		};
+
+		spi5: spi5@11019000 {
+			compatible = "mediatek,mt6779-spi",
+				     "mediatek,mt6765-spi";
+			mediatek,pad-select = <0>;
+			reg = <0 0x11019000 0 0x1000>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
+				<&topckgen CLK_TOP_SPI>,
+				<&infracfg_ao CLK_INFRA_SPI5>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+		};
+
+		spi6: spi6@1101d000 {
+			compatible = "mediatek,mt6779-spi",
+				     "mediatek,mt6765-spi";
+			mediatek,pad-select = <0>;
+			reg = <0 0x1101d000 0 0x1000>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
+				 <&topckgen CLK_TOP_SPI>,
+				 <&infracfg_ao CLK_INFRA_SPI6>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+		};
+
+		spi7: spi7@1101e000 {
+			compatible = "mediatek,mt6779-spi",
+				     "mediatek,mt6765-spi";
+			mediatek,pad-select = <0>;
+			reg = <0 0x1101e000 0 0x1000>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
+				 <&topckgen CLK_TOP_SPI>,
+				 <&infracfg_ao CLK_INFRA_SPI7>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+		};
+
 		audio: clock-controller@11210000 {
 			compatible = "mediatek,mt6779-audio", "syscon";
 			reg = <0 0x11210000 0 0x1000>;
-- 
2.18.0

