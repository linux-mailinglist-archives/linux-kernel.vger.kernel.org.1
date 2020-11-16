Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6CA2B54D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgKPXOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbgKPXOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:14:33 -0500
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0D224199;
        Mon, 16 Nov 2020 23:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605568472;
        bh=h3+mUtrGjgFWVd51cekdL8zKtNdHp5fXFTRrikmF17Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2r0T5sXajj7j5c+MJXVo9R2w7YPpkwEf4/qM7wdJpyHMOP2wIFKdJwMh9iqfXzDI2
         mur4iWcPzswXVHQokMC4e5aA8PsDmKyOMkvZKmvEdz2QvrHQcvT8PweWFrdS86eC7R
         UsQcUKolwFqqVq5F0sMjYanFeaJfNzSzNU5VQZto=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [RESEND PATCH 2/3] phy: mediatek: Move mtk_mipi_dsi_phy driver into drivers/phy/mediatek folder
Date:   Tue, 17 Nov 2020 07:14:06 +0800
Message-Id: <20201116231407.94-3-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116231407.94-1-chunkuang.hu@kernel.org>
References: <20201116231407.94-1-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_mipi_dsi_phy is currently placed inside mediatek drm driver, but it's
more suitable to place a phy driver into phy driver folder, so move
mtk_mipi_dsi_phy driver into phy driver folder.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/Kconfig                           | 7 -------
 drivers/gpu/drm/mediatek/Makefile                          | 6 ------
 drivers/phy/mediatek/Kconfig                               | 7 +++++++
 drivers/phy/mediatek/Makefile                              | 5 +++++
 .../mediatek/phy-mtk-mipi-dsi-mt8173.c}                    | 2 +-
 .../mediatek/phy-mtk-mipi-dsi-mt8183.c}                    | 2 +-
 .../mtk_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi.c}      | 2 +-
 .../mtk_mipi_tx.h => phy/mediatek/phy-mtk-mipi-dsi.h}      | 0
 8 files changed, 15 insertions(+), 16 deletions(-)
 rename drivers/{gpu/drm/mediatek/mtk_mt8173_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi-mt8173.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_mt8183_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi-mt8183.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.h => phy/mediatek/phy-mtk-mipi-dsi.h} (100%)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 24c4890a6e65..2976d21e9a34 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -28,10 +28,3 @@ config DRM_MEDIATEK_HDMI
 	select PHY_MTK_HDMI
 	help
 	  DRM/KMS HDMI driver for Mediatek SoCs
-
-config PHY_MTK_MIPI_DSI
-	tristate "Mediatek MIPI-DSI-PHY Driver"
-	depends on ARCH_MEDIATEK && OF
-	select GENERIC_PHY
-	help
-	  Support MIPI DSI PHY for Mediatek SoCs.
diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index baa188000543..a892edec5563 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -19,9 +19,3 @@ mediatek-drm-hdmi-objs := mtk_cec.o \
 			  mtk_hdmi_ddc.o
 
 obj-$(CONFIG_DRM_MEDIATEK_HDMI) += mediatek-drm-hdmi.o
-
-phy-mtk-mipi-dsi-drv-objs := mtk_mipi_tx.o \
-			     mtk_mt8173_mipi_tx.o \
-			     mtk_mt8183_mipi_tx.o
-
-obj-$(CONFIG_PHY_MTK_MIPI_DSI) += phy-mtk-mipi-dsi-drv.o
diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 50c5e9306e19..574b8e6398d2 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -42,3 +42,10 @@ config PHY_MTK_HDMI
 	select GENERIC_PHY
 	help
 	  Support HDMI PHY for Mediatek SoCs.
+
+config PHY_MTK_MIPI_DSI
+	tristate "MediaTek MIPI-DSI Driver"
+	depends on ARCH_MEDIATEK && OF
+	select GENERIC_PHY
+	help
+	  Support MIPI DSI for Mediatek SoCs.
diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
index 6325e38709ed..ace660fbed3a 100644
--- a/drivers/phy/mediatek/Makefile
+++ b/drivers/phy/mediatek/Makefile
@@ -11,3 +11,8 @@ phy-mtk-hdmi-drv-y			:= phy-mtk-hdmi.o
 phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt2701.o
 phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt8173.o
 obj-$(CONFIG_PHY_MTK_HDMI)		+= phy-mtk-hdmi-drv.o
+
+phy-mtk-mipi-dsi-drv-y			:= phy-mtk-mipi-dsi.o
+phy-mtk-mipi-dsi-drv-y			+= phy-mtk-mipi-dsi-mt8173.o
+phy-mtk-mipi-dsi-drv-y			+= phy-mtk-mipi-dsi-mt8183.o
+obj-$(CONFIG_PHY_MTK_MIPI_DSI)		+= phy-mtk-mipi-dsi-drv.o
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
similarity index 99%
rename from drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
rename to drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
index f18db14d8b63..7a847954594f 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
@@ -4,7 +4,7 @@
  * Author: jitao.shi <jitao.shi@mediatek.com>
  */
 
-#include "mtk_mipi_tx.h"
+#include "phy-mtk-mipi-dsi.h"
 
 #define MIPITX_DSI_CON		0x00
 #define RG_DSI_LDOCORE_EN		BIT(0)
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
similarity index 99%
rename from drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
rename to drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
index 9f3e55aeebb2..99108426d57c 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
@@ -4,7 +4,7 @@
  * Author: jitao.shi <jitao.shi@mediatek.com>
  */
 
-#include "mtk_mipi_tx.h"
+#include "phy-mtk-mipi-dsi.h"
 
 #define MIPITX_LANE_CON		0x000c
 #define RG_DSI_CPHY_T1DRV_EN		BIT(0)
diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
similarity index 99%
rename from drivers/gpu/drm/mediatek/mtk_mipi_tx.c
rename to drivers/phy/mediatek/phy-mtk-mipi-dsi.c
index f2a892e16c27..18c481251f04 100644
--- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2015 MediaTek Inc.
  */
 
-#include "mtk_mipi_tx.h"
+#include "phy-mtk-mipi-dsi.h"
 
 inline struct mtk_mipi_tx *mtk_mipi_tx_from_clk_hw(struct clk_hw *hw)
 {
diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
similarity index 100%
rename from drivers/gpu/drm/mediatek/mtk_mipi_tx.h
rename to drivers/phy/mediatek/phy-mtk-mipi-dsi.h
-- 
2.17.1

