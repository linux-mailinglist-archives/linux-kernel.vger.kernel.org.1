Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D680260FA8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 12:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgIHK0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 06:26:54 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56212 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729496AbgIHK0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:26:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A2CB2011AF;
        Tue,  8 Sep 2020 12:26:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DDE720119C;
        Tue,  8 Sep 2020 12:26:07 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 742C420327;
        Tue,  8 Sep 2020 12:26:06 +0200 (CEST)
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
Subject: [PATCH v3 02/14] dt-bindings: reset: imx8mp: Add audio blk_ctl reset IDs
Date:   Tue,  8 Sep 2020 13:24:39 +0300
Message-Id: <1599560691-3763-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
References: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be used by the imx8mp for blk_ctl driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/dt-bindings/reset/imx8mp-reset.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/reset/imx8mp-reset.h b/include/dt-bindings/reset/imx8mp-reset.h
index 2e8c910..6c7f17f 100644
--- a/include/dt-bindings/reset/imx8mp-reset.h
+++ b/include/dt-bindings/reset/imx8mp-reset.h
@@ -47,4 +47,9 @@
 
 #define IMX8MP_RESET_NUM			38
 
+#define IMX8MP_AUDIO_BLK_CTL_EARC_RESET		0
+#define IMX8MP_AUDIO_BLK_CTL_EARC_PHY_RESET	1
+
+#define IMX8MP_AUDIO_BLK_CTL_RESET_NUM		2
+
 #endif
-- 
2.7.4

