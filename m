Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19132A43F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgKCLTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:19:21 -0500
Received: from inva020.nxp.com ([92.121.34.13]:38212 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgKCLTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:19:15 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A38F1A08FC;
        Tue,  3 Nov 2020 12:19:13 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B64F1A087F;
        Tue,  3 Nov 2020 12:19:13 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 88AF12033F;
        Tue,  3 Nov 2020 12:19:12 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 03/14] dt-bindings: clock: imx8mp: Add ids for the audio shared gate
Date:   Tue,  3 Nov 2020 13:18:15 +0200
Message-Id: <1604402306-5348-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these IDs are for one single HW gate (CCGR101) that is shared
between these root clocks.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/dt-bindings/clock/imx8mp-clock.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 89c67b7..5fc2c40 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -322,7 +322,17 @@
 #define IMX8MP_CLK_HSIO_AXI			311
 #define IMX8MP_CLK_MEDIA_ISP			312
 
-#define IMX8MP_CLK_END				313
+#define IMX8MP_CLK_AUDIO_AHB_ROOT		313
+#define IMX8MP_CLK_AUDIO_AXI_ROOT		314
+#define IMX8MP_CLK_SAI1_ROOT			315
+#define IMX8MP_CLK_SAI2_ROOT			316
+#define IMX8MP_CLK_SAI3_ROOT			317
+#define IMX8MP_CLK_SAI5_ROOT			318
+#define IMX8MP_CLK_SAI6_ROOT			319
+#define IMX8MP_CLK_SAI7_ROOT			320
+#define IMX8MP_CLK_PDM_ROOT			321
+
+#define IMX8MP_CLK_END				322
 
 #define IMX8MP_CLK_AUDIO_BLK_CTL_SAI1_IPG		0
 #define IMX8MP_CLK_AUDIO_BLK_CTL_SAI1_MCLK1		1
-- 
2.7.4

