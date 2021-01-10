Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A7C2F087F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 17:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbhAJQ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 11:56:35 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:35348 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbhAJQ4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 11:56:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id DB287FB03;
        Sun, 10 Jan 2021 17:55:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZM3TsJHU2O_u; Sun, 10 Jan 2021 17:55:51 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 3C0AD40885; Sun, 10 Jan 2021 17:55:51 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mq: Add clock parents for mipi dphy
Date:   Sun, 10 Jan 2021 17:55:51 +0100
Message-Id: <bc2da4ab8322d5e8a44018633e0220e08d70e72e.1610297714.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes sure the clock tree setup for the dphy is not dependent on
other components.

Without this change bringing up the display can fail like

  kernel: phy phy-30a00300.dphy.2: Invalid CM/CN/CO values: 165/217/1
  kernel: phy phy-30a00300.dphy.2: for hs_clk/ref_clk=451656000/593999998 ~ 165/217

if LCDIF doesn't set up that part of the clock tree first. This was
noticed when testing the Librem 5 devkit with defconfig. It doesn't
happen when modules are built in.

Signed-off-by: Guido Günther <agx@sigxcpu.org>

---
Changes from v1:
- as per review comment from Shawn Guo
  https://lore.kernel.org/linux-arm-kernel/20210110124629.GO28365@dragon/
  Set clock rate for IMX8MQ_VIDEO_PLL1 too. Otherwise we end up with
  a close but not exact clock rate.

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index a841a023e8e0..50ae17f65a51 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1016,9 +1016,14 @@ dphy: dphy@30a00300 {
 				reg = <0x30a00300 0x100>;
 				clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
 				clock-names = "phy_ref";
-				assigned-clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
-				assigned-clock-parents = <&clk IMX8MQ_VIDEO_PLL1_OUT>;
-				assigned-clock-rates = <24000000>;
+				assigned-clocks = <&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
+						  <&clk IMX8MQ_VIDEO_PLL1_BYPASS>,
+						  <&clk IMX8MQ_CLK_DSI_PHY_REF>,
+						  <&clk IMX8MQ_VIDEO_PLL1>;
+				assigned-clock-parents = <&clk IMX8MQ_CLK_25M>,
+						  <&clk IMX8MQ_VIDEO_PLL1>,
+						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
+				assigned-clock-rates = <0>, <0>, <24000000>, <594000000>;
 				#phy-cells = <0>;
 				power-domains = <&pgc_mipi>;
 				status = "disabled";
-- 
2.29.2

