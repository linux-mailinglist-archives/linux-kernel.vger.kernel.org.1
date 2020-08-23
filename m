Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F1D24EACC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 03:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHWBsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 21:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgHWBst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 21:48:49 -0400
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDA462173E;
        Sun, 23 Aug 2020 01:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598147328;
        bh=wR6gn5yGrKnL5wxGbxgqCjb6y52GlqGRAiBOKRoCeJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nE5HMsabATXc6P6Zg9YJOr7E0BXJPCfg7oXx2RMByalZCHYahLCWhVU17fXZnInrq
         gf5Pll1dB8jn6AXrfE9LcUdjh65ukAGfxRrZb3oLqkm52MUkGd2/5TrOktraGyVeiP
         yrW4UnOQDD847up250ink7vCD3CI3qZ3OcHj7ciA=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v5 2/4] drm/mediatek: Separate mtk_hdmi_phy to an independent module
Date:   Sun, 23 Aug 2020 09:48:28 +0800
Message-Id: <20200823014830.15962-3-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823014830.15962-1-chunkuang.hu@kernel.org>
References: <20200823014830.15962-1-chunkuang.hu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CK Hu <ck.hu@mediatek.com>

mtk_hdmi_phy is a part of mtk_hdmi module, but phy driver should be an
independent module rather than be part of drm module, so separate the phy
driver to an independent module.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/Kconfig        |  9 ++++++++-
 drivers/gpu/drm/mediatek/Makefile       | 11 +++++++----
 drivers/gpu/drm/mediatek/mtk_hdmi.c     |  2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.h     |  1 -
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c |  1 +
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h |  1 -
 6 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index aa74aac3cbcc..6363f2c1cdbc 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -24,6 +24,13 @@ config DRM_MEDIATEK_HDMI
 	tristate "DRM HDMI Support for Mediatek SoCs"
 	depends on DRM_MEDIATEK
 	select SND_SOC_HDMI_CODEC if SND_SOC
-	select GENERIC_PHY
+	select PHY_MTK_HDMI
 	help
 	  DRM/KMS HDMI driver for Mediatek SoCs
+
+config PHY_MTK_HDMI
+	tristate "MediaTek HDMI-PHY Driver"
+	depends on ARCH_MEDIATEK && OF
+	select GENERIC_PHY
+	help
+	  Support HDMI PHY for Mediatek SoCs.
diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index b7a82ed5788f..fcbef23aa6ce 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -19,9 +19,12 @@ obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
 
 mediatek-drm-hdmi-objs := mtk_cec.o \
 			  mtk_hdmi.o \
-			  mtk_hdmi_ddc.o \
-			  mtk_mt2701_hdmi_phy.o \
-			  mtk_mt8173_hdmi_phy.o \
-			  mtk_hdmi_phy.o
+			  mtk_hdmi_ddc.o
 
 obj-$(CONFIG_DRM_MEDIATEK_HDMI) += mediatek-drm-hdmi.o
+
+phy-mtk-hdmi-drv-objs := mtk_hdmi_phy.o \
+			 mtk_mt2701_hdmi_phy.o \
+			 mtk_mt8173_hdmi_phy.o
+
+obj-$(CONFIG_PHY_MTK_HDMI) += phy-mtk-hdmi-drv.o
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index d44348c7ecbe..0ed7b0b1a022 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_platform.h>
 #include <linux/of.h>
@@ -1832,7 +1833,6 @@ static struct platform_driver mtk_hdmi_driver = {
 };
 
 static struct platform_driver * const mtk_hdmi_drivers[] = {
-	&mtk_hdmi_phy_driver,
 	&mtk_hdmi_ddc_driver,
 	&mtk_cec_driver,
 	&mtk_hdmi_driver,
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.h b/drivers/gpu/drm/mediatek/mtk_hdmi.h
index bb3653de6bd1..472bf141c92b 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.h
@@ -5,7 +5,6 @@
  */
 #ifndef _MTK_HDMI_CTRL_H
 #define _MTK_HDMI_CTRL_H
-#include "mtk_hdmi_phy.h"
 
 struct platform_driver;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
index 5223498502c4..fe022acddbef 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -205,6 +205,7 @@ struct platform_driver mtk_hdmi_phy_driver = {
 		.of_match_table = mtk_hdmi_phy_match,
 	},
 };
+module_platform_driver(mtk_hdmi_phy_driver);
 
 MODULE_DESCRIPTION("MediaTek HDMI PHY Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
index fc1c2efd1128..b13e1d5f8e78 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
@@ -49,7 +49,6 @@ void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 		       u32 val, u32 mask);
 struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
 
-extern struct platform_driver mtk_hdmi_phy_driver;
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf;
 
-- 
2.17.1

