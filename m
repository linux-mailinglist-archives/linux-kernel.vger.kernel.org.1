Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9A260FB6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 12:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgIHK1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 06:27:38 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57122 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729561AbgIHK0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:26:40 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9154E2011C3;
        Tue,  8 Sep 2020 12:26:15 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 843B120025C;
        Tue,  8 Sep 2020 12:26:15 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C812B2036D;
        Tue,  8 Sep 2020 12:26:14 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, devicetree@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 13/14] arm64: dts: imx8mp: Add media_blk_ctl node
Date:   Tue,  8 Sep 2020 13:24:50 +0300
Message-Id: <1599560691-3763-14-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
References: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the features of the media_ctl will be used by some
different drivers in a way those drivers will know best, so adding the
syscon compatible we allow those to do just that. Only the resets
and the clocks are registered bit the clk-blk-ctl driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 3541fd9..3a5ccef 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -736,6 +736,21 @@
 			};
 		};
 
+		aips4: bus@32c00000 {
+			compatible = "simple-bus";
+			reg = <0x32c00000 0x400000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			media_blk_ctl: clock-controller@32ec0000 {
+				compatible = "fsl,imx8mp-media-blk-ctl", "syscon";
+				reg = <0x32ec0000 0x10000>;
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+		};
+
 		aips5: bus@30c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x30c00000 0x400000>;
-- 
2.7.4

