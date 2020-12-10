Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52BF2D5588
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbgLJIfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:35:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45367 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729351AbgLJIfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:35:32 -0500
X-UUID: cf6b36a02dd947c49464bc1ce409b13b-20201210
X-UUID: cf6b36a02dd947c49464bc1ce409b13b-20201210
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 172720356; Thu, 10 Dec 2020 16:34:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Dec 2020 16:34:46 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Dec 2020 16:34:46 +0800
From:   Bayi Cheng <bayi.cheng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        <srv_heupstream@mediatek.com>, bayi cheng <bayi.cheng@mediatek.com>
Subject: [PATCH v1] arm64: dts: mt8192: add nor_flash device node
Date:   Thu, 10 Dec 2020 16:34:43 +0800
Message-ID: <1607589283-31225-1-git-send-email-bayi.cheng@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: bayi cheng <bayi.cheng@mediatek.com>

add nor_flash device node

Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index e12e024..b15b0d3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -379,6 +379,19 @@
 			status = "disabled";
 		};
 
+		nor_flash: spi@11234000 {
+			compatible = "mediatek,mt8173-nor";
+			reg = <0 0x11234000 0 0xe0>;
+			interrupts = <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>,
+				 <&clk26m>,
+				 <&clk26m>;
+			clock-names = "spi", "sf", "axi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disable";
+		};
+
 		i2c3: i2c3@11cb0000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11cb0000 0 0x1000>,
-- 
1.9.1

