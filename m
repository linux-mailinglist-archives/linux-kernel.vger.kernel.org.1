Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF712E9175
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbhADIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:09:17 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39032 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726148AbhADIJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:09:15 -0500
X-UUID: 2c06a6e8e7a74b77aba652c0719cff31-20210104
X-UUID: 2c06a6e8e7a74b77aba652c0719cff31-20210104
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <argus.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1553604183; Mon, 04 Jan 2021 16:08:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 4 Jan 2021 16:08:27 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Jan 2021 16:08:27 +0800
From:   Argus Lin <argus.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, <agx@sigxcpu.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        <argus.lin@mediatek.com>, <wsd_upstream@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] arm64: dts: mt6779: Support pwrap on Mediatek MT6779 platform
Date:   Mon, 4 Jan 2021 16:08:22 +0800
Message-ID: <1609747703-27207-2-git-send-email-argus.lin@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1609747703-27207-1-git-send-email-argus.lin@mediatek.com>
References: <1609747703-27207-1-git-send-email-argus.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B5E2311454F972D50E54BD2B1B1D08953A845227831B9A15705D68728BC699002000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support pwrap on Mediatek MT6779 platform by adding pwrap node in dts file.

Signed-off-by: Argus Lin <argus.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6779.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
index 370f309..2c2ca33 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
@@ -189,6 +189,15 @@
 			#clock-cells = <1>;
 		};

+		pwrap: pwrap@1000d000 {
+			compatible = "mediatek,mt6779-pwrap";
+			reg = <0 0x1000d000 0 0x1000>;
+			reg-names = "pwrap";
+			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_PMIC_AP>;
+			clock-names = "spi", "wrap";
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt6779-uart",
 				     "mediatek,mt6577-uart";
--
1.8.1.1.dirty

