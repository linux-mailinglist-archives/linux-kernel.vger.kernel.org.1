Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AED1A959B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 10:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635451AbgDOIEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 04:04:42 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40246 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635407AbgDOIDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:03:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 047231A07A9;
        Wed, 15 Apr 2020 10:03:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EBB7E1A07AC;
        Wed, 15 Apr 2020 10:03:11 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5431B202B0;
        Wed, 15 Apr 2020 10:03:11 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 10/13] arm64: dts: imx8mp: Add audiomix clock controller node
Date:   Wed, 15 Apr 2020 11:02:50 +0300
Message-Id: <1586937773-5836-11-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the audiomix clock controller as part of the audiomix MFD.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 3e4c376..03ace7f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -659,6 +659,17 @@
 			audiomix: audiomix@30e20000 {
 				compatible = "fsl,imx8mp-mix";
 				reg = <0x30e20000 0x10000>;
+
+				audiomix_clk: clock-controller {
+					compatible = "fsl,imx8mp-audiomix-clk";
+					#clock-cells = <1>;
+					clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
+						 <&clk IMX8MP_CLK_AUDIO_AHB>,
+						 <&clk IMX8MP_CLK_AUDIO_AXI_DIV>;
+					clock-names = "audio_root",
+						      "audio_ahb",
+						      "audio_axi_div";
+				};
 			};
 		};
 
-- 
2.7.4

