Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A422DF92A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 07:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgLUGLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 01:11:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56924 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728443AbgLUGLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 01:11:48 -0500
X-UUID: 4fc8586b7ce94992b1318b4df1639f56-20201221
X-UUID: 4fc8586b7ce94992b1318b4df1639f56-20201221
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yz.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 830547753; Mon, 21 Dec 2020 14:11:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Dec 2020 14:11:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Dec 2020 14:11:08 +0800
From:   <Yz.Wu@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Seiya Wang <seiya.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Ryan Wu <Yz.Wu@mediatek.com>
Subject: [PATCH v3 2/2] arm64: dts: mt8192: add eFuse support for MT8192 SoC
Date:   Mon, 21 Dec 2020 14:10:21 +0800
Message-ID: <20201221061018.18503-3-Yz.Wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201221061018.18503-1-Yz.Wu@mediatek.com>
References: <20201221061018.18503-1-Yz.Wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wu <Yz.Wu@mediatek.com>

Add eFuse node to read Mediatek eFuse

Signed-off-by: Ryan Wu <Yz.Wu@mediatek.com>
---
This patch dependents on "arm64: dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile"[1]

mt8192.dtsi file is needed for this patch.
Please also accept this patch together with [1].

[1]http://lists.infradead.org/pipermail/linux-mediatek/2020-November/019378.html
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 69d45c7b31f1..4a0d941aec30 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -422,6 +422,11 @@
 			#clock-cells = <1>;
 		};
 
+		efuse: efuse@11c10000 {
+			compatible = "mediatek,mt8192-efuse",
+				     "mediatek,efuse";
+		};
+
 		i2c3: i2c3@11cb0000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11cb0000 0 0x1000>,
-- 
2.18.0

